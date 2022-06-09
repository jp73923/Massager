//
//  BDMRequest+HeaderBidding.h
//  BidMachine
//
//  Created by Stas Kochkin on 01/10/2018.
//  Copyright © 2018 Appodeal. All rights reserved.
//

#import <BidMachine/BDMRequest.h>
#import <BidMachine/BDMHBRequestProtocol.h>
#import <BidMachine/BDMSdkConfiguration+HeaderBidding.h>

@interface BDMRequest (HeaderBidding)<BDMHBRequestProtocol>
/// Header bidding configuration
@property (copy, nonatomic, readwrite, nullable) NSArray <BDMAdNetworkConfiguration *> *networkConfigurations;

@end
