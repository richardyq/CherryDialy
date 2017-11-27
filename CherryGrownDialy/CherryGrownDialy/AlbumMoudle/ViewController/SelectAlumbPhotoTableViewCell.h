//
//  SelectAlumbPhotoTableViewCell.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/11/20.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoControlSelectDelegate.h"

@interface SelectAlumbPhotoInfoCell : UIControl

@property (nonatomic, strong) UIImageView* photoImageView;

- (void) layoutElements;

- (void) setSelected:(BOOL)selected;
@end


@interface SelectAlumbPhotoTableViewCell : UITableViewCell

@property (nonatomic, weak) id<PhotoControlSelectDelegate> selectDelegate;
@property (nonatomic, assign) NSInteger cellRow;

- (void) setPhotoInfos:(NSArray<PhotoInfoModel *>*) photoInfos;

@end
