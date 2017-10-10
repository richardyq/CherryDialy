//
//  DialyInfoTableViewCell.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/10.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "DialyInfoTableViewCell.h"

@interface DialyInfoTableViewCell ()
{
    
}

@property (nonatomic, strong) UIView* dialyView;
@property (nonatomic, strong) UILabel* createTimeLabel;
@property (nonatomic, strong) UILabel* createUserLabel;

@property (nonatomic, strong) UILabel* contentLabel;

@end

@implementation DialyInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView setBackgroundColor:[UIColor commonBackgroundColor]];
        [self layoutElements];
    }
    return self;
}

- (void) layoutElements{
    [self.dialyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(10, 12.5, 10, 12.5));
    }];
    
    [self.createUserLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dialyView).offset(10);
        make.top.equalTo(self.dialyView).offset(7.5);
    }];
    
    [self.createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.dialyView).offset(-10);
        make.top.equalTo(self.createUserLabel);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.createUserLabel);
        make.right.equalTo(self.createTimeLabel);
        make.top.equalTo(self.createTimeLabel.mas_bottom).offset(10);
    }];
}

- (void) setDialyModel:(DialyModel*) dialyModel{
    [self.contentLabel setText:dialyModel.content];
    [self.createUserLabel setText:dialyModel.createTime];
    [self.createTimeLabel setText:dialyModel.createUserName];
}

#pragma mark settingAndGetting

- (UIView*) dialyView
{
    if (!_dialyView) {
        _dialyView = [[UIView alloc] init];
        [_dialyView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:_dialyView];
        
        _dialyView.layer.borderWidth = 0.5;
        _dialyView.layer.borderColor = [UIColor commonControlBorderColor].CGColor;
        _dialyView.layer.cornerRadius = 5;
        _dialyView.layer.masksToBounds = YES;
    }
    
    return _dialyView;
}

- (UILabel*) createUserLabel{
    if(!_createUserLabel){
        _createUserLabel = [[UILabel alloc] init];
        [self.dialyView addSubview:_createUserLabel];
        [_createUserLabel setFont:[UIFont systemFontOfSize:11]];
        [_createUserLabel setTextColor:[UIColor commonGrayTextColor]];
    }
    return _createUserLabel;
}

- (UILabel*) createTimeLabel{
    if (!_createTimeLabel) {
        _createTimeLabel = [[UILabel alloc] init];
        [self.dialyView addSubview:_createTimeLabel];
        [_createTimeLabel setFont:[UIFont systemFontOfSize:11]];
        [_createTimeLabel setTextColor:[UIColor commonGrayTextColor]];
    }
    return _createTimeLabel;
}

- (UILabel*) contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        [self.dialyView addSubview:_contentLabel];
        [_contentLabel setNumberOfLines:2];
        [_contentLabel setFont:[UIFont systemFontOfSize:15]];
        [_contentLabel setTextColor:[UIColor commonTextColor]];
    }
    return _contentLabel;
}

@end
