//
//  UserMoudleUtil.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/6.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "UserMoudleUtil.h"
#import "UserLoginRequest.h"

@implementation UserMoudleUtil

+ (void) startUserLogin:(NSString*) account
               Password:(NSString*) password
        observiceObject:(id) object
         resultSelector:(SEL) resultSelector
         returnSelector:(SEL) returnSelector{
    
    UserLoginRequest* request = [[UserLoginRequest alloc] initWithAccount:account Password:password];
    JYJKRequestObservice* observiceModel = [[JYJKRequestObservice alloc] initWithObject:object resultSelector:resultSelector returnSelector:returnSelector];
    [[JYJKRequestManager defaultManager] createRequest:request observice:observiceModel];
}
@end
