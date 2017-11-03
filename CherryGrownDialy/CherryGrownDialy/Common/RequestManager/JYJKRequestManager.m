//
//  JYJKRequestManager.m
//  JYJKFrameDemo
//
//  Created by yinquan on 2017/4/24.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "JYJKRequestManager.h"

static JYJKRequestManager* defaultRequestManager = nil;

@interface JYJKRequestManager ()
{
    NSMutableDictionary* requestDictionary;
    NSMutableDictionary* requestObserviceDictionary;
    
    NSOperationQueue* requestQueue;
}
@end

@implementation JYJKRequestManager

+ (JYJKRequestManager*) defaultManager
{
    if (!defaultRequestManager) {
        defaultRequestManager = [[JYJKRequestManager alloc] init];
    }

    return defaultRequestManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        requestDictionary = [NSMutableDictionary dictionary];
        
        requestQueue = [[NSOperationQueue alloc] init];
        [requestQueue setMaxConcurrentOperationCount:6];
        
        requestObserviceDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void) createRequest:(JYJKRequest*) request observice:(JYJKRequestObservice*) observice
{
    if (!request) {
        return;
    }
    
    //检查requestId
    NSString* requestId = request.requestId;
    if (!requestId || requestId.length == 0) {
        return;
    }
    
    JYJKRequest* existedRequest = [requestDictionary valueForKey:requestId];
    if (!existedRequest) {
        [requestDictionary setValue:request forKey:requestId];
    }
    
    //记录回调
    if (observice) {
        NSMutableArray* observiceList = [requestObserviceDictionary valueForKey:requestId];
        if (!observiceList) {
            observiceList = [NSMutableArray array];
            [requestObserviceDictionary setValue:observiceList forKey:requestId];
        }
        
        //observice是否存在
        __block BOOL observiceIsExisted = NO;
        [observiceList enumerateObjectsUsingBlock:^(JYJKRequestObservice* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([observice isEqualTo:obj])
            {
                observiceIsExisted = YES;
                *stop = YES;
            }
        }];
        
        if (!observiceIsExisted) {
            [observiceList addObject:observice];
        }
    }
    
    if (!existedRequest)
    {
        //加入执行队列
        [requestQueue addOperation:request];
    }
}

- (void) postRequestResult:(id) result request:(JYJKRequest*) request
{
    if (!result) {
        return;
    }
    
    if (!request) {
        return;
    }
    
    NSString* requestId = request.requestId;
    if (!requestId || requestId.length == 0) {
        return;
    }
    
    NSMutableArray* observiceList = [requestObserviceDictionary valueForKey:requestId];
    if (!observiceList) {
        return;
    }
    
    [observiceList enumerateObjectsUsingBlock:^(JYJKRequestObservice* observice, NSUInteger idx, BOOL * _Nonnull stop) {
        //调用回调方法
        if (observice.object) {
            if ([observice.object respondsToSelector:observice.resultSelector])
            {
                [observice.object performSelectorOnMainThread:observice.resultSelector withObject:result waitUntilDone:YES];
            }
        }
    }];
}

- (void) postRequestReturn:(NSInteger) errorCode errMessage:(NSString*) errorMessage request:(JYJKRequest*) request
{
    
    if (!request) {
        return;
    }
    
    NSString* requestId = request.requestId;
    if (!requestId || requestId.length == 0) {
        return;
    }
    
    NSMutableArray* observiceList = [requestObserviceDictionary valueForKey:requestId];
    if (!observiceList) {
        return;
    }
    
    JYJKRequestRetModel* retModel = [[JYJKRequestRetModel alloc] init];
    retModel.errorCode = errorCode;
    retModel.errorMessage = errorMessage;
    
    [observiceList enumerateObjectsUsingBlock:^(JYJKRequestObservice* observice, NSUInteger idx, BOOL * _Nonnull stop) {
        //调用回调方法
        if (observice.object) {
            if ([observice.object respondsToSelector:observice.returnSelector])
            {
                [observice.object performSelectorOnMainThread:observice.returnSelector withObject:retModel waitUntilDone:YES];
            }
        }
    }];
    
    [requestDictionary removeObjectForKey:requestId];
    [requestObserviceDictionary removeObjectForKey:requestId];
    
}

- (void) postUploadProgress:(NSInteger) progress totalPorgress:(NSInteger) totalProgress request:(JYJKRequest*) request{
    if (!request) {
        return;
    }
    
    NSString* requestId = request.requestId;
    if (!requestId || requestId.length == 0) {
        return;
    }
    
    NSMutableArray* observiceList = [requestObserviceDictionary valueForKey:requestId];
    if (!observiceList) {
        return;
    }
    
    JYJKRequestProgress* progressModel = [[JYJKRequestProgress alloc] init];
    progressModel.progress = progress;
    progressModel.totalProgress = totalProgress;
    
    [observiceList enumerateObjectsUsingBlock:^(JYJKRequestObservice* observice, NSUInteger idx, BOOL * _Nonnull stop) {
        if (observice.object) {
            if ([observice.object respondsToSelector:observice.uploadProgressSelector]){
                [observice.object performSelectorOnMainThread:observice.uploadProgressSelector withObject:progressModel waitUntilDone:YES];
            }
        }
    }];
}
@end
