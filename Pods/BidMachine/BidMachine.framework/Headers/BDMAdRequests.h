//
//  BDMBannerRequest.h
//  BidMachine
//
//  Created by Stas Kochkin on 11/01/2019.
//  Copyright © 2019 Appodeal. All rights reserved.
//

#import <BidMachine/BDMRequest.h>

@interface BDMBannerRequest : BDMRequest
/// Banner ad size
@property (nonatomic, assign, readwrite) BDMBannerAdSize adSize;
/// Performs auction with current parameters
/// @param delegate Delegate object
- (void)performWithDelegate:(id<BDMRequestDelegate>)delegate;
@end
@interface BDMInterstitialRequest : BDMRequest
/// Specifies ad type of interstitial
@property (nonatomic, assign, readwrite) BDMFullscreenAdType type;
/// Performs auction with current parameters
/// @param delegate Delegate object
- (void)performWithDelegate:(id<BDMRequestDelegate>)delegate;
@end
@interface BDMRewardedRequest : BDMRequest
/// Performs auction with current parameters
/// @param delegate Delegate object
- (void)performWithDelegate:(id<BDMRequestDelegate>)delegate;
@end
@interface BDMNativeAdRequest : BDMRequest
/// Specifies ad type of native ad
@property (nonatomic, assign, readwrite) BDMNativeAdType type;
/// Performs auction with current parameters
/// @param delegate Delegate object
- (void)performWithDelegate:(id<BDMRequestDelegate>)delegate;
@end
@interface BDMRichMediaRequest : BDMRequest
/// Performs auction with current parameters
/// @param delegate Delegate object
- (void)performWithDelegate:(id<BDMRequestDelegate>)delegate;
@end
