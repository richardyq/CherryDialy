//
//  PhotoTableViewCell.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/12.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "PhotoTableViewCell.h"

@interface PhotoInfoCell()

- (void) setThumbImageUrl:(NSString*) thumbImageUsl;
@end

@implementation PhotoInfoCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self layoutElements];
    }
    return self;
}

- (void) layoutElements{
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(2, 2, 2, 2));
    }];
}

#pragma mark - settingAndGetting
- (UIImageView*) photoImageView{
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] init];
        [self addSubview:_photoImageView];
    }
    return _photoImageView;
}

- (void) setThumbImageUrl:(NSString*) thumbImageUsl
{
    if (!thumbImageUsl || thumbImageUsl.length == 0) {
        [self.photoImageView setImage:nil];
        return ;
    }
    
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:thumbImageUsl] placeholderImage:[UIImage imageNamed:@"img_default"]];
}

@end

@interface PhotoTableViewCell ()
{
    NSArray* photoCells;
}
@end

@implementation PhotoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self createPhotoCells];
    }
    return self;
}

- (void) createPhotoCells{
    
    NSMutableArray* controls = [NSMutableArray array];
    for (int index = 0; index < 4; ++index)
    {
        PhotoInfoCell* control = [[PhotoInfoCell alloc] init];
        [self.contentView addSubview:control];
        [controls addObject:control];
        [control addTarget:self action:@selector(photoCellClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    photoCells = controls;
    
    __block MASViewAttribute* cellLeft = self.contentView.mas_left;
    [photoCells enumerateObjectsUsingBlock:^(PhotoInfoCell* control, NSUInteger idx, BOOL * _Nonnull stop) {
        [control mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(cellLeft);
            
            if (idx > 0) {
                PhotoInfoCell* perControl = photoCells[idx - 1];
                make.width.equalTo(perControl);
            }
            
            if (control == photoCells.lastObject) {
                make.right.equalTo(self.contentView);
            }
        }];
        cellLeft = control.mas_right;
    }];
}

- (void) photoCellClick:(id) sender
{
    if (![sender isKindOfClass:[PhotoInfoCell class]]) {
        return;
    }
    NSInteger clickIndex = [photoCells indexOfObject:sender];
    if (self.selectDelegate && [self.selectDelegate respondsToSelector:@selector(photoControlSelect:)])
    {
        [self.selectDelegate photoControlSelect:clickIndex + (self.cellRow * 4)];
    }
}

- (void) setPhotoInfos:(NSArray<PhotoInfoModel *>*) photoInfos{
    [photoCells enumerateObjectsUsingBlock:^(PhotoInfoCell* cell, NSUInteger idx, BOOL * _Nonnull stop) 
    {
        
        [cell setThumbImageUrl:nil];
    }];
    
    [photoInfos enumerateObjectsUsingBlock:^(PhotoInfoModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 3) {
            return ;
        }
        
        PhotoInfoCell* cell = photoCells[idx];
        [cell setThumbImageUrl:model.thumbUrl];
    }];
}
@end
