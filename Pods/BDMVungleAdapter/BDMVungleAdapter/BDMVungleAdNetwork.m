//
//  BDMVungleAdapter.m
//  BDMVungleAdapter
//
//  Created by Stas Kochkin on 19/07/2019.
//  Copyright © 2019 Stas Kochkin. All rights reserved.
//

@import StackFoundation;

#import "BDMVungleAdManager.h"
#import "BDMVungleAdNetwork.h"
#import "BDMVungleFullscreenAdapter.h"


NSString *const BDMVungleTokenKey               = @"token";
NSString *const BDMVungleAppIDKey               = @"app_id";
NSString *const BDMVunglePlacementIDKey         = @"placement_id";
NSString *const BDMVungleMarkupKey              = @"markup";

@interface BDMVungleAdNetwork ()

@property (nonatomic, strong) BDMVungleAdManager *adManager;

@end

@implementation BDMVungleAdNetwork

- (NSString *)name {
    return @"vungle";
}

- (NSString *)sdkVersion {
    return VungleSDKVersion;
}

- (BDMVungleAdManager *)adManager {
    if (!_adManager) {
        _adManager = BDMVungleAdManager.new;
    }
    return _adManager;
}

- (void)initializeWithParameters:(BDMStringToStringMap *)parameters
                           units:(NSArray<BDMAdUnit *> *)units
                      completion:(BDMInitializeBiddingNetworkBlock)completion
{
    NSString *appId = ANY(parameters).from(BDMVungleAppIDKey).string;
    [self.adManager initializeWithAppId:appId completion:completion];
}

- (void)collectHeaderBiddingParameters:(BDMAdUnit *)unit
                            completion:(BDMCollectBiddingParamtersBlock)completion
{
    NSString *placement = ANY(unit.params).from(BDMVunglePlacementIDKey).string;
    [self.adManager collectParams:placement completion:completion];
}

- (id<BDMFullscreenAdapter>)videoAdapterForSdk:(BDMSdk *)sdk {
    BDMVungleFullscreenAdapter *adapter = [BDMVungleFullscreenAdapter new];
    [self.adManager registerAd:adapter];
    return adapter;
}

@end
