//
//  HttpUrlHelper.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/7.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpUrlHelper : NSObject

//用户模块
+ (NSString*) postUserServiceUrl:(NSString*)method;

//分类模块
+ (NSString*) postCategoryServiceUrl:(NSString*)method;

//日记模块
+ (NSString*) postDialyServiceUrl:(NSString*)method;
@end
