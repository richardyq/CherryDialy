//
//  PhotoViewControllerManager.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/12.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResentlyPhotoListTableViewController.h"

@interface PhotoViewControllerManager : NSObject

+ (void) entryPhotoDetailPage:(NSArray<PhotoInfoModel*> *) photos currentIndex:(NSInteger) index;

/*
 entryAppendPhotoPage
 添加照片界面
 */
+ (void) entryAppendPhotoPage;
@end
