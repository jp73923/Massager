//
//  BDMVASTViewAdapter.h
//  BDMVASTAdapter
//
//  Created by Ilia Lozhkin on 18.10.2021.
//  Copyright © 2021 Stas Kochkin. All rights reserved.
//

@import Foundation;
@import BidMachine.Adapters;

NS_ASSUME_NONNULL_BEGIN

@interface BDMVASTViewAdapter : NSObject <BDMRichMediaAdapter>

@property (nonatomic,   weak) id <BDMAdapterLoadingDelegate> loadingDelegate;
@property (nonatomic,   weak) id <BDMRichMediaAdapterDisplayDelegate> displayDelegate;

@end

NS_ASSUME_NONNULL_END
