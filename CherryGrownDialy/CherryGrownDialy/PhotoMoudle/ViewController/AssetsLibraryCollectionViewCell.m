//
//  AssetsLibraryCollectionViewCell.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/20.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "AssetsLibraryCollectionViewCell.h"

@interface AssetsLibraryCollectionViewCell ()
{
    
}

@property (nonatomic, strong) UIImageView* photoImageView;
@property (nonatomic, strong) UIImageView* selectImageView;

@end

@implementation AssetsLibraryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutElements];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self layoutElements];
    }
    return self;
}

- (void) layoutElements{
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(2, 2, 2, 2));
    }];
    
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.bottom.equalTo(self.contentView).offset(-5);
    }];
}

- (void) setIsSelected:(BOOL) selected{
    if (selected) {
        [self.selectImageView setImage:[UIImage imageNamed:@"photo_checked"]];
    }
    else
    {
        [self.selectImageView setImage:[UIImage imageNamed:@"photo_unchecked"]];
    }
}

#pragma mark - settingAndGetting

- (UIImageView*) photoImageView
{
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_default"]];
        [self.contentView addSubview:_photoImageView];
    
    }
    return _photoImageView;
}

- (UIImageView*) selectImageView
{
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo_unchecked"]];
        [self.contentView addSubview:_selectImageView];
        
    }
    return _selectImageView;
}

- (void) setThumbImage:(UIImage *)thumbImage
{
    _thumbImage = thumbImage;
    [self.photoImageView setImage:thumbImage];
}
@end
