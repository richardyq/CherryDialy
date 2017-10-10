//
//  CategoryMoudleUtil.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/7.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "CategoryMoudleUtil.h"
#import "CategoryListRequest.h"
#import "TagListResult.h"

@implementation CategoryMoudleUtil

/*
 startLoadCategoryList
 获取分类列表
 */
+ (void) startLoadCategoryList:(id) object
                resultSelector:(SEL) resultSelector
                returnSelector:(SEL) returnSelector{
    CategoryListRequest* request = [[CategoryListRequest alloc] init];
    JYJKRequestObservice* observiceModel = [[JYJKRequestObservice alloc] initWithObject:object resultSelector:resultSelector returnSelector:returnSelector];
    [[JYJKRequestManager defaultManager] createRequest:request observice:observiceModel];
}

/*
 startLoadCategoryList
 获取标签列表
 */
+ (void) startLoadTagList:(id) object
           resultSelector:(SEL) resultSelector
           returnSelector:(SEL) returnSelector{
    TagListResult* request = [[TagListResult alloc] init];
    JYJKRequestObservice* observiceModel = [[JYJKRequestObservice alloc] initWithObject:object resultSelector:resultSelector returnSelector:returnSelector];
    [[JYJKRequestManager defaultManager] createRequest:request observice:observiceModel];
}

@end
