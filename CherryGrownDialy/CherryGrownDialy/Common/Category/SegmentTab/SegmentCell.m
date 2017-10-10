//
//  SegmentCell.m
//  SegmentDemo
//
//  Created by yinquan on 17/2/14.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "SegmentCell.h"
#import "UIColor+Segment.h"

@interface SegmentCell ()
{
    UIColor* highlightTextColor;
    UIColor* normalTextColor;
    
}

@property (nonatomic, readonly) UILabel* titleLable;

@end

@implementation SegmentCell

@synthesize titleLable = _titleLable;


- (instancetype)init
{
    self = [super init];
    if (self)
    {
//        [self setBackgroundColor:[UIColor redColor]];
        highlightTextColor = [UIColor mainThemeColor];
        normalTextColor = [UIColor commonGrayTextColor];
        
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
    return self;
}

- (UILabel*) titleLable
{
    if (!_titleLable)
    {
        _titleLable = [[UILabel alloc] init];
        [self addSubview:_titleLable];
        
        [_titleLable setFont:[UIFont systemFontOfSize:15]];
        [_titleLable setTextColor:normalTextColor];
        
        
    }
    return _titleLable;
}

- (void) setTitle:(NSString*) title
{
    [self.titleLable setText:title];
}

- (void) setHighlightColor:(UIColor*) aHighlightColor
{
    highlightTextColor = aHighlightColor;
    if (self.selected)
    {
        [self.titleLable setTextColor:highlightTextColor];
    }
}

- (void) setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected)
    {
        [_titleLable setTextColor:highlightTextColor];
    }
    else
    {
        [_titleLable setTextColor:normalTextColor];
    }
}
@end
