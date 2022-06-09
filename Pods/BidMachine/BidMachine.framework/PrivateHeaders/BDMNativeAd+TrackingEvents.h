//
//  BDMNativeAd+TrackingEvents.h
//  BidMachine
//
//  Created by Ilia Lozhkin on 07.10.2021.
//  Copyright © 2021 Appodeal. All rights reserved.
//

#import <BidMachine/BDMNativeAd.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDMNativeAd (TrackingEvents)

// track when native ad asset elements added to container
- (void)trackContainerAdded;
// track when native ad view was presented
- (void)trackImpression;
// track when native ad view was viewable
- (void)trackViewable;
// track when native ad view was deleted from view
- (void)trackFinish;
// track when native ad view was clicked
- (void)trackUserInteraction;

@end

NS_ASSUME_NONNULL_END
