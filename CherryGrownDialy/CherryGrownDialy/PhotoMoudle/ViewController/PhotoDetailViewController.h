//
//  PhotoDetailViewController.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/12.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "CDBaseViewController.h"

@interface PhotoDetailViewController : CDBaseViewController

- (id) initWithPhotos:(NSArray<PhotoInfoModel*>*) photos
         currentIndex:(NSInteger) currentIndex;
@end
