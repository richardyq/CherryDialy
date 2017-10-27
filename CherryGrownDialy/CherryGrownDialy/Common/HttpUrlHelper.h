//
//  HttpUrlHelper.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/7.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef Network_Release
//阿里云服务器地址
#define kBasePostHost   @"http://47.95.238.82:8080"
#define kBasePostPath   @"CommonServiceInterface/base.do"
#else
//测试本机接口
#define kBasePostHost    @"http://192.168.3.2:8080/ServletDemo"
#define kBasePostPath   @"CommonServiceInterface"
#endif


@interface HttpUrlHelper : NSObject

//用户模块
+ (NSString*) postUserServiceUrl:(NSString*)method;

//分类模块
+ (NSString*) postCategoryServiceUrl:(NSString*)method;

//日记模块
+ (NSString*) postDialyServiceUrl:(NSString*)method;

//照片模块
+ (NSString*) postPhotoServiceUrl:(NSString*)method;

//上传文件
+ (NSString*) postUploadData:(NSString*) method;
@end
