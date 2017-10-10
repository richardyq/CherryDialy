//
//  UserLoginRequest.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/7.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "JYJKHttpJsonRequest.h"

@interface UserLoginRequest : JYJKHttpJsonRequest

- (id) initWithAccount:(NSString*) account
              Password:(NSString*) password;

@end
