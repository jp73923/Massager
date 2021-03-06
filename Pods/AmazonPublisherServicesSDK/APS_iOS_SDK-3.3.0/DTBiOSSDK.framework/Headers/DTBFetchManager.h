/*
* Copyright 2018-2019 Amazon.com,
* Inc. or its affiliates. All Rights Reserved.
* Licensed under the Amazon Software License (the "License").
* You may not use this file except in compliance with the
* License. A copy of the License is located at
* http://aws.amazon.com/asl/
* or in the "license" file accompanying this file. This file is
* distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
* CONDITIONS OF ANY KIND, express or implied. See the License
* for the specific language governing permissions and
* limitations under the License.
*/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class DTBAdResponse;
@class DTBFetchManager;

@interface DTBFetchManager : NSObject

@property(nonatomic)NSError * _Nullable error;
@property(nonatomic)BOOL isActive;

- (instancetype)init NS_UNAVAILABLE;

- (DTBAdResponse * _Nullable) peek;
- (DTBAdResponse * _Nullable) pop;

-(void)start;
-(void)stop;
-(BOOL)isEmpty;

@end

NS_ASSUME_NONNULL_END
