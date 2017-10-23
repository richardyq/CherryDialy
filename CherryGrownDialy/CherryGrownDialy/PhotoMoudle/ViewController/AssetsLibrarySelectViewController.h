//
//  AssetsLibrarySelectViewController.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/20.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "CDBaseViewController.h"
#import "AppendPhotoImageModel.h"

typedef void(^SelectUploadPhotosHandle)(NSArray<AppendPhotoImageModel*> * models);

@interface AssetsLibrarySelectViewController : CDBaseViewController

+ (void) showWithLimitCount:(NSInteger) limitCount
                      hanle:(SelectUploadPhotosHandle) handle;

- (id) initWithLimitCount:(NSInteger) limitCount;
@end
