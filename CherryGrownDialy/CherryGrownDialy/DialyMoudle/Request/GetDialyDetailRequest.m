//
//  GetDialyDetailRequest.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/15.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "GetDialyDetailRequest.h"

@implementation GetDialyDetailRequest

@synthesize reqeustParam = _reqeustParam;

- (id) initWithDialyId:(NSInteger) id{
    self = [super init];
    if(self){
        _reqeustParam = [NSMutableDictionary dictionary];
        [_reqeustParam setValue:@(id) forKey:@"id"];
    }
    return self;
}

- (NSString*) postUrl
{
    NSString* postUrl = [HttpUrlHelper postDialyServiceUrl:@"getDialyDetail"];
    return postUrl;
}

- (RequestErrorCode) paraserResultJson:(id) result
{
    if (![result isKindOfClass:[NSDictionary class]]) {
        errorMessage = @"读取服务器数据错误。请联系管理员。";
        return Error_NetworkError;
    }
    
    NSDictionary* respDictionary = (NSDictionary*) result;
    DialyModel* dialyModel = [DialyModel mj_objectWithKeyValues:respDictionary];

    reqResult = dialyModel;
    return Error_None;
}
@end
