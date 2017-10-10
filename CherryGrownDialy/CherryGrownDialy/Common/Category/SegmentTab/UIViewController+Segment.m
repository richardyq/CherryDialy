//
//  UIViewController+Segment.m
//  SegmentDemo
//
//  Created by yinquan on 17/2/16.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "UIViewController+Segment.h"
#import "SegmentViewController.h"

@implementation UIViewController (Segment)

- (void) SGM_SetTitle:(NSString*) title
{
    [self setTitle:title];
    
    UIViewController* parentController = self.parentViewController;
    if (!parentController || [parentController isKindOfClass:[SegmentViewController class]])
    {
        return;
    }
    
    SegmentViewController* segmentController = (SegmentViewController*) parentController;
    NSArray* controllerList = segmentController.viewControllers;
    NSInteger controllerIndex = [controllerList indexOfObject:self];
    if (controllerIndex == NSNotFound) {
        return;
    }
    [segmentController setSegmentTitle:title atIndex:controllerIndex];
}


@end
