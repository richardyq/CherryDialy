//
//  DialyMoudleUtil.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/8.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DialyModel.h"
#import "DialyModelList.h"


#import "DialyViewControllerManager.h"

extern NSString * const kDialyAppendNoticationName;

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

/*
 getResentDialyList
 获取最近的日记
 */
+ (void) getResentDialyList:(id) object
             resultSelector:(SEL) resultSelector
             returnSelector:(SEL) returnSelector;

/*
 获取日记列表
 */
+ (void) startGetDialyList:(NSInteger) startRow
                      rows:(NSInteger) rows
                    cateId:(NSInteger) cateId
                      tags:(NSString*) tags
           observiceObject:(id) object
            resultSelector:(SEL) resultSelector
            returnSelector:(SEL) returnSelector;

/*
 startGetDialyDetail
 获取日记详情
 dialyId 日记Id
 */
+ (void) startGetDialyDetail:(NSInteger) dialyId
             observiceObject:(id) object
              resultSelector:(SEL) resultSelector
              returnSelector:(SEL) returnSelector;

/*
 postAppendedNotification
 日记上传成功后发送广播
 */
+ (void) postAppendedNotification;

@end
