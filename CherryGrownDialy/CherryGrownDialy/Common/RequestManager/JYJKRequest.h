//
//  JYJKRequest.h
//  JYJKFrameDemo
//
//  Created by yinquan on 2017/4/24.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYJKRequestRetModel.h"



@interface JYJKRequest : NSOperation
{
    NSInteger errorCode;
    NSString* errorMessage;
    
    id reqResult;
}

@property (nonatomic, readonly) NSString* requestId;            //请求ID
@property (nonatomic, readonly) NSMutableDictionary* reqeustParam;     //请求参数

- (void) lock;
- (void) unlock;

@end
