//
//  BDMRequestProtocol.h
//  BidMachine
//
//  Created by Ilia Lozhkin on 01.11.2021.
//  Copyright © 2021 Appodeal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BidMachine/BDMPriceFloor.h>
#import <BidMachine/BDMContextualProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BDMRequestProtocol <NSObject>

/// Bid prices configuration for current request
@property (copy, nonatomic, readonly, nonnull) NSArray <BDMPriceFloor *> *priceFloors;
///  Current user contextual data
@property (copy, nonatomic, readonly, nullable) id<BDMContextualProtocol> contextualData;
///  Custom parameters for request
@property (copy, nonatomic, readonly, nullable) NSDictionary <NSString *, NSString *> *customParameters;
/// Request timeout interval
@property (copy, nonatomic, readonly, nullable) NSNumber *timeout;
/// Request bid payload
@property (copy, nonatomic, readonly, nullable) NSString *bidPayload;
/// Custom placement id
@property (copy, nonatomic, readonly, nullable) NSString *placementId;
@end

NS_ASSUME_NONNULL_END
