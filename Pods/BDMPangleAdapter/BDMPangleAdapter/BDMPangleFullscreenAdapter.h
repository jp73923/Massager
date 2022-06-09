//
//  BDMPangleFullscreenAdapter.h
//  BDMPangleAdapter
//
//  Created by Ilia Lozhkin on 14.06.2021.
//  Copyright © 2021 Stas Kochkin. All rights reserved.
//

#import "BDMPangleAdNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface BDMPangleFullscreenAdapter : NSObject <BDMFullscreenAdapter>

@property (nonatomic, assign, readwrite) BOOL rewarded;
@property (nonatomic, weak, nullable) id <BDMAdapterLoadingDelegate> loadingDelegate;
@property (nonatomic, weak, nullable) id <BDMFullscreenAdapterDisplayDelegate> displayDelegate;


@end

NS_ASSUME_NONNULL_END
