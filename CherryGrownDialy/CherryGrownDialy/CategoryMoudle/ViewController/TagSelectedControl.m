//
//  TagSelectedControl.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/8.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "TagSelectedControl.h"

@interface TagSelectedControl ()

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* tagsLable;
@property (nonatomic, strong) UIImageView* arrowImageView;

@end

@implementation TagSelectedControl

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
    
    [self.tagsLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
        make.centerY.equalTo(self);
        make.right.lessThanOrEqualTo(self.arrowImageView.mas_left).offset(-8);
    }];
}

- (void) setSelectTagModels:(NSArray*) tagModels{
    __block NSString* tags = @"";
    [tagModels enumerateObjectsUsingBlock:^(TagModel* tagModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if (tags.length > 0) {
            tags = [tags stringByAppendingString:@","];
        }
        tags = [tags stringByAppendingString:tagModel.name];
    }];
    [self.tagsLable setText:tags];
}
#pragma mark - settingAndGetting

- (UILabel*) titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        
        [_titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_titleLabel setTextColor:[UIColor commonTextColor]];
        [_titleLabel setText:@"标签:"];
    }
    return _titleLabel;
}

- (UILabel*) tagsLable
{
    if (!_tagsLable) {
        _tagsLable = [[UILabel alloc] init];
        [self addSubview:_tagsLable];
        
        [_tagsLable setFont:[UIFont systemFontOfSize:15]];
        [_tagsLable setTextColor:[UIColor commonTextColor]];
        [_tagsLable setText:@""];
    }
    return _tagsLable;
}

- (UIImageView*) arrowImageView{
    if(!_arrowImageView){
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_arrow"]];
        [self addSubview:_arrowImageView];
    }
    return _arrowImageView;
}

@end
