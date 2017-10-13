//
//  PhotoViewControllerManager.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/12.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "PhotoViewControllerManager.h"
#import "PhotoDetailViewController.h"

@implementation PhotoViewControllerManager

+ (void) entryPhotoDetailPage:(NSArray<PhotoInfoModel*> *) photos currentIndex:(NSInteger) index{
    PhotoDetailViewController* detailViewController = [[PhotoDetailViewController alloc] initWithPhotos:photos currentIndex:index];
    [[ViewControllerManager defaultManager] entryPageViewController:detailViewController];
}
@end
