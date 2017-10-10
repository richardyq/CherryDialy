//
//  JYJKHttpRequest.h
//  JYJKFrameDemo
//
//  Created by yinquan on 2017/4/24.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "JYJKRequest.h"


@interface JYJKHttpRequest : JYJKRequest

- (void) postSuccess:(NSURLSessionDataTask *) task Response:(id) responseObject;

- (void) postFailed:(NSURLSessionDataTask *) task Error:(NSError*) error;

@end
