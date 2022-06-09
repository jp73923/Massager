//
//  BDMDefines.h
//  BidMachine
//
//  Created by Stas Kochkin on 07/11/2017.
//  Copyright © 2017 Appodeal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/// Current verison of SDK
FOUNDATION_EXPORT NSString * const kBDMVersion;

#if __has_attribute(objc_subclassing_restricted)
#define BDM_SUBCLASSING_RESTRICTED __attribute__((objc_subclassing_restricted))
#else
#define BDM_SUBCLASSING_RESTRICTED
#endif

#define BDMLog(fmt, ...)  BDMSdkLoggingEnabled ? NSLog(@"[BidMachine][%@] " fmt, kBDMVersion, ##__VA_ARGS__) : nil

typedef NSDictionary <NSString *, NSString *> BDMStringToStringMap;
typedef NSDictionary <NSString *, id> BDMStringToObjectMap;

typedef NSString BDMFmwName;
FOUNDATION_EXPORT BDMFmwName * const BDMNativeFramework;
FOUNDATION_EXPORT BDMFmwName * const BDMNUnityFramework;

/// Domain of OpenBids SDK errors
FOUNDATION_EXPORT NSString * kBDMErrorDomain;
/// Indicates that logging was enabled
FOUNDATION_EXPORT BOOL BDMSdkLoggingEnabled;

/// User gender
typedef NSString BDMUserGender;
/// Male
FOUNDATION_EXPORT NSString * const kBDMUserGenderMale;
/// Female
FOUNDATION_EXPORT NSString * const kBDMUserGenderFemale;
/// Unknown gender
FOUNDATION_EXPORT NSString * const kBDMUserGenderUnknown;
/// Undifiend year of user birth
FOUNDATION_EXPORT NSInteger const kBDMUndefinedYearOfBirth;

/**
 Error codes of BidMachine SDK

 - BDMErrorCodeUnknown: Any unknown error
 - BDMErrorCodeNoConnection: Connection error
 - BDMErrorCodeBadContent: Serialisation errors
 - BDMErrorCodeTimeout: Request was timed out
 - BDMErrorCodeNoContent: No content was received
 - BDMErrorCodeException: Handled exception
 - BDMErrorCodeWasClosed: Ad was closed before sdk tracked imression
 - BDMErrorCodeWasDestroyed: Ad was destroyed before impression
 - BDMErrorCodeWasExpired: Ad expired
 - BDMErrorCodeInternal: Any internal SDK error
 - BDMErrorCodeHTTPServerError: Server returned 4XX
 - BDMErrorCodeHTTPBadRequest: Server returned 5XX
 - BDMErrorCodeUsedAlready: AdRequest can't be load because allready used
 - BDMErrorCodeHeaderBiddingNetwork: Ad Network specific error
 */
typedef NS_ENUM(NSInteger, BDMErrorCode) {
    BDMErrorCodeUnknown = 0,
    BDMErrorCodeNoConnection = 100,
    BDMErrorCodeBadContent = 101,
    BDMErrorCodeTimeout = 102,
    BDMErrorCodeNoContent = 103,
    BDMErrorCodeException = 104,
    BDMErrorCodeWasClosed = 105,
    BDMErrorCodeWasDestroyed = 106,
    BDMErrorCodeWasExpired = 107,
    BDMErrorCodeInternal = 108,
    BDMErrorCodeHTTPServerError = 109,
    BDMErrorCodeHTTPBadRequest = 110,
    BDMErrorCodeUsedAlready = 111,
    BDMErrorCodeHeaderBiddingNetwork = 200
};

/**
 Supported ad formats bit mask
 
 - BDMFullsreenAdTypeBanner: HTML and MRAID ad creatives
 - BDMFulscreenAdTypeVideo: VAST and VPAID ad creatives
 - BDMFullscreenAdTypeAll: Supports all ad formats
 */
typedef NS_OPTIONS(NSUInteger, BDMFullscreenAdType) {
    BDMFullsreenAdTypeBanner = 1 << 0,
    BDMFullscreenAdTypeVideo = 1 << 1,
    BDMFullscreenAdTypeAll = BDMFullsreenAdTypeBanner | BDMFullscreenAdTypeVideo
};

/**
 Banner size enum

 - BDMBannerAdSizeUnknown: Unknown banner size, sets by default
 - BDMBannerAdSize320x50: Phone banner size
 - BDMBannerAdSize728x90: Tabplet banner size
 - BDMBannerAdSize300x250: Medium rectangle size
 */
typedef NS_ENUM(NSInteger, BDMBannerAdSize) {
    BDMBannerAdSizeUnknown = 0,
    BDMBannerAdSize320x50,
    BDMBannerAdSize728x90,
    BDMBannerAdSize300x250
};

/**
 Supported asset configuration

 - BDMNativeAdTypeIcon: Icon image
 - BDMNativeAdTypeImage: Promo image
 - BDMNativeAdTypeVideo: Video content
 */
typedef NS_OPTIONS(NSUInteger, BDMNativeAdType) {
    BDMNativeAdTypeIcon             = 1 << 0,
    BDMNativeAdTypeImage            = 1 << 1,
    BDMNativeAdTypeVideo            = 1 << 2,
    BDMNativeAdTypeIconAndVideo     = BDMNativeAdTypeIcon | BDMNativeAdTypeVideo,
    BDMNativeAdTypeIconAndImage     = BDMNativeAdTypeIcon | BDMNativeAdTypeImage,
    BDMNativeAdTypeImageAndVideo    = BDMNativeAdTypeImage | BDMNativeAdTypeVideo,
    BDMNativeAdTypeAllMedia         = BDMNativeAdTypeIcon | BDMNativeAdTypeImage | BDMNativeAdTypeVideo
};

/**
 Supported ad units formats configuration
 */
typedef NS_ENUM(NSInteger, BDMAdUnitFormat) {
    BDMAdUnitFormatUnknown = -1,
    BDMAdUnitFormatInLineBanner,
    BDMAdUnitFormatBanner320x50,
    BDMAdUnitFormatBanner728x90,
    BDMAdUnitFormatBanner300x250,
    BDMAdUnitFormatInterstitialVideo,
    BDMAdUnitFormatInterstitialStatic,
    BDMAdUnitFormatInterstitialUnknown,
    BDMAdUnitFormatRewardedVideo,
    BDMAdUnitFormatRewardedPlayable,
    BDMAdUnitFormatRewardedUnknown,
    BDMAdUnitFormatNativeAdIcon,
    BDMAdUnitFormatNativeAdImage,
    BDMAdUnitFormatNativeAdVideo,
    BDMAdUnitFormatNativeAdIconAndVideo,
    BDMAdUnitFormatNativeAdIconAndImage,
    BDMAdUnitFormatNativeAdImageAndVideo,
    BDMAdUnitFormatNativeAdUnknown
};

/**
Supported crative format

- BDMCreativeFormatBanner: Mraid content
- BDMCreativeFormatVideo: Vast content
- BDMCreativeFormatNative: Nast content
- BDMInternalPlacementTypeRichMedia: Rich media content
*/
typedef NS_ENUM(NSInteger, BDMCreativeFormat) {
    BDMCreativeFormatBanner = 0,
    BDMCreativeFormatVideo,
    BDMCreativeFormatNative
};

typedef NS_ENUM(NSInteger, BDMInternalPlacementType) {
    BDMInternalPlacementTypeUndefined = -1,
    BDMInternalPlacementTypeInterstitial,
    BDMInternalPlacementTypeRewardedVideo,
    BDMInternalPlacementTypeBanner,
    BDMInternalPlacementTypeNative,
    BDMInternalPlacementTypeRichMedia
};

NSString *NSStringFromBDMCreativeFormat(BDMCreativeFormat fmt);

CGSize CGSizeFromBDMSize(BDMBannerAdSize adSize);

FOUNDATION_EXTERN BDMAdUnitFormat BDMAdUnitFormatFromString(NSString *);

FOUNDATION_EXTERN NSString * NSStringFromBDMAdUnitFormat(BDMAdUnitFormat);
