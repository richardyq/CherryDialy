//
//  UserMoudleUtil.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/6.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserAccountModel.h"
#import "UserInfoModel.h"

@interface UserMoudleUtil : NSObject

/*
 startUserLogin
 调用登录接口
 */

+ (void) startUserLogin:(NSString*) account
                Password:(NSString*) password
         observiceObject:(id) object
          resultSelector:(SEL) resultSelector
          returnSelector:(SEL) returnSelector;

@end
