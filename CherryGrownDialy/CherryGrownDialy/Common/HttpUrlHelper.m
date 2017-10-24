//
//  HttpUrlHelper.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/7.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "HttpUrlHelper.h"


//static NSString* kBasePostHost = @"http://192.168.3.2:8080/ServletDemo";


#ifdef Network_Release
//阿里云服务器地址
#define kBasePostHost   @"http://47.95.238.82:8080"
#define kBasePostPath   @"CommonServiceInterface/base.do"
#else
//测试本机接口
#define kBasePostHost    @"http://192.168.3.2:8080/ServletDemo"
#define kBasePostPath   @"CommonServiceInterface"
#endif

@implementation HttpUrlHelper

+ (NSString*) basePostPath
{
    return [NSString stringWithFormat:@"%@/%@?service=", kBasePostHost, kBasePostPath];
    
}

+ (NSString*) uploadPostPath
{
    return [NSString stringWithFormat:@"%@/ImageUpload?service=", kBasePostHost];
    
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

+ (NSString*) postPhotoServiceUrl:(NSString*)method{
    NSString* sBaseUrl = [[self basePostPath] stringByAppendingString:@"photoService"];
    NSString* sUrl = [sBaseUrl stringByAppendingFormat:@"&method=%@", method];
    return sUrl;
}

+ (NSString*) postUploadData:(NSString*) method{
    NSString* sBaseUrl = [[self uploadPostPath] stringByAppendingString:@"ImageService"];
    NSString* sUrl = [sBaseUrl stringByAppendingFormat:@"&method=%@", method];
    return sUrl;
}
@end
