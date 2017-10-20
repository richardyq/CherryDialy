//
//  AppendPhotoControl.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/20.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "AppendPhotoControl.h"

@interface AppendPhotoControl ()

@property (nonatomic, strong) UIImageView* appendImageView;
@property (nonatomic, strong) UIImageView* thumbImageView;

@end

@implementation AppendPhotoControl

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

- (void) setThumbImage:(UIImage *)thumbImage{
    [self.thumbImageView setImage:thumbImage];
    
    [self.appendImageView setHidden:YES];
    [self.thumbImageView setHidden:NO];
}

@end
