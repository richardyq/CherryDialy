//
//  JYJKRequestObservice.m
//  JYJKFrameDemo
//
//  Created by yinquan on 2017/4/24.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "JYJKRequestObservice.h"

@implementation JYJKRequestObservice

- (BOOL) isEqualTo:(id)object
{
    if (!object || [object isKindOfClass:[JYJKRequestObservice class]]) {
        return NO;
    }
    JYJKRequestObservice* observice = (JYJKRequestObservice*) object;
    return self.object == observice.object;
}

- (id) initWithObject:(id) object resultSelector:(SEL) resultSelector returnSelector:(SEL) returnSelector
{
    self = [super init];
    if (self) {
        _object = object;
        _resultSelector = resultSelector;
        _returnSelector = returnSelector;
    }
    return self;
}

@end
