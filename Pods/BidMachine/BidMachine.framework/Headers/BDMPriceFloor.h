//
//  BDMPriceFloor.h
//  BidMachine
//
//  Created by Stas Kochkin on 05/10/2018.
//  Copyright © 2018 Appodeal. All rights reserved.
//

#import <BidMachine/BDMDefines.h>

NS_ASSUME_NONNULL_BEGIN
BDM_SUBCLASSING_RESTRICTED

@interface BDMPriceFloor : NSObject
/// Bid identifier
@property (copy, nonatomic, readwrite, nonnull) NSString * ID;
/// Bidfloor for bid
@property (copy, nonatomic, readwrite, nonnull) NSDecimalNumber * value;
@end

NS_ASSUME_NONNULL_END
