//
//  UIImage+Shape.h
//  JYJKFrameDemo
//
//  Created by yinquan on 17/4/21.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到小
    GradientTypeLeftToRight = 1,//从左到右
    GradientTypeUpleftToLowright = 2,//左上到右下
    GradientTypeUprightToLowleft = 3,//右上到左下
};


@interface UIImage (Shape)

+ (UIImage*) rectImage:(CGSize) size Color:(UIColor*) color;

+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize;

@end
