//
//  BDMVungleAdapter.h
//  BDMVungleAdapter
//
//  Created by Stas Kochkin on 19/07/2019.
//  Copyright © 2019 Stas Kochkin. All rights reserved.
//

@import Foundation;
@import BidMachine;
@import BidMachine.Adapters;

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const BDMVungleTokenKey;
FOUNDATION_EXPORT NSString *const BDMVungleAppIDKey;
FOUNDATION_EXPORT NSString *const BDMVunglePlacementIDKey;
FOUNDATION_EXPORT NSString *const BDMVungleMarkupKey;

@interface BDMVungleAdNetwork : NSObject <BDMNetwork>

@end

NS_ASSUME_NONNULL_END
