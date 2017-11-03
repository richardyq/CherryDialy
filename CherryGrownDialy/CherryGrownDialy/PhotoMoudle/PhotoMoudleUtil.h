//
//  PhotoMoudleUtil.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/12.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoInfoModel.h"
#import "PhotoModelList.h"

#import "PhotoViewControllerManager.h"

@interface PhotoMoudleUtil : NSObject

+ (void) startUploadPhoto:(NSDictionary*) postParams
                imageData:(NSData*) imageData
          observiceObject:(id) object
           resultSelector:(SEL) resultSelector
           returnSelector:(SEL) returnSelector
   uploadProgressSelector:(SEL) uploadProgressSelector;

+ (void) startLoadResentlyPhotos:(id) object
                  resultSelector:(SEL) resultSelector
                  returnSelector:(SEL) returnSelector;

/*
 获取照片列表
 */
+ (void) startGetPhotoList:(NSInteger) startRow
                      rows:(NSInteger) rows
                    cateId:(NSInteger) cateId
                      tags:(NSString*) tags
           observiceObject:(id) object
            resultSelector:(SEL) resultSelector
            returnSelector:(SEL) returnSelector;

+ (UIImage*) thumbImageFormImage:(UIImage*) image;

+ (UIImage*) screenFitedImageFormImage:(UIImage*) image;
@end
