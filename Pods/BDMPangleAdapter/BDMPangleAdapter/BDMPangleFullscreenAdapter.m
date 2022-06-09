//
//  BDMPangleFullscreenAdapter.m
//  BDMPangleAdapter
//
//  Created by Ilia Lozhkin on 14.06.2021.
//  Copyright © 2021 Stas Kochkin. All rights reserved.
//

#import "BDMPangleFullscreenAdapter.h"

@import StackFoundation;
@import StackUIKit;
@import BUAdSDK;

@interface BDMPangleFullscreenAdapter ()<BUFullscreenVideoAdDelegate, BURewardedVideoAdDelegate>

@property(nonatomic, strong) BUFullscreenVideoAd *videoAd;
@property(nonatomic, strong) BURewardedVideoAd *rewardedAd;

@end

@implementation BDMPangleFullscreenAdapter

- (UIView *)adView {
    return nil;
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
    
    if (self.rewarded) {
        BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
        model.userId = slotId;
        self.rewardedAd = [[BURewardedVideoAd alloc] initWithSlotID:slotId rewardedVideoModel:model];
        self.rewardedAd.delegate = self;
        [self.rewardedAd setMopubAdMarkUp:payload];
    } else {
        self.videoAd = [[BUFullscreenVideoAd alloc] initWithSlotID:slotId];
        self.videoAd.delegate = self;
        [self.videoAd setMopubAdMarkUp:payload];
    }
}

- (void)present {
    if (self.rewarded && self.rewardedAd) {
        [self.rewardedAd showAdFromRootViewController:self.rootViewController];
        return;
    }
    
    if (!self.rewarded && self.videoAd) {
        [self.videoAd showAdFromRootViewController:self.rootViewController];
        return;
    }
    
    NSError *error = [NSError bdm_errorWithCode:BDMErrorCodeInternal description:@"Pangle video ad is invalid"];
    [self.displayDelegate adapter:self failedToPresentAdWithError:error];
}

- (UIViewController *)rootViewController {
    return [self.displayDelegate rootViewControllerForAdapter:self] ?: UIViewController.stk_topPresentedViewController;
}

#pragma mark - BUFullscreenVideoAdDelegate

- (void)fullscreenVideoMaterialMetaAdDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
    [self.loadingDelegate adapterPreparedContent:self];
}

- (void)fullscreenVideoAd:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error {
    NSError *bmError = [NSError bdm_errorWithCode:BDMErrorCodeNoContent
                                    description: error.description ? error.description : @"Fail to prepare pangle adapter"];
    [self.loadingDelegate adapter:self failedToPrepareContentWithError:bmError];
}

- (void)fullscreenVideoAdWillVisible:(BUFullscreenVideoAd *)fullscreenVideoAd {
    [self.displayDelegate adapterWillPresent:self];
}


- (void)fullscreenVideoAdDidClose:(BUFullscreenVideoAd *)fullscreenVideoAd {
    [self.displayDelegate adapterDidDismiss:self];
}

- (void)fullscreenVideoAdDidClick:(BUFullscreenVideoAd *)fullscreenVideoAd {
    [self.displayDelegate adapterRegisterUserInteraction:self];
}

- (void)fullscreenVideoAdDidPlayFinish:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error {
    if (error) {
        [self.displayDelegate adapter:self failedToPresentAdWithError:error];
    }
}

#pragma mark - BURewardedVideoAdDelegate

- (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    [self.loadingDelegate adapterPreparedContent:self];
}

- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    NSError *bmError = [NSError bdm_errorWithCode:BDMErrorCodeNoContent
                                    description: error.description ? error.description : @"Fail to prepare pangle adapter"];
    [self.loadingDelegate adapter:self failedToPrepareContentWithError:bmError];
}

- (void)rewardedVideoAdWillVisible:(BURewardedVideoAd *)rewardedVideoAd {
    [self.displayDelegate adapterWillPresent:self];
}

- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd {
    [self.displayDelegate adapterDidDismiss:self];
}

- (void)rewardedVideoAdDidClick:(BURewardedVideoAd *)rewardedVideoAd {
    [self.displayDelegate adapterRegisterUserInteraction:self];
}

- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    if (error) {
        [self.displayDelegate adapter:self failedToPresentAdWithError:error];
    }
}

- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify {
    if (verify) {
        [self.displayDelegate adapterFinishRewardAction:self];
    }
}

@end
