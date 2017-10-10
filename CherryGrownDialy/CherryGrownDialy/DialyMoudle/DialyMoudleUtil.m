//
//  DialyMoudleUtil.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/8.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "DialyMoudleUtil.h"
#import "AppendDialyRequest.h"

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
@end
