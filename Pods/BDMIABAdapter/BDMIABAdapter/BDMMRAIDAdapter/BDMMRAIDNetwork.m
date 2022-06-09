//
//  BDMMRAIDNetwork
//  BDMMRAIDNetwork
//
//  Created by Pavel Dunyashev on 11/09/2018.
//  Copyright © 2018 Appodeal. All rights reserved.
//

#import "BDMMRAIDNetwork.h"
#import "BDMMRAIDBannerAdapter.h"
#import "BDMMRAIDInterstitialAdapter.h"

#import <StackMRAIDKit/StackMRAIDKit.h>


@implementation BDMMRAIDNetwork

- (NSString *)name {
    return @"mraid";
}

- (NSString *)sdkVersion {
    return StackMRAIDKitVersion;
}

- (id<BDMFullscreenAdapter>)interstitialAdAdapterForSdk:(BDMSdk *)sdk {
    return [BDMMRAIDInterstitialAdapter new];
}

- (id<BDMBannerAdapter>)bannerAdapterForSdk:(BDMSdk *)sdk {
    return [BDMMRAIDBannerAdapter new];
}

@end

