//
//  PhotoTableViewCell.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/12.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoInfoCell : UIControl

@property (nonatomic, strong) UIImageView* photoImageView;

- (void) layoutElements;
@end

@interface PhotoTableViewCell : UITableViewCell

- (void) setPhotoInfos:(NSArray<PhotoInfoModel *>*) photoInfos;

@end
