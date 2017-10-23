//
//  JYJKHttpUploadRequest.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/20.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "JYJKHttpRequest.h"

@interface JYJKHttpUploadRequest : JYJKHttpRequest

- (id) initWithParams:(NSDictionary*) params
           uploadData:(NSData*) uploadData;
@end
