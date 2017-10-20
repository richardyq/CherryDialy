//
//  AssetsLibraryCollectionViewCell.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/20.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssetsLibraryCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImage* thumbImage;

- (void) setIsSelected:(BOOL) selected;
@end
