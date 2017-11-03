//
//  AppendPhotoListViewController.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/20.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppendPhotoImageModel.h"

@interface AppendPhotoListViewController : UIViewController

@property (nonatomic, strong) NSMutableArray<AppendPhotoImageModel*>* photoModels;

//@property (nonatomic, strong) NSMutableArray* imageList;
//@property (nonatomic, strong) NSMutableArray* thumbList;

- (void) startUplodaPhotos:(CategoryModel*) categoryModel
                      tags:(NSArray<TagModel*>*) tagModels;

@end
