//
//  BDMRichMediaView.h
//  BidMachine
//
//  Created by Ilia Lozhkin on 12.10.2021.
//  Copyright © 2021 Appodeal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BidMachine/BDMAdRequests.h>
#import <BidMachine/BDMAdEventProducerProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@class BDMRichMediaView;

@protocol BDMRichMediaDelegate <NSObject>
/// Called when media view is ready to render creative
/// @param mediaView Ready to present media view
- (void)mediaViewReadyToPresent:(BDMRichMediaView *)mediaView;
/// @param mediaView Failed instance of media view
/// @param error Error object
- (void)mediaView:(BDMRichMediaView *)mediaView failedWithError:(NSError *)error;
/// Called when user interacts with media view
/// @param mediaView Ready media view
- (void)mediaViewRecieveUserInteraction:(BDMRichMediaView *)mediaView;
@optional
/// Called in case media view performed request by itself
/// when instance of media view expired
/// @param mediaView media view
- (void)mediaViewDidExpire:(BDMRichMediaView *)mediaView;
/// Called when media view opens product link in external
/// browser (Safari) after user interaction
/// @param mediaView Media view that revieve user interaction
- (void)mediaViewWillLeaveApplication:(BDMRichMediaView *)mediaView;
/// Called before media view opens product link in StoreKit or Safari
/// view controller internally in application after user interaction
/// @param mediaView Media view that receives user interaction
- (void)mediaViewWillPresentScreen:(BDMRichMediaView *)mediaView;
/// Called after media view dissmissed product link in StoreKit or Safari
/// view controller internally in application after user interaction
/// @param mediaView Media view that recieved user interaction
- (void)mediaViewDidDismissScreen:(BDMRichMediaView *)mediaView;
@end

@interface BDMRichMediaView : UIView <BDMAdEventProducer>
/// Delegate of producer
@property (nonatomic, weak, nullable) id<BDMAdEventProducerDelegate> producerDelegate;
/// Callback handler
@property (nonatomic, weak, nullable) id<BDMRichMediaDelegate> delegate;
/// Root view controller for presenting modal controllers and
/// viewability tracking
@property (nonatomic, weak, nullable) IBOutlet UIViewController *rootViewController;
/// Info of latest successful auction
@property (nonatomic, copy, readonly, nullable) BDMAuctionInfo *latestAuctionInfo;
/// Getter that indicates if ad is ready or not
@property (nonatomic, assign, readonly, getter=isLoaded) BOOL loaded;
/// Boolean flag that indicates if SDK can show ad or not
@property (nonatomic, assign, readonly) BOOL canShow;
/// Adds request to ad object instance. If request was not
/// performed, ad object will perform request by itslef
/// @param request Request
- (void)populateWithRequest:(BDMRichMediaRequest *)request;
/// Call this method to pause media view
- (void)pause;
/// Call this method to resume media view
- (void)resume;
/// Call this method to mute media view
- (void)mute;
/// Call this method to unmute media view
- (void)unmute;
@end

NS_ASSUME_NONNULL_END
