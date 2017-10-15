//
//  GetDialyListRequest.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/14.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "GetDialyListRequest.h"

@implementation GetDialyListRequest
@synthesize reqeustParam = _reqeustParam;

- (id) initWithStartRow:(NSInteger) startRow
                   rows:(NSInteger) rows
                 cateId:(NSInteger) cateId
                   tags:(NSString*) tags{
    self = [super init];
    if (self) {
        _reqeustParam = [NSMutableDictionary dictionary];
        if (tags && tags.length > 0) {
            [_reqeustParam setValue:tags forKey:@"tags"];
        }
        
        if (cateId > 0)
        {
            [_reqeustParam setValue:@(cateId) forKey:@"cateId"];
        }
        
        if (startRow > 0)
        {
            [_reqeustParam setValue:@(startRow) forKey:@"startRow"];
        }
        if (rows > 0)
        {
            [_reqeustParam setValue:@(rows) forKey:@"rows"];
        }
    }
    return self;
}

- (NSString*) postUrl
{
    NSString* postUrl = [HttpUrlHelper postDialyServiceUrl:@"getDialyList"];
    return postUrl;
}

- (RequestErrorCode) paraserResultJson:(id) result
{
    if (![result isKindOfClass:[NSDictionary class]]) {
        errorMessage = @"读取服务器数据错误。请联系管理员。";
        return Error_NetworkError;
    }
    
    NSDictionary* respDictionary = (NSDictionary*) result;
    DialyModelList* dialyList = [DialyModelList mj_objectWithKeyValues:respDictionary];
    

    reqResult = dialyList;
    return Error_None;
}

@end
