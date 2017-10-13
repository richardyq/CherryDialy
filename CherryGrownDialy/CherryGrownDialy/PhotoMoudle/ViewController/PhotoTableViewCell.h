//
//  PhotoTableViewCell.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/12.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoControlSelectDelegate.h"


@interface PhotoInfoCell : UIControl

@property (nonatomic, strong) UIImageView* photoImageView;

- (void) layoutElements;
@end

@interface PhotoTableViewCell : UITableViewCell

@property (nonatomic, weak) id<PhotoControlSelectDelegate> selectDelegate;
@property (nonatomic, assign) NSInteger cellRow;

- (void) setPhotoInfos:(NSArray<PhotoInfoModel *>*) photoInfos;


@end
