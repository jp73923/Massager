//
//  STKVideoCloseButton.h
//  StackVideoPlayer
//
//  Created by Stas Kochkin on 14.10.2020.
//

#import <UIKit/UIKit.h>
#import <StackIABAssets/STKIABAssetsDefines.h>
#import <StackIABAssets/STKIABViewProtocol.h>


@interface STKIABClosableView : UIView <STKIABViewProtocol>

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) UIColor *strokeColor;
@property (nonatomic, copy) UIColor *fillColor;
@property (nonatomic, copy) UIColor *shadowColor;
@property (nonatomic, copy) UIFont *font;

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic, assign) BOOL outlined;
@property (nonatomic, assign) CGFloat strokeWidth;

@property (nonatomic, copy) void(^onTouchInside)(void);

- (instancetype)initWithStyle:(STKIABClosableViewStyle)style;

@end
