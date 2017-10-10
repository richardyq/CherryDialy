//
//  JYJKRequest.m
//  JYJKFrameDemo
//
//  Created by yinquan on 2017/4/24.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "JYJKRequest.h"

@interface JYJKRequest ()
{
    NSCondition* cdiLock;
}
@end

@implementation JYJKRequest

@synthesize requestId = _requestId;


- (instancetype)init
{
    self = [super init];
    if (self) {
        cdiLock = [[NSCondition alloc ]init];
    }
    return self;
}

- (void) lock
{
    [cdiLock lock];
    [cdiLock wait];
    [cdiLock unlock];
}

- (void) unlock
{
    [cdiLock lock];
    [cdiLock signal];
    [cdiLock unlock];
}

#pragma mark - settingAndGetting
- (NSString*) requestId
{
    if (!_requestId) {
        NSString* classname = NSStringFromClass([self class]);
        NSMutableDictionary* requestIdDictionary = [NSMutableDictionary dictionary];
        [requestIdDictionary setValue:classname forKey:@"classname"];
        if (self.reqeustParam)
        {
            [requestIdDictionary setValue:self.reqeustParam forKey:@"param"];
        }
        
        _requestId = [requestIdDictionary mj_JSONString];
    }
    
    return _requestId;
}


- (void) main
{
    
    errorCode = [self runRequest];
    //回报结果
    [[JYJKRequestManager defaultManager] postRequestReturn:errorCode errMessage:errorMessage request:self];
}

- (NSInteger) runRequest
{
    //TODO: Do somethine
    
    
    return Error_None;
}
@end
