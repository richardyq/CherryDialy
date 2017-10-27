//
//  JYJKHttpJsonRequest.m
//  JYJKFrameDemo
//
//  Created by yinquan on 2017/4/24.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "JYJKHttpJsonRequest.h"

@implementation JYJKHttpJsonRequest

- (void) startPost:(NSString*) postUrl param:(id) param
{
//    NSString* strEncode = [CommonEncrypt DESStringEncrypt:strPost WithKey:@"yuyou1208"];
//    NSDictionary* postDict = [NSDictionary dictionaryWithDictionary:param];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded ;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager.requestSerializer setValue:@"charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    __weak typeof(self) weakSelf = self;
    
    [manager POST:postUrl parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(!weakSelf)
            return;
        
        [weakSelf postSuccess:task Response:responseObject];
        return ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (!weakSelf) {
            return ;
        }
        [weakSelf postFailed:task Error:error];
        NSLog(@"%@", [error localizedDescription]);
    }];
}

- (void) parserResponeData:(NSData*) responseObject
{
    if (responseObject )
    {
        NSString* strResp = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        id resp = [strResp mj_JSONObject];
        errorCode = [self parseJson:resp];
    }
}

#pragma mark - HTTP 返回数据解包
- (RequestErrorCode) parseJson:(id) resp
{
    if (!resp || ![resp isKindOfClass:[NSDictionary class]])
    {
        errorMessage = [NSString stringWithFormat:@"接口调用失败。"];
        return Error_NetworkError;
    }
    
    NSDictionary* dicResp = (NSDictionary*) resp;
    NSNumber* numerrcode = [dicResp valueForKey:@"retCode"];
    NSString* strErrMsg = [dicResp valueForKey:@"retMessage"];
    
    NSInteger errcode = [numerrcode integerValue];
    errorCode = errcode;
    if (![self errorCodeIsValid:errcode])
    {
        //接口返回非正确值
        errorMessage = strErrMsg;
        return Error_NetworkError;
    }
    
    //解析 result
    id result = [dicResp valueForKey:@"result"];
    
    if (result)
    {
        errorCode = [self paraserResultJson:result];
        if (errorCode == Error_None && reqResult) {
            //回报结果
            [[JYJKRequestManager defaultManager] postRequestResult:reqResult request:self];
        }
    }
    return Error_None;
}

- (BOOL) errorCodeIsValid:(NSInteger) errCode
{
    return errCode == 0;
}

- (RequestErrorCode) paraserResultJson:(id) result
{
    reqResult = result;
    return Error_None;
}
@end
