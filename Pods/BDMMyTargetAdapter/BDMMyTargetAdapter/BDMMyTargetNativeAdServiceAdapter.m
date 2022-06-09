//
//  BDMMyTargetNativeAdServiceAdapter.m
//  BDMMyTargetAdapter
//
//  Created by Ilia Lozhkin on 11/20/19.
//  Copyright © 2019 Stas Kochkin. All rights reserved.
//

@import StackUIKit;
@import MyTargetSDK;
@import StackFoundation;

#import "BDMMyTargetAdNetwork.h"
#import "BDMMyTargetCustomParams.h"
#import "BDMMyTargetNativeAdServiceAdapter.h"
#import "BDMMyTargetNativeAdDisplayAdapter.h"

@interface BDMMyTargetNativeAdServiceAdapter ()<MTRGNativeAdDelegate>

@property (nonatomic, strong) MTRGNativeAd *nativeAd;

@end

@implementation BDMMyTargetNativeAdServiceAdapter

- (UIView *)adView {
    return nil;
}

- (void)prepareContent:(BDMStringToObjectMap *)contentInfo {
    NSString *slot = ANY(contentInfo).from(BDMMyTargetSlotIDKey).string;
    NSString *bid = ANY(contentInfo).from(BDMMyTargetBidIDKey).string;
    
    NSUInteger slotId = [slot integerValue];
    if (slotId == 0 || bid == nil) {
        NSError *error = [NSError bdm_errorWithCode:BDMErrorCodeBadContent description:@"MyTarget slot id or bid id wasn't found"];
        [self.loadingDelegate adapter:self failedToPrepareContentWithError:error];
        return;
    }
    
    self.nativeAd = [[MTRGNativeAd alloc] initWithSlotId:slotId];
    self.nativeAd.adChoicesPlacement = MTRGAdChoicesPlacementTopRight;
    self.nativeAd.delegate = self;
    
    [BDMMyTargetCustomParams populate:self.nativeAd.customParams];
    [self.nativeAd loadFromBid:bid];
}

#pragma mark - MTRGNativeAdDelegate

- (void)onLoadWithNativePromoBanner:(nonnull MTRGNativePromoBanner *)promoBanner nativeAd:(nonnull MTRGNativeAd *)nativeAd {
    BDMMyTargetNativeAdDisplayAdapter *nativeAdAdapter = [BDMMyTargetNativeAdDisplayAdapter displayAdapterForAd:nativeAd];
    [self.loadingDelegate service:self didLoadNativeAds:@[nativeAdAdapter]];
}

- (void)onNoAdWithReason:(nonnull NSString *)reason nativeAd:(nonnull MTRGNativeAd *)nativeAd {
    NSError *error = [NSError bdm_errorWithCode:BDMErrorCodeNoContent description:reason];
    [self.loadingDelegate adapter:self failedToPrepareContentWithError: error];
}

@end
