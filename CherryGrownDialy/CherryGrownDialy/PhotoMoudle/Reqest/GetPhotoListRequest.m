//
//  GetPhotoListRequest.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/11/1.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "GetPhotoListRequest.h"

@implementation GetPhotoListRequest

@synthesize reqeustParam = _reqeustParam;

- (id) initWithStartRow:(NSInteger) startRow
                   rows:(NSInteger) rows
                 cateId:(NSInteger) cateId
                   tags:(NSString*) tags
{
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
    NSString* postUrl = [HttpUrlHelper postPhotoServiceUrl:@"getPhotoList"];
    return postUrl;
}

- (RequestErrorCode) paraserResultJson:(id) result
{
    if (![result isKindOfClass:[NSDictionary class]]) {
        errorMessage = @"读取服务器数据错误。请联系管理员。";
        return Error_NetworkError;
    }
    
    NSDictionary* respDictionary = (NSDictionary*) result;
    PhotoModelList* photoList = [PhotoModelList mj_objectWithKeyValues:respDictionary];
    NSArray<PhotoInfoModel*>* photoModels = photoList.list;
    [photoModels enumerateObjectsUsingBlock:^(PhotoInfoModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString* imageUrl = model.imageUrl;
        NSString* thumbUrl = model.thumbUrl;
        imageUrl = [NSString stringWithFormat:@"%@%@", kBasePostHost, imageUrl];
        thumbUrl = [NSString stringWithFormat:@"%@%@", kBasePostHost, thumbUrl];
        [model setImageUrl:imageUrl];
        [model setThumbUrl:thumbUrl];
    }];
    
    reqResult = photoList;
    return Error_None;
}
@end
