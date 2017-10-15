//
//  GetDialyDetailRequest.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/15.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "JYJKHttpJsonRequest.h"

@interface GetDialyDetailRequest : JYJKHttpJsonRequest

- (id) initWithDialyId:(NSInteger) id;
@end
