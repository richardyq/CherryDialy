//
//  AppendDialyRequest.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/8.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "JYJKHttpJsonRequest.h"

@interface AppendDialyRequest : JYJKHttpJsonRequest

- (id) initWithComment:(NSString*) content
                cateId:(NSInteger) cateId
                  tags:(NSString*) tags;

@end
