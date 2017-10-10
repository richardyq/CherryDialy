//
//  CategorySelectedControl.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/8.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "CategorySelectedControl.h"

@interface CategorySelectedControl()

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UIImageView* arrowImageView;

@end

@implementation CategorySelectedControl

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self showBottomLine];
        [self layoutElements];
    }
    return self;
}

- (void) layoutElements{
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-12.5);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(8, 15));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12.5);
        make.centerY.equalTo(self);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
        make.centerY.equalTo(self);
        make.right.lessThanOrEqualTo(self.arrowImageView.mas_left).offset(-8);
    }];
}

- (void) setCategoryModel:(CategoryModel*) categoryModel{
    if (!categoryModel)
    {
        [self.nameLabel setText:@"全部"];
    }
    [self.nameLabel setText:categoryModel.name];
}

#pragma mark - settingAndGetting

- (UILabel*) titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        
        [_titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_titleLabel setTextColor:[UIColor commonTextColor]];
        [_titleLabel setText:@"分类:"];
    }
    return _titleLabel;
}


- (UILabel*) nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        [self addSubview:_nameLabel];
        
        [_nameLabel setFont:[UIFont systemFontOfSize:15]];
        [_nameLabel setTextColor:[UIColor commonTextColor]];
        [_nameLabel setText:@"全部"];
    }
    return _nameLabel;
}

- (UIImageView*) arrowImageView{
    if(!_arrowImageView){
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_arrow"]];
        [self addSubview:_arrowImageView];
    }
    return _arrowImageView;
}
@end
