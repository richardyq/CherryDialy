//
//  CommonDataHelper.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/6.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkStatusUtil.h"


@class UserAccountModel;

@interface CommonDataHelper : NSObject

@property (nonatomic, retain) NSArray* categoryList;
@property (nonatomic, retain) NSArray* tagsList;

#pragma mark - 网络状态

- (void) checkNetowrkStatus:(NetworkStatusChanged) block;

+ (CommonDataHelper*) defaultManager;

- (AFNetworkReachabilityStatus) networkStatus;

- (NSString*) loginedUserId;
- (void) setLoginUserModel:(UserAccountModel*) accountModel;


@end
