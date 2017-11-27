//
//  SelectAlbumPhotosViewController.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/11/20.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "CDBaseViewController.h"

typedef void(^AppendAlbumSelectPhotosHandle)(NSArray<PhotoInfoModel*>* selectPhotoModels);

@interface SelectAlbumPhotosViewController : CDBaseViewController

+ (void) showWithSelectedPhotos:(NSArray<PhotoInfoModel*>*) photoModels
                   selectHandle:(AppendAlbumSelectPhotosHandle) handle;

@end
