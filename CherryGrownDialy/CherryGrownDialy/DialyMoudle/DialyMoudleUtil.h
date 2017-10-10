//
//  DialyMoudleUtil.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/8.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DialyModel.h"

#import "DialyViewControllerManager.h"

@interface DialyMoudleUtil : NSObject

/*
 startAppendDialy
 添加日记
 */
+ (void) startAppendDialy:(NSString*) content
                   cateId:(NSInteger) cateId
                     tags:(NSString*) tags
          observiceObject:(id) object
           resultSelector:(SEL) resultSelector
           returnSelector:(SEL) returnSelector;

@end
