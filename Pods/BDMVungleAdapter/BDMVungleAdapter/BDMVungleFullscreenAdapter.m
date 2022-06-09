//
//  BDMVungleFullscreenAdapter.m
//  BDMVungleAdapter
//
//  Created by Stas Kochkin on 22/07/2019.
//  Copyright © 2019 Stas Kochkin. All rights reserved.
//

@import StackFoundation;

#import "BDMVungleAdNetwork.h"
#import "BDMVungleFullscreenAdapter.h"


@interface BDMVungleFullscreenAdapter ()

@property (nonatomic, copy, readwrite, nullable) NSString *placement;
@property (nonatomic, copy, readwrite, nullable) NSString *markup;
@property (nonatomic, assign, getter=isPlayed) BOOL played;

@end

@implementation BDMVungleFullscreenAdapter

- (UIView *)adView {
    return nil;
}

- (void)prepareContent:(BDMStringToObjectMap *)contentInfo {
    self.placement = ANY(contentInfo).from(BDMVunglePlacementIDKey).string;
    self.markup = ANY(contentInfo).from(BDMVungleMarkupKey).string;
    
    NSError *error = nil;
    if (self.placement && self.markup) {
        [VungleSDK.sharedSDK loadPlacementWithID:self.placement adMarkup:self.markup error:&error];
    } else {
        NSString *description = [NSString stringWithFormat:@"Vungle has not content for placement %@", self.placement ?: @"unknown"];
        error = [NSError bdm_errorWithCode:BDMErrorCodeNoContent description:description];
    }
    
    if (error) {
        NSError *wrapped = [error bdm_wrappedWithCode:BDMErrorCodeNoContent];
        [self.loadingDelegate adapter:self failedToPrepareContentWithError:wrapped];
    }
}

- (void)present {
    UIViewController *rootViewController = [self.displayDelegate rootViewControllerForAdapter:self];
    
    if (![VungleSDK.sharedSDK isAdCachedForPlacementID:self.placement adMarkup:self.markup]) {
        NSError *error = [NSError bdm_errorWithCode:BDMErrorCodeUnknown description:@"Vungle ads can't be presented"];
        [self.displayDelegate adapter:self failedToPresentAdWithError:error];
        return;
    }
    
    self.played = YES;
    NSError *error = nil;
    [VungleSDK.sharedSDK playAd:rootViewController
                        options:nil
                    placementID:self.placement
                       adMarkup:self.markup
                          error:&error];
    
    if (error) {
        NSError *wrapper = [error bdm_wrappedWithCode:BDMErrorCodeUnknown];
        [self.displayDelegate adapter:self failedToPresentAdWithError:wrapper];
    }
}

#pragma mark - VungleSDKHBDelegate

- (void)vungleAdPlayabilityUpdate:(BOOL)isAdPlayable
                      placementID:(nullable NSString *)placementID
                         adMarkup:(nullable NSString *)adMarkup
                            error:(nullable NSError *)error
{
    if (self.isPlayed) {
        return;
    }
    
    if (error) {
        NSError *wrapped = [error bdm_wrappedWithCode:BDMErrorCodeNoContent];
        [self.loadingDelegate adapter:self failedToPrepareContentWithError:wrapped];
        return;
    }
    
    [self.loadingDelegate adapterPreparedContent:self];
}

- (void)vungleWillShowAdForPlacementID:(nullable NSString *)placementID
                              adMarkup:(nullable NSString *)adMarkup
{
    [self.displayDelegate adapterWillPresent:self];
}

- (void)vungleDidCloseAdForPlacementID:(nullable NSString *)placementID
                              adMarkup:(nullable NSString *)adMarkup
{
    [self.displayDelegate adapterDidDismiss:self];
}

- (void)vungleTrackClickForPlacementID:(nullable NSString *)placementID
                              adMarkup:(nullable NSString *)adMarkup
{
    [self.displayDelegate adapterRegisterUserInteraction:self];
}

- (void)vungleRewardUserForPlacementID:(nullable NSString *)placementID
                              adMarkup:(nullable NSString *)adMarkup
{
    [self.displayDelegate adapterFinishRewardAction:self];
}

@end
