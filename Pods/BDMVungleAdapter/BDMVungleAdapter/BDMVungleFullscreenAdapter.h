//
//  BDMVungleFullscreenAdapter.h
//  BDMVungleAdapter
//
//  Created by Stas Kochkin on 22/07/2019.
//  Copyright © 2019 Stas Kochkin. All rights reserved.
//

@import Foundation;
@import BidMachine;
@import BidMachine.Adapters;

#import "BDMVungleAdManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface BDMVungleFullscreenAdapter : NSObject <BDMFullscreenAdapter, BDMVungleAd>

@property (nonatomic, assign, readwrite) BOOL rewarded;
@property (nonatomic, weak, nullable) id <BDMAdapterLoadingDelegate> loadingDelegate;
@property (nonatomic, weak, nullable) id <BDMFullscreenAdapterDisplayDelegate> displayDelegate;

@end

NS_ASSUME_NONNULL_END
