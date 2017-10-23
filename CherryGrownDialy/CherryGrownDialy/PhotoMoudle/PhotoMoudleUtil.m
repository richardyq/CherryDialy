//
//  PhotoMoudleUtil.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/12.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "PhotoMoudleUtil.h"
#import "AppendPhotoRequest.h"
#import "ResentlyPhotosRequest.h"

@implementation PhotoMoudleUtil

+ (void) startUploadPhoto:(NSDictionary*) postParams
                imageData:(NSData*) imageData
          observiceObject:(id) object
           resultSelector:(SEL) resultSelector
           returnSelector:(SEL) returnSelector
{
    AppendPhotoRequest* request = [[AppendPhotoRequest alloc] initWithParams:postParams uploadData:imageData];
    JYJKRequestObservice* observiceModel = [[JYJKRequestObservice alloc] initWithObject:object resultSelector:resultSelector returnSelector:returnSelector];
    [[JYJKRequestManager defaultManager] createRequest:request observice:observiceModel];
}

+ (void) startLoadResentlyPhotos:(id) object
                  resultSelector:(SEL) resultSelector
                  returnSelector:(SEL) returnSelector
{
    ResentlyPhotosRequest* request = [[ResentlyPhotosRequest alloc] init];
    JYJKRequestObservice* observiceModel = [[JYJKRequestObservice alloc] initWithObject:object resultSelector:resultSelector returnSelector:returnSelector];
    [[JYJKRequestManager defaultManager] createRequest:request observice:observiceModel];
}


@end
