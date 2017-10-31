//
//  JYJKHttpRequest.m
//  JYJKFrameDemo
//
//  Created by yinquan on 2017/4/24.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "JYJKHttpRequest.h"


#define kIOSDeviceTokenKey      @"deviceToken"
#define kZJKVersionKey          @"appVersion"
#define kZJKCallTypeKey         @"calltype"
#define kZJKOrgGroupCode        @"orgGroupCode"
#define kZJKUserIdKey           @"userId"
#define kZJKOperateUserIdKey    @"operatorUserId"


@implementation JYJKHttpRequest

- (NSString*) postUrl
{
    return nil;
}

- (NSMutableDictionary*) commonPostParam
{
    NSMutableDictionary* commonParamDictionary = [NSMutableDictionary dictionary];
    
    CommonDataHelper* commonDataManager = [CommonDataHelper defaultManager];
    
    
    //用户ID
    NSString* userId = [commonDataManager loginedUserId];
    if (userId && userId.length > 0)
    {
        [commonParamDictionary setValue:[NSString stringWithFormat:@"%@", userId] forKey:kZJKUserIdKey];
        [commonParamDictionary setValue:[NSString stringWithFormat:@"%@", userId] forKey:kZJKOperateUserIdKey];
    }
    
    return commonParamDictionary;
}

- (NSInteger) runRequest
{
    errorCode = Error_None;
    AFNetworkReachabilityStatus networkStatus = [CommonDataHelper defaultManager].networkStatus;
    switch (networkStatus) {
        case AFNetworkReachabilityStatusUnknown:
        case AFNetworkReachabilityStatusNotReachable:
        {
            //没有网络连接
            errorMessage = @"网络连接不可用，请检查网络设置。";
            return Error_NetworkInvalid;
            break;
        }
            
            
        default:
            break;
    }
    
    //构造PostUrl 和 Post参数
    NSString* postUrl = [self postUrl];
    NSDictionary* postParam = [self makePostParam];
    
    [self startPost:postUrl param:postParam];
    [self lock];
    
    return errorCode;
}

- (NSDictionary*) makePostParam
{
    NSMutableDictionary* postParam = [self commonPostParam];
    if (self.reqeustParam && [self.reqeustParam isKindOfClass:[NSDictionary class]])
    {
        [postParam addEntriesFromDictionary:self.reqeustParam];
    }

    return postParam;
}

- (void) startPost:(NSString*) postUrl param:(id) param
{
    
}

- (void) postSuccess:(NSURLSessionDataTask *) task Response:(id) responseObject
{
    NSLog(@"jsonPostSuccess operation %@", task.response.URL.absoluteString);
    
    [self parserResponeData:responseObject];
    //解析数据
    [self unlock];
}

- (void) parserResponeData:(NSData*) responseObject
{
    
}

- (void) postFailed:(NSURLSessionDataTask *) task Error:(NSError*) error
{
    NSLog(@"jsonPostFailed called.");
    NSLog(@"%@", error.domain);
    errorCode = Error_NetworkError;
    errorMessage = @"接口调用失败。";
    
    [self unlock];
}

@end
