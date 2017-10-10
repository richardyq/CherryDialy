//
//  UIColor+Segment.m
//  SegmentDemo
//
//  Created by yinquan on 17/2/14.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "UIColor+Segment.h"

@implementation UIColor (Segment)

+ (id) colorWithHexString:(NSString*) hexColor
{
    unsigned int red,green,blue;
    NSRange range;
    
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    UIColor* retColor = [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:1.0f];
    return retColor;
}

@end
