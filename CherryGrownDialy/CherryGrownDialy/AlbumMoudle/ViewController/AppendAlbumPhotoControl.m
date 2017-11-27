//
//  AppendAlbumPhotoControl.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/11/20.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "AppendAlbumPhotoControl.h"

@interface AppendAlbumPhotoControl ()

@property (nonatomic, strong) UIImageView* appendImageView;
@property (nonatomic, strong) UIImageView* thumbImageView;

@end

@implementation AppendAlbumPhotoControl

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.borderColor = [UIColor commonControlBorderColor].CGColor;
        self.layer.borderWidth = 1;
        
        [self layoutElements];
        
    }
    return self;
}

- (void) layoutElements{
    [self.appendImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    [self.thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void) setPhotoInfoModel:(PhotoInfoModel*) model
{
    [self.appendImageView setHidden:YES];
    [self.thumbImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbUrl] placeholderImage:[UIImage imageNamed:@"img_default"]];
}


#pragma mark - settingAndGetting
- (UIImageView*) appendImageView{
    if (!_appendImageView) {
        _appendImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"appendPhotoButton"]];
        [self addSubview:_appendImageView];
        [_appendImageView setHidden:NO];
    }
    return _appendImageView;
}

- (UIImageView*) thumbImageView{
    if (!_thumbImageView) {
        _thumbImageView = [[UIImageView alloc] init];
        [self addSubview:_thumbImageView];
        [_thumbImageView setHidden:YES];
    }
    return _thumbImageView;
}

@end
