//
//  NSObject+AlertExtension.h
//  JYJKFrameDemo
//
//  Created by yinquan on 2017/4/24.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AlertExtension)

- (void) showAlertMessage:(NSString* _Nonnull ) message;

- (void) showAlertMessage:(NSString* _Nonnull ) message handler:(void (^ __nullable)(UIAlertAction * _Nullable action))handler;

@end
