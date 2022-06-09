//
//  BDMAmazonNetwork.m
//  BDMAmazonNetwork
//
//  Created by Yaroslav Skachkov on 9/10/19.
//  Copyright © 2019 Stas Kochkin. All rights reserved.
//

@import DTBiOSSDK;
@import StackFoundation;

#import "BDMAmazonNetwork.h"
#import "BDMAmazonAdLoader.h"
#import "BDMAmazonAdObject.h"


NSString *const BDMAmazonAppIDKey   = @"app_key";
NSString *const BDMAmazonSlotIdKey  = @"slot_uuid";


@interface BDMAmazonNetwork()

@property (nonatomic, assign) BOOL hasBeenInitialized;
@property (nonatomic, strong) NSHashTable <BDMAmazonAdLoader *> *loaders;

@end

@implementation BDMAmazonNetwork

- (NSString *)name {
    return @"amazon";
}

- (NSString *)sdkVersion {
    return [DTBAds version];
}

- (NSHashTable<BDMAmazonAdLoader *> *)loaders {
    if (!_loaders) {
        _loaders = [[NSHashTable alloc] init];
    }
    return _loaders;
}

- (void)initializeWithParameters:(BDMStringToStringMap *)parameters
                           units:(NSArray<BDMAdUnit *> *)units
                      completion:(BDMInitializeBiddingNetworkBlock)completion
{
    [self syncMetadata];
    if (self.hasBeenInitialized) {
        STK_RUN_BLOCK(completion, NO, nil);
        return;
    }
    
    NSString *appKey = ANY(parameters).from(BDMAmazonAppIDKey).string;
    if (!appKey) {
        NSError *error = [NSError bdm_errorWithCode:BDMErrorCodeHeaderBiddingNetwork
                                        description:@"Amazon adapter was not receive valid initialization data"];
        STK_RUN_BLOCK(completion, NO, error);
        return;
    }
    
    self.hasBeenInitialized = YES;
    [DTBAds.sharedInstance setAppKey:appKey];
    STK_RUN_BLOCK(completion, YES, nil);
}

- (void)collectHeaderBiddingParameters:(BDMAdUnit *)unit
                            completion:(BDMCollectBiddingParamtersBlock)completion
{
    BDMAmazonAdLoader *loader = [[BDMAmazonAdLoader alloc] initWithFormat:unit.format
                                                         serverParameters:unit.params];
    [self.loaders addObject:loader];
    __weak __typeof(self) weakSelf = self;
    [loader prepareWithCompletion:^(BDMAmazonAdLoader *loader,
                                    NSDictionary<NSString *, NSString *> *biddingParameters,
                                    NSError *error) {
        [weakSelf.loaders removeObject:loader];
        STK_RUN_BLOCK(completion, biddingParameters, error);
    }];
}

- (id<BDMBannerAdapter>)bannerAdapterForSdk:(BDMSdk *)sdk {
    return [BDMAmazonBannerAdapter new];
}

- (id<BDMFullscreenAdapter>)interstitialAdAdapterForSdk:(BDMSdk *)sdk {
    return [BDMAmazonInterstitialAdapter new];
}

#pragma mark - Private

- (void)syncMetadata {
    [DTBAds.sharedInstance setLogLevel:BDMSdkLoggingEnabled ? DTBLogLevelAll : DTBLogLevelOff];

    DTBAds.sharedInstance.mraidPolicy = CUSTOM_MRAID;
    DTBAds.sharedInstance.mraidCustomVersions = @[@"1.0", @"2.0", @"3.0"];
    
    if (BDMSdk.sharedSdk.restrictions.allowUserInformation) {
        [DTBAds.sharedInstance setUseGeoLocation:STKLocation.locationTrackingEnabled];
    }
}

@end
