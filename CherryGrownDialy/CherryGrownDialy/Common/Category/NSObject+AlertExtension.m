//
//  NSObject+AlertExtension.m
//  JYJKFrameDemo
//
//  Created by yinquan on 2017/4/24.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "NSObject+AlertExtension.h"

@implementation NSObject (AlertExtension)



- (void) showAlertMessage:(NSString*) message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [[[ViewControllerManager defaultManager] topMostViewController] presentViewController:alert animated:YES completion:nil];
}

- (void) showAlertMessage:(NSString*) message handler:(void (^ __nullable)(UIAlertAction *action))handler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:handler]];
    [[[ViewControllerManager defaultManager] topMostViewController]  presentViewController:alert animated:YES completion:nil];
}

@end
