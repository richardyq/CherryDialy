//
//  UIColor+Standand.h
//  JYJKFrameDemo
//
//  Created by yinquan on 17/4/21.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Standand)

+ (id) colorWithHexString:(NSString*) hexColor;

//半透明
+ (UIColor*) commonTranslucentColor;
//主题颜色
+ (UIColor*) mainThemeColor;
//背景颜色
+ (UIColor*) commonBackgroundColor;

//常规控件border颜色
+ (UIColor*) commonControlBorderColor;

//常规字体颜色
+ (UIColor*) commonTextColor;

//灰色字体颜色
+ (UIColor*) commonGrayTextColor;

//常规字体颜色
+ (UIColor*) commonLightGrayTextColor;

//自定义蓝色
+ (UIColor*) commonBlueColor;
//自定义绿色
+ (UIColor*) commonGreenColor;
//自定义橙色
+ (UIColor*) commonOrangeColor;
//自定义紫色
+ (UIColor*) commonVioletColor;
//自定义红色
+ (UIColor*) commonRedColor;
@end
