//
//  BDMFacebookAdapter.m
//  BDMFacebookAdapter
//
//  Created by Stas Kochkin on 23/07/2019.
//  Copyright © 2019 Stas Kochkin. All rights reserved.
//

@import FBAudienceNetwork;
@import StackFoundation;

#import "BDMFacebookAdNetwork.h"
#import "BDMFacebookBannerAdapter.h"
#import "BDMFacebookFullscreenAdapter.h"
#import "BDMFacebookNativeAdServiceAdapter.h"


NSString *const BDMFacebookAppIDKey             = @"app_id";
NSString *const BDMFacebookTokenKey             = @"token";
NSString *const BDMFacebookPlacementIDKey       = @"facebook_key";
NSString *const BDMFacebookPlacementIDsKey      = @"placement_ids";
NSString *const BDMFacebookBidPayloadIDKey      = @"bid_payload";

@interface BDMFacebookAdNetwork ()

@property (nonatomic, copy) NSString *appId;
@property (nonatomic, assign) BOOL isInitialised;

@end


@implementation BDMFacebookAdNetwork

- (NSString *)name {
    return @"facebook";
}

- (NSString *)sdkVersion {
    return FB_AD_SDK_VERSION;
}

- (void)initializeWithParameters:(BDMStringToStringMap *)parameters
                           units:(NSArray<BDMAdUnit *> *)units
                      completion:(BDMInitializeBiddingNetworkBlock)completion
{
    [self syncMetadata];
    if (self.isInitialised) {
        STK_RUN_BLOCK(completion, NO, nil);
        return;
    }
    
    NSArray <NSString *> *placements = ANY(units)
    .flatMap(^id(BDMAdUnit *unit){ return ANY(unit.params).from(BDMFacebookPlacementIDKey).string;})
    .arrayOfString;
    
    self.appId = ANY(parameters).from(BDMFacebookAppIDKey).string; 
    
    if (!placements.count) {
        NSError *error = [NSError bdm_errorWithCode:BDMErrorCodeHeaderBiddingNetwork
                                        description:@"No placements for FBAudienceNetwork initialisation was found"];
        STK_RUN_BLOCK(completion, YES, error);
        return;
    }
    
    NSString *mediationService = [NSString stringWithFormat:@"bidmachine_%@:%@", kBDMVersion, @"1.9.0.1"];
    FBAdInitSettings *settings = [[FBAdInitSettings alloc] initWithPlacementIDs:placements
                                                               mediationService:mediationService];
    __weak __typeof(self) weakSelf = self;
    [FBAudienceNetworkAds initializeWithSettings:settings
                               completionHandler:^(FBAdInitResults *results) {
        NSError *error = results.success ? nil : [NSError bdm_errorWithCode:BDMErrorCodeHeaderBiddingNetwork
                                                                description:@"FBAudienceNetwork initialisation was unsuccessful"];
        
        weakSelf.isInitialised = results.success;
        STK_RUN_BLOCK(completion, YES, error);
    }];
}

- (void)collectHeaderBiddingParameters:(BDMAdUnit *)unit
                            completion:(BDMCollectBiddingParamtersBlock)completion
{
    NSString *placement = ANY(unit.params).from(BDMFacebookPlacementIDKey).string;
    NSString *token = FBAdSettings.bidderToken;
    NSString *appId = self.appId;
    if (!placement || !token || !appId) {
        NSError *error = [NSError bdm_errorWithCode:BDMErrorCodeHeaderBiddingNetwork
                                        description:@"FBAudienceNetwork adapter was not receive valid bidding data"];
        STK_RUN_BLOCK(completion, nil, error);
        return;
    }
    
    NSMutableDictionary *bidding            = [NSMutableDictionary dictionaryWithCapacity:3];
    bidding[BDMFacebookTokenKey]            = token;
    bidding[BDMFacebookAppIDKey]            = appId;
    bidding[BDMFacebookPlacementIDKey]      = placement;
    
    STK_RUN_BLOCK(completion, bidding, nil);
}

- (id<BDMBannerAdapter>)bannerAdapterForSdk:(BDMSdk *)sdk {
    return [BDMFacebookBannerAdapter new];
}

- (id<BDMFullscreenAdapter>)interstitialAdAdapterForSdk:(BDMSdk *)sdk {
    return [BDMFacebookFullscreenAdapter new];
}

- (id<BDMFullscreenAdapter>)videoAdapterForSdk:(BDMSdk *)sdk {
    return [BDMFacebookFullscreenAdapter new];
}

- (id<BDMNativeAdServiceAdapter>)nativeAdAdapterForSdk:(BDMSdk *)sdk {
    return [BDMFacebookNativeAdServiceAdapter new];
}

#pragma mark - Private

- (void)syncMetadata {
    [FBAdSettings setLogLevel:BDMSdkLoggingEnabled ? FBAdLogLevelVerbose : FBAdLogLevelNone];
    [FBAdSettings setMixedAudience:BDMSdk.sharedSdk.restrictions.coppa];
    [FBAdSettings setAdvertiserTrackingEnabled: ![STKAd.advertisingIdentifier isEqual:@"00000000-0000-0000-0000-000000000000"]];
    
    if (BDMSdk.sharedSdk.restrictions.subjectToCCPA) {
        if (BDMSdk.sharedSdk.restrictions.hasCCPAConsent) {
            [FBAdSettings setDataProcessingOptions:@[]];
        } else {
            [FBAdSettings setDataProcessingOptions:@[@"LDU"] country:0 state:0];
        }
    }
}

@end
