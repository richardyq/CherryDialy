//
//  UIView+Segment_Size.m
//  SegmentDemo
//
//  Created by yinquan on 17/2/14.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "UIView+Segment_Size.h"

@implementation UIView (Segment_Size)



- (CGSize) size
{
    CGSize size = self.bounds.size;
    return size;
}

- (CGFloat) width
{
    CGSize size = [self size];
    return size.width;
}

- (void) setWidth:(CGFloat) width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    [self setFrame:frame];
}

- (CGFloat) height
{
    CGSize size = [self size];
    return size.height;
}

- (void) setHeight:(CGFloat) height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    [self setFrame:frame];
}

@end
