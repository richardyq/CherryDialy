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
#import "GetPhotoListRequest.h"

@implementation PhotoMoudleUtil

+ (void) startUploadPhoto:(NSDictionary*) postParams
                imageData:(NSData*) imageData
          observiceObject:(id) object
           resultSelector:(SEL) resultSelector
           returnSelector:(SEL) returnSelector
   uploadProgressSelector:(SEL) uploadProgressSelector
{
    AppendPhotoRequest* request = [[AppendPhotoRequest alloc] initWithParams:postParams uploadData:imageData];
    JYJKRequestObservice* observiceModel = [[JYJKRequestObservice alloc] initWithObject:object resultSelector:resultSelector returnSelector:returnSelector uploadProgressSelector:uploadProgressSelector];
    
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

+ (void) startGetPhotoList:(NSInteger) startRow
                      rows:(NSInteger) rows
                    cateId:(NSInteger) cateId
                      tags:(NSString*) tags
           observiceObject:(id) object
            resultSelector:(SEL) resultSelector
            returnSelector:(SEL) returnSelector
{
    GetPhotoListRequest* request = [[GetPhotoListRequest alloc] initWithStartRow:startRow rows:rows cateId:cateId tags:tags];
    
    JYJKRequestObservice* observiceModel = [[JYJKRequestObservice alloc] initWithObject:object resultSelector:resultSelector returnSelector:returnSelector];
    [[JYJKRequestManager defaultManager] createRequest:request observice:observiceModel];
}

+ (UIImage*) thumbImageFormImage:(UIImage*) image
{
    UIImage* thumbImage = nil;
    
    CGFloat thumbWidth = image.size.width;
    CGFloat thumbHeight = image.size.height;
    
    CGFloat maxLength = thumbWidth;
    CGFloat imageScale = thumbHeight / 320.0;
    if (thumbWidth > thumbHeight) {
        maxLength = thumbHeight;
        CGRect rect = CGRectMake((thumbWidth - thumbHeight)/2, 0, maxLength, maxLength);
        thumbImage = [image getSubImage:rect];
    }
    else
    {
        
        imageScale = thumbWidth / 320;
        CGRect rect = CGRectMake(0, (thumbHeight - thumbWidth)/2, maxLength, maxLength);
        thumbImage = [image getSubImage:rect];
    }
    if (imageScale < 1.0) {
        [thumbImage scaleImageToScale:imageScale];
    }
    
    return thumbImage;
}

+ (UIImage*) screenFitedImageFormImage:(UIImage*) image
{
    UIImage* fitedImage = image;
    
    CGFloat imageScale = ScreenWidth * [UIScreen mainScreen].scale / image.size.width;
    if (imageScale < 1.0) {
        fitedImage = [image scaleImageToScale:imageScale];
    }
    
    return fitedImage;
}
@end
