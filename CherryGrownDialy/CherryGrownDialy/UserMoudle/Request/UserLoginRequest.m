//
//  UserLoginRequest.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/7.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "UserLoginRequest.h"

@implementation UserLoginRequest

@synthesize reqeustParam = _reqeustParam;

- (id) initWithAccount:(NSString*) account
              Password:(NSString*) password
{
    self = [super init];
    if (self) {
        _reqeustParam = [NSMutableDictionary dictionary];
        [_reqeustParam setValue:account forKey:@"loginacct"];
        [_reqeustParam setValue:password forKey:@"loginpwd"];
        
    }
    return self;
    
}

- (NSString*) postUrl
{
    NSString* postUrl = [HttpUrlHelper postUserServiceUrl:@"userLogin"];
    return postUrl;
}

- (RequestErrorCode) paraserResultJson:(id) result
{
    if (![result isKindOfClass:[NSDictionary class]]) {
        errorMessage = @"读取服务器数据错误。请联系管理员。";
        return Error_NetworkError;
    }
    NSDictionary* dicResp = (NSDictionary*) result;
    
    
    UserAccountModel* loginedUser = [UserAccountModel mj_objectWithKeyValues:dicResp];
    
    //保存用户信息
    [[CommonDataHelper defaultManager] setLoginUserModel:loginedUser];
    return Error_None;
}


@end
