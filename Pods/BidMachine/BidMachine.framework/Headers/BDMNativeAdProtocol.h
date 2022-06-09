//
//  BDMNativeAdProtocol.h
//  BidMachine
//
//  Created by Ilia Lozhkin on 01.11.2021.
//  Copyright © 2021 Appodeal. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Native ad rendering protocol
@protocol BDMNativeAdRendering <NSObject>
/// Label for title
/// @return Nonnul instance of label
- (nonnull UILabel *)titleLabel;
/// Label for call to action text
/// @return Nonnul instance of label
- (nonnull UILabel *)callToActionLabel;
/// Label for description text
/// @return Nonnul instance of label
- (nonnull UILabel *)descriptionLabel;
@optional
/// Icon view for icon asset rendering
/// @return Nonnul instance of label may contains placeholder
- (nonnull UIImageView *)iconView;
/// Container for media content
/// @return  Nonnul instance of label may contains with aspect ratio 16:9
- (nonnull UIView *)mediaContainerView;
/// Container for AdChoice view content
/// @return  Nonnul instance of label may contains with aspect ratio 16:9
- (nonnull UIView *)adChoiceView;
/// Is called with rating value
/// @param rating Rating value number
- (void)setStarRating:(nonnull NSNumber *)rating;

@end
@protocol BDMNativeAdAssets <NSObject>
/// Title text
@property(nonatomic, readonly, copy, nonnull) NSString *title;
/// Description
@property(nonatomic, readonly, copy, nonnull) NSString *body;
/// Call to action text
@property(nonatomic, readonly, copy, nonnull) NSString *CTAText;
/// Icon image url
@property(nonatomic, readonly, copy, nonnull) NSString *iconUrl;
/// Main image url
@property(nonatomic, readonly, copy, nonnull) NSString *mainImageUrl;
/// App store rating (0 to 5)
@property(nonatomic, readonly, copy, nullable) NSNumber *starRating;
/// Contains video
@property(nonatomic, readonly, assign) BOOL containsVideo;

@end

NS_ASSUME_NONNULL_END
