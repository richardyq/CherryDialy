//
//  PhotoMoudleUtil.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/12.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoInfoModel.h"

#import "PhotoViewControllerManager.h"

@interface PhotoMoudleUtil : NSObject

+ (void) startUploadPhoto:(NSDictionary*) postParams
                imageData:(NSData*) imageData
          observiceObject:(id) object
           resultSelector:(SEL) resultSelector
           returnSelector:(SEL) returnSelector;

+ (void) startLoadResentlyPhotos:(id) object
                  resultSelector:(SEL) resultSelector
                  returnSelector:(SEL) returnSelector;
@end
