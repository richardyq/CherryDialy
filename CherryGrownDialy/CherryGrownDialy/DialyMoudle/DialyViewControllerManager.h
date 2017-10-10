//
//  DialyViewControllerManager.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/8.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RecentDialyListTableViewController.h"

@interface DialyViewControllerManager : NSObject

//进入新增日记界面
+ (void) entryDialyInputPage;

//进入日记详情页面
+ (void) entryDialyDetailPage:(NSInteger) id;
@end
