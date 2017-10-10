//
//  SegmentBar.h
//  SegmentDemo
//
//  Created by yinquan on 17/2/14.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentBar : UIView

@property (nonatomic, assign) NSInteger selectedIndex;


- (void) createCells:(NSArray*) titles;
- (void) setSegmentTitle:(NSString*) title atIndex:(NSInteger) index;

- (void) setHighlightColor:(UIColor*) aHighlightColor;
@end
