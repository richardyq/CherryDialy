//
//  DialyViewControllerManager.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/8.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "DialyViewControllerManager.h"

#import "DialyInputViewController.h"

@implementation DialyViewControllerManager

+ (void) entryDialyInputPage{
    DialyInputViewController* inputViewController = [[DialyInputViewController alloc] initWithNibName:nil bundle:nil];
    [[ViewControllerManager defaultManager] entryPageViewController:inputViewController];
}
@end
