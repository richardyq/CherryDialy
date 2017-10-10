//
//  NSObject+WaitingHUB.h
//  JYDoctorDemo
//
//  Created by yinquan on 2017/6/26.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WaitingHUB)

- (void) showWaitingHub;

- (void) showWaitingHub:(NSString*) content;

- (void) closeWaitingHub;
@end
