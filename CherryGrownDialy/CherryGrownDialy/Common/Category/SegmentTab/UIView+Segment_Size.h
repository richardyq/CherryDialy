//
//  UIView+Segment_Size.h
//  SegmentDemo
//
//  Created by yinquan on 17/2/14.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenWdidth ([UIScreen mainScreen].bounds.size.width)


@interface UIView (Segment_Size)

- (CGSize) size;

- (CGFloat) width;
- (CGFloat) height;

- (void) setWidth:(CGFloat) width;
- (void) setHeight:(CGFloat) height;

@end
