//
//  BDMHBRequestProtocol.h
//  BidMachine
//
//  Created by Ilia Lozhkin on 01.11.2021.
//  Copyright © 2021 Appodeal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BidMachine/BDMSdkConfiguration+HeaderBidding.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BDMHBRequestProtocol <NSObject>
/// Header bidding configuration
@property (copy, nonatomic, readonly, nullable) NSArray <BDMAdNetworkConfiguration *> *networkConfigurations;

@end

NS_ASSUME_NONNULL_END
