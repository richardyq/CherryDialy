//
//  GetPhotoListRequest.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/11/1.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "JYJKHttpJsonRequest.h"

@interface GetPhotoListRequest : JYJKHttpJsonRequest

- (id) initWithStartRow:(NSInteger) startRow
                   rows:(NSInteger) rows
                 cateId:(NSInteger) cateId
                   tags:(NSString*) tags;
@end
