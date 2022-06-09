//
//  BDMPangleBannerAdapter.m
//  BDMPangleAdapter
//
//  Created by Ilia Lozhkin on 01.06.2021.
//  Copyright © 2021 Stas Kochkin. All rights reserved.
//

#import "BDMPangleBannerAdapter.h"

@import StackFoundation;
@import StackUIKit;
@import BUAdSDK;

@interface BDMPangleBannerAdapter ()<BUNativeExpressBannerViewDelegate>

@property (nonatomic, strong) BUNativeExpressBannerView *bannerView;

@end

@implementation BDMPangleBannerAdapter

- (UIView *)adView {
    return self.bannerView;
}

- (void)prepareContent:(nonnull BDMStringToObjectMap *)contentInfo {
    NSString *slotId = ANY(contentInfo).from(BDMPangleSlotIDKey).string;
    NSString *payload = ANY(contentInfo).from(BDMPanglePayloadKey).string;
    if (!slotId || !payload) {
        NSError *error = [NSError bdm_errorWithCode:BDMErrorCodeBadContent
                                        description:@"Pangle wasn't recived valid bidding data"];
        [self.loadingDelegate adapter:self failedToPrepareContentWithError:error];
        return;
    }
    
    CGSize bannerSize = [self.displayDelegate sizeForAdapter:self];
    UIViewController *controller = [self.displayDelegate rootViewControllerForAdapter:self];
    self.bannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:slotId
                                                      rootViewController:controller
                                                                  adSize:bannerSize];
    self.bannerView.delegate = self;
    self.bannerView.frame = (CGRect){.size = bannerSize};
    [self.bannerView setMopubAdMarkUp:payload];
}

- (void)presentInContainer:(nonnull UIView *)container {
    [container.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.bannerView stk_edgesEqual:container];
}

#pragma mark - BUNativeExpressBannerViewDelegate

- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView {
    [self.loadingDelegate adapterPreparedContent:self];
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error {
    NSError *bmError = [NSError bdm_errorWithCode:BDMErrorCodeNoContent
                                    description: error.description ? error.description : @"Fail to prepare pangle adapter"];
    [self.loadingDelegate adapter:self failedToPrepareContentWithError:bmError];
}

- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView {
    [self.displayDelegate adapterRegisterUserInteraction:self];
}

@end
