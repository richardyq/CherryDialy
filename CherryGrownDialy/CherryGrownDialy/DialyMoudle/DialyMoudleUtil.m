//
//  DialyMoudleUtil.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/8.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "DialyMoudleUtil.h"
#import "AppendDialyRequest.h"
#import "ResentDialyListRequest.h"
#import "GetDialyListRequest.h"
#import "GetDialyDetailRequest.h"

NSString * const kDialyAppendNoticationName = @"DialyAppendNoticationName";

@implementation DialyMoudleUtil

+ (void) startAppendDialy:(NSString*) content
                   cateId:(NSInteger) cateId
                     tags:(NSString*) tags
          observiceObject:(id) object
           resultSelector:(SEL) resultSelector
           returnSelector:(SEL) returnSelector
{
    AppendDialyRequest* request = [[AppendDialyRequest alloc] initWithComment:content cateId:cateId tags:tags];
    
    JYJKRequestObservice* observiceModel = [[JYJKRequestObservice alloc] initWithObject:object resultSelector:resultSelector returnSelector:returnSelector];
    [[JYJKRequestManager defaultManager] createRequest:request observice:observiceModel];
}

+ (void) getResentDialyList:(id) object
             resultSelector:(SEL) resultSelector
             returnSelector:(SEL) returnSelector{
    ResentDialyListRequest* request = [[ResentDialyListRequest alloc] init];
    
    JYJKRequestObservice* observiceModel = [[JYJKRequestObservice alloc] initWithObject:object resultSelector:resultSelector returnSelector:returnSelector];
    [[JYJKRequestManager defaultManager] createRequest:request observice:observiceModel];
}

+ (void) startGetDialyList:(NSInteger) startRow
                      rows:(NSInteger) rows
                    cateId:(NSInteger) cateId
                      tags:(NSString*) tags
          observiceObject:(id) object
           resultSelector:(SEL) resultSelector
            returnSelector:(SEL) returnSelector
{
    GetDialyListRequest* request = [[GetDialyListRequest alloc] initWithStartRow:startRow rows:rows cateId:cateId tags:tags];
    
    JYJKRequestObservice* observiceModel = [[JYJKRequestObservice alloc] initWithObject:object resultSelector:resultSelector returnSelector:returnSelector];
    [[JYJKRequestManager defaultManager] createRequest:request observice:observiceModel];
}

+ (void) startGetDialyDetail:(NSInteger) dialyId
             observiceObject:(id) object
              resultSelector:(SEL) resultSelector
              returnSelector:(SEL) returnSelector{
    GetDialyDetailRequest* request = [[GetDialyDetailRequest alloc] initWithDialyId:dialyId];
    
    JYJKRequestObservice* observiceModel = [[JYJKRequestObservice alloc] initWithObject:object resultSelector:resultSelector returnSelector:returnSelector];
    [[JYJKRequestManager defaultManager] createRequest:request observice:observiceModel];
}

+ (void) postAppendedNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:kDialyAppendNoticationName object:nil];
}


@end

