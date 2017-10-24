//
//  UIImage+Shape.m
//  JYJKFrameDemo
//
//  Created by yinquan on 17/4/21.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "UIImage+Shape.h"

@implementation UIImage (Shape)

+ (UIImage*) rectImage:(CGSize) size Color:(UIColor*) color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width , size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
