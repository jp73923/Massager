//
//  BDMPangleBannerAdapter.h
//  BDMPangleAdapter
//
//  Created by Ilia Lozhkin on 01.06.2021.
//  Copyright © 2021 Stas Kochkin. All rights reserved.
//

#import "BDMPangleAdNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface BDMPangleBannerAdapter : NSObject <BDMBannerAdapter>

@property (nonatomic, weak, nullable) id<BDMAdapterLoadingDelegate> loadingDelegate;
@property (nonatomic, weak, nullable) id <BDMBannerAdapterDisplayDelegate> displayDelegate;

@end

NS_ASSUME_NONNULL_END
