//
//  BDMPangleAdNetwork.m
//  BDMPangleAdapter
//
//  Created by Ilia Lozhkin on 01.06.2021.
//  Copyright © 2021 Stas Kochkin. All rights reserved.
//

#import "BDMPangleAdNetwork.h"
#import "BDMPangleBannerAdapter.h"
#import "BDMPangleFullscreenAdapter.h"

@import StackFoundation;
@import BUAdSDK;

NSString *const BDMPangleIDKey              = @"app_id";
NSString *const BDMPangleSlotIDKey          = @"slot_id";
NSString *const BDMPangleTokenKey           = @"network_bid_token";
NSString *const BDMPanglePayloadKey         = @"bid_payload";

#define BDM_PANGLE_EXT(_NAME, _VERSION) @"[{\"name\":\"mediation\",\"value\":\"%@\"},{\"name\":\"adapter_version\",\"value\":\"%@\"}]", _NAME, _VERSION

@interface BDMPangleAdNetwork ()

@property (nonatomic, assign) BOOL initialized;
@property (nonatomic, strong) NSString *appId;

@end

@implementation BDMPangleAdNetwork

- (NSString *)name {
    return @"pangle_sdk";
}

- (NSString *)sdkVersion {
    return [BUAdSDKManager SDKVersion];
}

- (void)initializeWithParameters:(BDMStringToStringMap *)parameters
                           units:(NSArray<BDMAdUnit *> *)units
                      completion:(BDMInitializeBiddingNetworkBlock)completion {
    [self syncMetadata];
    
    if (self.initialized) {
        STK_RUN_BLOCK(completion, NO, nil);
        return;
    }
    
    NSString *appId = ANY(parameters).from(BDMPangleIDKey).string;
    if (appId) {
        [BUAdSDKManager setUserExtData:[NSString stringWithFormat:BDM_PANGLE_EXT(@"BidMachine", @"1.9.0.0")]];
        [BUAdSDKManager setAppID:appId];
        self.initialized = true;
        self.appId = appId;
        STK_RUN_BLOCK(completion, YES, nil);
    } else {
        NSError * error = [NSError bdm_errorWithCode:BDMErrorCodeInternal description:@"Pangle app id is not valid string"];
        STK_RUN_BLOCK(completion, NO, error);
    }
                
}

- (void)collectHeaderBiddingParameters:(BDMAdUnit *)unit
                            completion:(BDMCollectBiddingParamtersBlock)completion {
    NSString *token = [BUAdSDKManager mopubBiddingToken];
    NSString *slotId = ANY(unit.params).from(BDMPangleSlotIDKey).string;
   
    if (!token || !slotId) {
        NSError *error = [NSError bdm_errorWithCode:BDMErrorCodeHeaderBiddingNetwork
                                        description:@"Pangle adapter was not receive valid bidding data"];
        STK_RUN_BLOCK(completion, nil, error);
        return;
    }
    [self syncMetadata];
    
    NSMutableDictionary *bidding = [[NSMutableDictionary alloc] initWithCapacity:2];
    bidding[BDMPangleSlotIDKey] = slotId;
    bidding[BDMPangleTokenKey] = token;
    bidding[BDMPangleIDKey] = self.appId;
    
    STK_RUN_BLOCK(completion, bidding, nil);
}

- (id<BDMFullscreenAdapter>)videoAdapterForSdk:(BDMSdk *)sdk {
    return [BDMPangleFullscreenAdapter new];
}

- (id<BDMBannerAdapter>)bannerAdapterForSdk:(BDMSdk *)sdk {
    return [BDMPangleBannerAdapter new];
}

#pragma mark - Private

- (void)syncMetadata {
    [BUAdSDKManager setGDPR:BDMSdk.sharedSdk.restrictions.allowUserInformation];
    
}

@end
