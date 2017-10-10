//
//  NSObject+WaitingHUB.m
//  JYDoctorDemo
//
//  Created by yinquan on 2017/6/26.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "NSObject+WaitingHUB.h"

static const NSInteger kWXMImageProgressViewTag = 0x5420;


@implementation NSObject (WaitingHUB)

- (void) showWaitingHub
{
    UIView* topMostView = [[ViewControllerManager defaultManager] topMostViewController].view;
    
    MBProgressHUD* progressHub = [topMostView viewWithTag:kWXMImageProgressViewTag];
    if (progressHub)
    {
        return;
    }

    progressHub = [[MBProgressHUD alloc] initWithView:topMostView];
    [topMostView addSubview:progressHub];
    [topMostView bringSubviewToFront:progressHub];
    
    progressHub.label.text = @"数据加载中...";
    [progressHub showAnimated:YES];
    [progressHub setTag:kWXMImageProgressViewTag];
}

- (void) showWaitingHub:(NSString*) content
{
    UIView* topMostView = [[ViewControllerManager defaultManager] topMostViewController].view;
    MBProgressHUD* progressHub = [topMostView viewWithTag:kWXMImageProgressViewTag];
    if (!progressHub)
    {
        progressHub = [[MBProgressHUD alloc] initWithView:topMostView];
        [topMostView addSubview:progressHub];
        [topMostView bringSubviewToFront:progressHub];
        
        
        [progressHub setTag:kWXMImageProgressViewTag];
    }
    progressHub.label.text = content;
    [progressHub showAnimated:YES];
}

- (void) closeWaitingHub
{
    UIView* topMostView = [[ViewControllerManager defaultManager] topMostViewController].view;
    MBProgressHUD* progressHub = [topMostView viewWithTag:kWXMImageProgressViewTag];
    if (progressHub)
    {
        [progressHub removeFromSuperview];
        //[progressHub release];
        progressHub = nil;
    }

}
@end
