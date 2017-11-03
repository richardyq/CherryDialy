//
//  PhotoModelList.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/11/1.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "PhotoModelList.h"

@implementation PhotoModelList

+ (NSDictionary *)objectClassInArray{
    return @{
             @"list" : [PhotoInfoModel class]
             
             };
}

@end
