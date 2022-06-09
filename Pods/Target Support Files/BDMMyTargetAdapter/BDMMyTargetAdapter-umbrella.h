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

#import "BDMMyTargetAdNetwork.h"
#import "BDMMyTargetBannerAdapter.h"
#import "BDMMyTargetCustomParams.h"
#import "BDMMyTargetFullscreenAdapter.h"
#import "BDMMyTargetNativeAdDisplayAdapter.h"
#import "BDMMyTargetNativeAdServiceAdapter.h"

FOUNDATION_EXPORT double BDMMyTargetAdapterVersionNumber;
FOUNDATION_EXPORT const unsigned char BDMMyTargetAdapterVersionString[];

