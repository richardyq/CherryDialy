//
//  UIView+Boarder.m
//  JYClientDemo
//
//  Created by yinquan on 2017/4/26.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "UIView+Boarder.h"

//#define kBottomLineTag          0x9864
//#define kTopLineTag             (0x9864 + 1)

static const NSInteger kBaseLineTag = 0x9864;
static const NSInteger kLeftLineTag = kBaseLineTag;
static const NSInteger kTopLineTag = kBaseLineTag + 1;
static const NSInteger kRightLineTag = kBaseLineTag + 2;
static const NSInteger kBottomLineTag = kBaseLineTag + 3;

@implementation UIView (Boarder)

- (void) showTopLine
{
    UIImageView* ivTopLine = nil;
    NSArray* subviews = [self subviews];
    for (UIView* subview in subviews)
    {
        if (subview.superview == self && kTopLineTag == subview.tag ) {
            ivTopLine = (UIImageView*)subview;
            break;
        }
    }
    if (ivTopLine)
    {
        return;
    }
    
    ivTopLine = [[UIImageView alloc]init];
    [self addSubview:ivTopLine];
    [ivTopLine setTag:kTopLineTag];
    [ivTopLine setBackgroundColor:[UIColor commonControlBorderColor]];
    
    [ivTopLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_equalTo(@0.5);
    }];
}

- (void) showBottomLine
{
    UIImageView* ivBottomLine = nil;
    NSArray* subviews = [self subviews];
    for (UIView* subview in subviews)
    {
        if (subview.superview == self && kBottomLineTag == subview.tag ) {
            ivBottomLine = (UIImageView*)subview;
            break;
        }
    }
    if (ivBottomLine)
    {
        
        return;
    }
    
    ivBottomLine = [[UIImageView alloc]init];
    [self addSubview:ivBottomLine];
    [ivBottomLine setTag:kBottomLineTag];
    [ivBottomLine setBackgroundColor:[UIColor commonControlBorderColor]];
    
    [ivBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(@0.5);
    }];
}

- (void) showLeftLine
{
    UIImageView* ivLeftLine = nil;
    NSArray* subviews = [self subviews];
    for (UIView* subview in subviews)
    {
        if (subview.superview == self && kLeftLineTag == subview.tag ) {
            ivLeftLine = (UIImageView*)subview;
            break;
        }
    }
    if (ivLeftLine)
    {
        return;
    }
    
    ivLeftLine = [[UIImageView alloc]init];
    [self addSubview:ivLeftLine];
    [ivLeftLine setTag:kLeftLineTag];
    [ivLeftLine setBackgroundColor:[UIColor commonControlBorderColor]];
    
    [ivLeftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(@0.5);
    }];
}
- (void) showRightLine
{
    UIImageView* ivRightLine = nil;
    NSArray* subviews = [self subviews];
    for (UIView* subview in subviews)
    {
        if (subview.superview == self && kRightLineTag == subview.tag ) {
            ivRightLine = (UIImageView*)subview;
            break;
        }
    }
    if (ivRightLine)
    {
        return;
    }
    
    ivRightLine = [[UIImageView alloc]init];
    [self addSubview:ivRightLine];
    [ivRightLine setTag:kLeftLineTag];
    [ivRightLine setBackgroundColor:[UIColor commonControlBorderColor]];
    
    [ivRightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(@0.5);
    }];
    
}

@end
