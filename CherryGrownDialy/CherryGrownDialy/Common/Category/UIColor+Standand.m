//
//  UIColor+Standand.m
//  JYJKFrameDemo
//
//  Created by yinquan on 17/4/21.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "UIColor+Standand.h"

@implementation UIColor (Standand)

+ (id) colorWithHexString:(NSString*) hexColor
{
    return  [self colorWithHexString:hexColor alpha:1.0f];
}

+ (id)colorWithHexString:(NSString*)hexColor alpha:(CGFloat)alpha {
    
    unsigned int red,green,blue;
    NSRange range;
    
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    UIColor* retColor = [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:alpha];
    return retColor;
}


+ (UIColor*) commonTranslucentColor
{
    UIColor* commonTranslucentColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    return commonTranslucentColor;
}

+ (UIColor*) mainThemeColor
{
    UIColor* themeColor = [UIColor colorWithHexString:@"E02928"];

    return themeColor;
}

//背景颜色
+ (UIColor*) commonBackgroundColor
{
    UIColor* bgColor = [UIColor colorWithHexString:@"F0F0F0"];
    return bgColor;
}

//常规控件border颜色
+ (UIColor*) commonControlBorderColor
{
    UIColor* borderColor = [UIColor colorWithHexString:@"dfdfdf"];
    return borderColor;
}

//常规字体颜色
+ (UIColor*) commonTextColor
{
    UIColor* textColor = [UIColor colorWithHexString:@"333333"];
    return textColor;
}

//灰色字体颜色
+ (UIColor*) commonGrayTextColor
{
    UIColor* textColor = [UIColor colorWithHexString:@"999999"];
    return textColor;
}

//常规字体颜色
+ (UIColor*) commonLightGrayTextColor
{
    UIColor* textColor = [UIColor colorWithHexString:@"cccccc"];
    return textColor;
}

+ (UIColor*) commonBlueColor
{
    UIColor* textColor = [UIColor colorWithHexString:@"4AB0FF"];
    return textColor;
}

+ (UIColor*) commonGreenColor
{
    UIColor* textColor = [UIColor colorWithHexString:@"2ECC71"];
    return textColor;
}

//自定义橙色
+ (UIColor*) commonOrangeColor
{
    UIColor* textColor = [UIColor colorWithHexString:@"FFa63C"];
    return textColor;
}
//自定义红紫色
+ (UIColor*) commonVioletColor
{
    UIColor* textColor = [UIColor colorWithHexString:@"FF6098"];
    return textColor;
}
//自定义红色
+ (UIColor*) commonRedColor
{
    UIColor* textColor = [UIColor colorWithHexString:@"FF6666"];
    return textColor;
}

@end
