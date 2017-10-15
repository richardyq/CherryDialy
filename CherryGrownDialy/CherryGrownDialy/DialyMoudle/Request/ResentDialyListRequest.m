//
//  ResentDialyListRequest.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/14.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "ResentDialyListRequest.h"

@implementation ResentDialyListRequest

@synthesize reqeustParam = _reqeustParam;

- (NSString*) postUrl
{
    NSString* postUrl = [HttpUrlHelper postDialyServiceUrl:@"resentDialys"];
    return postUrl;
}

- (RequestErrorCode) paraserResultJson:(id) result
{
    if (![result isKindOfClass:[NSArray class]]) {
        errorMessage = @"读取服务器数据错误。请联系管理员。";
        return Error_NetworkError;
    }
    NSMutableArray<DialyModel*>* dialyModels = [NSMutableArray<DialyModel*> array];
    NSArray<NSDictionary*>* dictList = (NSArray<NSDictionary*>*) result;
    
    [dictList enumerateObjectsUsingBlock:^(NSDictionary * dict, NSUInteger idx, BOOL * _Nonnull stop) {
        DialyModel* model = [DialyModel mj_objectWithKeyValues:dict];
        [dialyModels addObject:model];
    }];
    
    reqResult = dialyModels;
    return Error_None;
}

@end
