//
//  ResentlyPhotosRequest.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/22.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "ResentlyPhotosRequest.h"

@implementation ResentlyPhotosRequest

- (NSString*) postUrl
{
    NSString* postUrl = [HttpUrlHelper postPhotoServiceUrl:@"resentlyPhotos"];
    return postUrl;
}

- (RequestErrorCode) paraserResultJson:(id) result
{
    if (![result isKindOfClass:[NSArray class]]) {
        errorMessage = @"读取服务器数据错误。请联系管理员。";
        return Error_NetworkError;
    }
    NSMutableArray<PhotoInfoModel*>* photoModels = [NSMutableArray<PhotoInfoModel*> array];
    NSArray<NSDictionary*>* dictList = (NSArray<NSDictionary*>*) result;
    
    [dictList enumerateObjectsUsingBlock:^(NSDictionary * dict, NSUInteger idx, BOOL * _Nonnull stop) {
        PhotoInfoModel* model = [PhotoInfoModel mj_objectWithKeyValues:dict];
        [photoModels addObject:model];
    }];
    
    reqResult = photoModels;
    return Error_None;
}


@end
