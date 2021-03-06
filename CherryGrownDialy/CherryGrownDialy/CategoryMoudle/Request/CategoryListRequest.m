//
//  CategoryListRequest.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/7.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "CategoryListRequest.h"

@implementation CategoryListRequest

- (NSString*) postUrl
{
    NSString* postUrl = [HttpUrlHelper postCategoryServiceUrl:@"getCategoryList"];
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
        CategoryModel* model = [CategoryModel mj_objectWithKeyValues:cateDict];
        [cateList addObject:model];
        
    }];
    
    reqResult = cateList;
    
    return Error_None;
}
@end
