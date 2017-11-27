//
//  AlbumViewControllerManager.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/11/3.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "AlbumViewControllerManager.h"

#import "AppendAlbumViewController.h"

@implementation AlbumViewControllerManager

+ (void) entryAppendAlbumPage{
    AppendAlbumViewController* appendViewController = [[AppendAlbumViewController alloc] init];
    [[ViewControllerManager defaultManager] entryPageViewController:appendViewController];
}
@end
