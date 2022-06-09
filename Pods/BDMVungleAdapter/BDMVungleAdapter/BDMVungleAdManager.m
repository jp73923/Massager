//
//  BDMVungleAdManager.m
//  BDMVungleAdapter
//
//  Created by Ilia Lozhkin on 06.07.2021.
//  Copyright © 2021 Stas Kochkin. All rights reserved.
//

#import "BDMVungleAdManager.h"

@import StackFoundation;

@interface BDMVungleAdManager() <VungleSDKDelegate, VungleSDKHBDelegate>

@property (nonatomic,   copy) NSString *appId;
@property (nonatomic,   copy) BDMInitializeBiddingNetworkBlock initialisationCompletion;
@property (nonatomic, strong) NSHashTable <id<BDMVungleAd>> *adMap;

@end

@implementation BDMVungleAdManager

- (instancetype)init {
    if (self = [super init]) {
        _adMap = [NSHashTable weakObjectsHashTable];
    }
    return self;
}

- (void)initializeWithAppId:(NSString *)appId completion:(BDMInitializeBiddingNetworkBlock)completion {
    [self syncMetadata];
    if ([VungleSDK.sharedSDK isInitialized]) {
        STK_RUN_BLOCK(completion, NO, nil);
        return;
    }
    
    if (!appId) {
        NSError *error = [NSError bdm_errorWithCode:BDMErrorCodeInternal description:@"Vungle app id is not valid string"];
        STK_RUN_BLOCK(completion, YES, error);
        return;
    }
    
    NSError *error = nil;
    
    self.appId = appId;
    self.initialisationCompletion = completion;
    
    VungleSDK.sharedSDK.delegate = self;
    VungleSDK.sharedSDK.sdkHBDelegate = self;
    [VungleSDK.sharedSDK startWithAppId:appId error:&error];
    
    if (error) {
        self.initialisationCompletion = nil;
        BDMLog(@"Vungle initialisation failed with error: %@", error);
        STK_RUN_BLOCK(completion, YES, error);
    }
}

- (void)collectParams:(NSString *)placement completion:(BDMCollectBiddingParamtersBlock)completion {
    NSString *token = [VungleSDK.sharedSDK currentSuperToken];
    
    if (!placement || !token) {
        NSError *error = [NSError bdm_errorWithCode:BDMErrorCodeInternal description:@"Vungle placement id or token is not valid string"];
        STK_RUN_BLOCK(completion, nil, error);
        return;
    }
    
    NSDictionary *bidding = @{ BDMVunglePlacementIDKey  : placement,
                               BDMVungleTokenKey        : token,
                               BDMVungleAppIDKey        : self.appId };
    
    STK_RUN_BLOCK(completion, bidding, nil);
}

- (void)registerAd:(id<BDMVungleAd>)ad {
    [self.adMap addObject:ad];
}

#pragma mark - Private

- (void)syncMetadata {
    if (BDMSdk.sharedSdk.restrictions.subjectToGDPR) {
        VungleConsentStatus status = BDMSdk.sharedSdk.restrictions.hasConsent ? VungleConsentAccepted : VungleConsentDenied;
        [VungleSDK.sharedSDK updateConsentStatus:status consentMessageVersion:@""];
    }
    
    if (BDMSdk.sharedSdk.restrictions.subjectToCCPA) {
        VungleCCPAStatus status = BDMSdk.sharedSdk.restrictions.hasCCPAConsent ? VungleCCPAAccepted : VungleCCPADenied;
        [VungleSDK.sharedSDK updateCCPAStatus:status];
    }
    
    [VungleSDK.sharedSDK setLoggingEnabled:BDMSdkLoggingEnabled];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [[VungleSDK sharedSDK] performSelector:@selector(setPluginName:version:) withObject:@"appodeal" withObject:@"1.9.0.0"];
#pragma clang diagnostic pop
}

- (id<BDMVungleAd>)adForPlacement:(NSString *)placement markup:(NSString *)markup {
    return ANY(self.adMap.allObjects).filter(^BOOL(id<BDMVungleAd> ad){
        return [ad.placement isEqual:placement] && [ad.markup isEqual:markup];
    }).array.firstObject;
}

#pragma mark - VungleSDKDelegate

- (void)vungleSDKDidInitialize {
    STK_RUN_BLOCK(self.initialisationCompletion, YES, nil);
    self.initialisationCompletion = nil;
}

- (void)vungleSDKFailedToInitializeWithError:(NSError *)error {
    error ? BDMLog(@"Vungle initialisation failed with error: %@", error) : nil;
    STK_RUN_BLOCK(self.initialisationCompletion, YES, error);
    self.initialisationCompletion = nil;
}

#pragma mark - VungleSDKHBDelegate

- (void)vungleAdPlayabilityUpdate:(BOOL)isAdPlayable
                      placementID:(nullable NSString *)placementID
                         adMarkup:(nullable NSString *)adMarkup
                            error:(nullable NSError *)error
{
    id<BDMVungleAd> ad = [self adForPlacement:placementID markup:adMarkup];
    [ad vungleAdPlayabilityUpdate:isAdPlayable placementID:placementID adMarkup:adMarkup error:error];
}

- (void)vungleWillShowAdForPlacementID:(nullable NSString *)placementID
                              adMarkup:(nullable NSString *)adMarkup
{
    
    id<BDMVungleAd> ad = [self adForPlacement:placementID markup:adMarkup];
    [ad vungleWillShowAdForPlacementID:placementID adMarkup:adMarkup];
}

- (void)vungleDidCloseAdForPlacementID:(nullable NSString *)placementID
                              adMarkup:(nullable NSString *)adMarkup
{
    id<BDMVungleAd> ad = [self adForPlacement:placementID markup:adMarkup];
    [ad vungleDidCloseAdForPlacementID:placementID adMarkup:adMarkup];
}

- (void)vungleTrackClickForPlacementID:(nullable NSString *)placementID
                              adMarkup:(nullable NSString *)adMarkup
{
    dispatch_async(dispatch_get_main_queue(), ^{
        id<BDMVungleAd> ad = [self adForPlacement:placementID markup:adMarkup];
        [ad vungleTrackClickForPlacementID:placementID adMarkup:adMarkup];
    });
}

- (void)vungleRewardUserForPlacementID:(nullable NSString *)placementID
                              adMarkup:(nullable NSString *)adMarkup
{
    id<BDMVungleAd> ad = [self adForPlacement:placementID markup:adMarkup];
    [ad vungleRewardUserForPlacementID:placementID adMarkup:adMarkup];
}

@end
