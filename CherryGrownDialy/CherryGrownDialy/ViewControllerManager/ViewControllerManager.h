//
//  ViewControllerManager.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/6.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseNavigationViewController.h"
#import "CDBaseViewController.h"

@interface ViewControllerManager : NSObject

+ (ViewControllerManager*) defaultManager;

/*
 entryWelcomePage 进入欢迎页面
 */
- (void) entryWelcomePage;

/*
 进入首页
 */
- (void) entryHomePage;

- (UIViewController *) topMostViewController;

- (CDBaseViewController*) entryPageViewController:(CDBaseViewController*) pageViewController;
@end
