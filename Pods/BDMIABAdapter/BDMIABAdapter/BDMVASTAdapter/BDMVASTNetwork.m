//
//  BDMVASTNetwork.h
//  BDMVASTNetwork
//
//  Created by Pavel Dunyashev on 24/09/2018.
//  Copyright © 2018 Appodeal. All rights reserved.
//

#import "BDMVASTNetwork.h"
#import "BDMVASTVideoAdapter.h"
#import "BDMVASTViewAdapter.h"

#import <StackVASTKit/StackVASTKit.h>


@implementation BDMVASTNetwork

#pragma mark - BDMNetwork

- (NSString *)name {
    return @"vast";
}

- (NSString *)sdkVersion {
    return StackVASTKitVersion;
}

- (id<BDMFullscreenAdapter>)videoAdapterForSdk:(BDMSdk *)sdk {
    return [BDMVASTVideoAdapter new];
}

- (id<BDMRichMediaAdapter>)richMediaAdapterForSdk:(BDMSdk *)sdk {
    return [BDMVASTViewAdapter new];
}


@end

