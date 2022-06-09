//
//  BDMVungleAdManager.h
//  BDMVungleAdapter
//
//  Created by Ilia Lozhkin on 06.07.2021.
//  Copyright © 2021 Stas Kochkin. All rights reserved.
//

#import <VungleSDK/VungleSDK.h>
#import <VungleSDK/VungleSDKHeaderBidding.h>

#import "BDMVungleAdNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BDMVungleAd <VungleSDKHBDelegate>

@property (nonatomic, copy, readonly, nullable) NSString *placement;
@property (nonatomic, copy, readonly, nullable) NSString *markup;

@end

@interface BDMVungleAdManager : NSObject

- (void)initializeWithAppId:(NSString *)appId completion:(BDMInitializeBiddingNetworkBlock)completion;

- (void)collectParams:(NSString *)placement completion:(BDMCollectBiddingParamtersBlock)completion;

- (void)registerAd:(id<BDMVungleAd>)ad;

@end

NS_ASSUME_NONNULL_END
