//
//  CommonUtil.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/6.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "CommonUtil.h"



@implementation CommonUtil

+ (AppDelegate*) rootApp
{
    AppDelegate* rootApp = (AppDelegate*)[UIApplication sharedApplication].delegate;
    return rootApp;
}

+ (UIWindow*) rootWindow
{
    AppDelegate* rootApp = [self rootApp];
    UIWindow* rootWindow = rootApp.window;
    return rootWindow;
}

@end
