//
//  SegmentViewController.h
//  SegmentDemo
//
//  Created by yinquan on 17/2/14.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SegmentBar.h"

@interface SegmentViewController : UIViewController

@property (nonatomic, assign) CGFloat segmentBarHeight;

@property (nonatomic, readonly) SegmentBar* segmentBar;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, retain) NSArray* viewControllers;

//- (void) setViewControllers:(NSArray<__kindof UIViewController *> *)aViewControllers;

- (void) setSegmentTitle:(NSString*) title atIndex:(NSInteger) index;

- (void) setHighlightColor:(UIColor*) highlightColor;
@end
