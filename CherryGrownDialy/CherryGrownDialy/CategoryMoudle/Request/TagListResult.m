//
//  TagListResult.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/7.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "TagListResult.h"

@implementation TagListResult

- (NSString*) postUrl
{
    NSString* postUrl = [HttpUrlHelper postCategoryServiceUrl:@"getTagList"];
    return postUrl;
}

- (RequestErrorCode) paraserResultJson:(id) result
{
    if (![result isKindOfClass:[NSArray class]]) {
        errorMessage = @"读取服务器数据错误。请联系管理员。";
        return Error_NetworkError;
    }
    
    NSArray* respArray = (NSArray*) result;
    NSMutableArray* cateList = [NSMutableArray array];
    
    [respArray enumerateObjectsUsingBlock:^(NSDictionary* cateDict, NSUInteger idx, BOOL * _Nonnull stop) {
        TagModel* model = [TagModel mj_objectWithKeyValues:cateDict];
        [cateList addObject:model];
        
    }];
    
    reqResult = cateList;
    
    return Error_None;
}
@end
