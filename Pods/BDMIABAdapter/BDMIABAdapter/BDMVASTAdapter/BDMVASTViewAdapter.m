//
//  BDMVASTViewAdapter.m
//  BDMVASTAdapter
//
//  Created by Ilia Lozhkin on 18.10.2021.
//  Copyright © 2021 Stas Kochkin. All rights reserved.
//


@import StackUIKit;
@import StackVASTKit;
@import StackFoundation;

#import "BDMVASTViewAdapter.h"

@interface BDMVASTViewAdapter ()<STKVASTViewDelegate>

@property (nonatomic, strong) STKVASTView *vastView;
@property (nonatomic,   copy) BDMStringToObjectMap *contentInfo;

@end

@implementation BDMVASTViewAdapter

- (UIView *)adView {
    return self.vastView;
}

- (void)prepareContent:(nonnull BDMStringToObjectMap *)contentInfo {
    NSString *rawXML        = ANY(contentInfo).from(kBDMCreativeAdm).string;
    NSData *xmlData         = [rawXML dataUsingEncoding:NSUTF8StringEncoding];
    self.contentInfo        = contentInfo;
    
    self.vastView           = [[STKVASTView alloc] initWithConfiguration: [STKVASTControllerConfiguration configuration:^(STKVASTControllerConfigurationBuilder *builder) {
        builder.appendMaxDuration(180);
        builder.appendProductParameters(ANY(contentInfo).from(kBDMCreativeStoreParams).value);
        builder.appendPartnerName(kBDMOMPartnerName);
        builder.appendPartnerVersion(kBDMVersion);
        builder.appendMeasuring(YES);
    }]];
    
    [self.vastView setDelegate:self];
    [self.vastView loadForVastXML:xmlData];
}

- (void)presentInContainer:(nonnull UIView *)container {
    [container.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.vastView stk_edgesEqual:container];
}

- (void)pause {
    [self.vastView pause];
}

- (void)resume {
    [self.vastView resume];
}

- (void)mute {
    [self.vastView mute];
}

- (void)unmute {
    [self.vastView unmute];
}

#pragma mark - STKVASTViewDelegate

- (void)vastViewReady:(STKVASTView *)view {
    [self.loadingDelegate adapterPreparedContent:self];
}

- (void)vastView:(STKVASTView *)view didFailToLoad:(NSError *)error {
    [self.loadingDelegate adapter:self failedToPrepareContentWithError:[error bdm_wrappedWithCode:BDMErrorCodeNoContent]];
}

- (void)vastViewDidPresent:(STKVASTView *)view {
    //
}

- (void)vastViewDidFinish:(STKVASTView *)view {
    //
}

- (void)vastViewWillLeaveApplication:(STKVASTView *)view {
    [self.displayDelegate adapterRegisterUserInteraction:self];
    [self.displayDelegate adapterWillLeaveApplication:self];
}

- (void)vastViewWillPresentProductScreen:(STKVASTView *)view {
    [self.displayDelegate adapterRegisterUserInteraction:self];
    [self.displayDelegate adapterWillPresentScreen:self];
}

- (void)vastViewDidDismissProductScreen:(STKVASTView *)view {
    [self.displayDelegate adapterDidDismissScreen:self];
}


@end
