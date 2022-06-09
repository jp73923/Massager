#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BDMFacebookAdNetwork.h"
#import "BDMFacebookBannerAdapter.h"
#import "BDMFacebookFullscreenAdapter.h"
#import "BDMFacebookNativeAdDisplayAdapter.h"
#import "BDMFacebookNativeAdServiceAdapter.h"

FOUNDATION_EXPORT double BDMFacebookAdapterVersionNumber;
FOUNDATION_EXPORT const unsigned char BDMFacebookAdapterVersionString[];

