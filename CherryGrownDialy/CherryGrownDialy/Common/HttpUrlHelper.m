//
//  HttpUrlHelper.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/7.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "HttpUrlHelper.h"
//#define kBasePostHost    @"http://192.168.3.2:8080"
#define kBasePostHost    @"http://192.168.3.2:8080/ServletDemo"
@implementation HttpUrlHelper

+ (NSString*) basePostPath
{
    return [NSString stringWithFormat:@"%@/CommonServiceInterface?service=", kBasePostHost];
    
}

//用户模块
+ (NSString*) postUserServiceUrl:(NSString*)method
{
    NSString* sBaseUrl = [[self basePostPath] stringByAppendingString:@"userService"];
    NSString* sUrl = [sBaseUrl stringByAppendingFormat:@"&method=%@", method];
    return sUrl;
}

//分类模块
+ (NSString*) postCategoryServiceUrl:(NSString*)method
{
    NSString* sBaseUrl = [[self basePostPath] stringByAppendingString:@"categoryService"];
    NSString* sUrl = [sBaseUrl stringByAppendingFormat:@"&method=%@", method];
    return sUrl;
}

+ (NSString*) postDialyServiceUrl:(NSString*)method{
    NSString* sBaseUrl = [[self basePostPath] stringByAppendingString:@"dialyService"];
    NSString* sUrl = [sBaseUrl stringByAppendingFormat:@"&method=%@", method];
    return sUrl;
}
@end
