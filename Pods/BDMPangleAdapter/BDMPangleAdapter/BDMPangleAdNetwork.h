//
//  BDMPangleAdNetwork.h
//  BDMPangleAdapter
//
//  Created by Ilia Lozhkin on 01.06.2021.
//  Copyright © 2021 Stas Kochkin. All rights reserved.
//

@import Foundation;
@import BidMachine;
@import BidMachine.Adapters;
@import BidMachine.HeaderBidding;

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const BDMPangleSlotIDKey;
FOUNDATION_EXPORT NSString *const BDMPanglePayloadKey;

@interface BDMPangleAdNetwork : NSObject <BDMNetwork>

@end

NS_ASSUME_NONNULL_END
