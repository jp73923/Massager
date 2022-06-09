//
//  BDMNASTActionController.m
//  BDMNASTAdapter
//
//  Created by Ilia Lozhkin on 08.09.2020.
//  Copyright © 2020 Stas Kochkin. All rights reserved.
//

@import StackUIKit;
@import StackFoundation;
@import StackProductPresentation;

#import "BDMNASTActionController.h"


@interface BDMNASTActionController ()<STKProductControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic,   copy) NSArray<NSURL *> *clicks;
@property (nonatomic,   copy) NSDictionary<NSString *,NSString *> *info;
@property (nonatomic, strong) STKProductController *productPresenter;
@property (nonatomic, strong) NSMutableArray<UITapGestureRecognizer *> *gestures;

@end

@implementation BDMNASTActionController

- (instancetype)initWithAd:(STKNASTAd *)ad info:(NSDictionary<NSString *,NSString *> *)info {
    if (self = [super init]) {
        _info       = info;
        _clicks     = ad.clickThrough;
        _gestures   = NSMutableArray.new;
    }
    return self;
}

- (void)registerClickableViews:(NSArray<UIView *> *)clickableViews {
    [self invalidate];
    [clickableViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * stop) {
        UITapGestureRecognizer *gesture = [self tapGestureRecognizer];
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:gesture];
        [self.gestures addObject:gesture];
    }];
}

- (void)invalidate {
    [self.gestures removeAllObjects];
}

#pragma mark - Action

- (void)userInteraction {
    [STKSpinnerScreen show];
    [self.productPresenter present:[self productParametersWithUrls:self.clicks]];
}

#pragma mark - Private

- (STKProductController *)productPresenter {
    if (!_productPresenter) {
        _productPresenter = [STKProductController new];
        _productPresenter.delegate = self;
    }
    return _productPresenter;
}

- (NSDictionary *)productParametersWithUrls:(NSArray<NSURL *>*)urls {
    NSMutableDictionary *productParameters = self.info.mutableCopy;
    productParameters[STKProductController.clickThroughKey] = urls;
    return productParameters.copy;
}

- (UITapGestureRecognizer *)tapGestureRecognizer {
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userInteraction)];
    gesture.numberOfTouchesRequired = 1;
    return gesture;
}

#pragma mark - STKProductControllerDelegate

- (void)controller:(STKProductController * _Nonnull)controller didFailToPresent:(NSError * _Nonnull)error {
    [STKSpinnerScreen hide];
}

- (void)controller:(STKProductController * _Nonnull)controller willPresentProduct:(NSDictionary<NSString *, NSObject *> * _Nonnull)parameters {
    [STKSpinnerScreen hide];
    [self.eventController trackAction];
}

- (void)controller:(STKProductController * _Nonnull)controller willLeaveApplication:(NSDictionary<NSString *, NSObject *> * _Nonnull)parameters {
    [STKSpinnerScreen hide];
    [self.eventController trackAction];
}

@end
