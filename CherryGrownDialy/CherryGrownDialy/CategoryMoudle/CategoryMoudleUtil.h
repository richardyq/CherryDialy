//
//  CategoryMoudleUtil.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/7.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CategoryModel.h"
#import "TagModel.h"

#import "CategorySelectedControl.h"
#import "CategorySelectViewController.h"
#import "TagSelectedControl.h"
#import "TagsSelectViewController.h"

@interface CategoryMoudleUtil : NSObject

/*
 startLoadCategoryList
 获取分类列表
 */
+ (void) startLoadCategoryList:(id) object
                resultSelector:(SEL) resultSelector
                returnSelector:(SEL) returnSelector;

/*
 startLoadCategoryList
 获取标签列表
 */
+ (void) startLoadTagList:(id) object
            resultSelector:(SEL) resultSelector
            returnSelector:(SEL) returnSelector;
@end
