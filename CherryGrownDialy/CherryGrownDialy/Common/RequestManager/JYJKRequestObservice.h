//
//  JYJKRequestObservice.h
//  JYJKFrameDemo
//
//  Created by yinquan on 2017/4/24.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYJKRequestObservice : NSObject

@property (nonatomic, weak) id object;  //调用者
@property (nonatomic) SEL resultSelector;   //返回结果
@property (nonatomic) SEL returnSelector;   //执行完成

- (id) initWithObject:(id) object resultSelector:(SEL) resultSelector returnSelector:(SEL) returnSelector;

@end
