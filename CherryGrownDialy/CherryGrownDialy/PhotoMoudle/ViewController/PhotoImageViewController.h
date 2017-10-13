//
//  PhotoImageViewController.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/12.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "CDBaseViewController.h"

@interface PhotoImageViewController : CDBaseViewController

@property (nonatomic, strong) PhotoInfoModel* photoModel;

- (id) initWithPhotoModel:(PhotoInfoModel*) phototModel;
@end
