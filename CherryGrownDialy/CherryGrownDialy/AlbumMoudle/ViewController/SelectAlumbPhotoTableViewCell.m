//
//  SelectAlumbPhotoTableViewCell.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/11/20.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "SelectAlumbPhotoTableViewCell.h"

@interface SelectAlumbPhotoInfoCell()

@property (nonatomic, strong) UIImageView* selectedImageView;

- (void) setThumbImageUrl:(NSString*) thumbImageUsl;
@end

@implementation SelectAlumbPhotoInfoCell

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
    
    [self.selectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.right.bottom.equalTo(self).offset(3);
    }];
}

- (void) setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self.selectedImageView setHidden:!selected];
}

#pragma mark - settingAndGetting
- (UIImageView*) photoImageView{
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] init];
        [self addSubview:_photoImageView];
    }
    return _photoImageView;
}

- (UIImageView*) selectedImageView
{
    if (!_selectedImageView) {
        _selectedImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo_checked"]];
        [self addSubview:_selectedImageView];
        [_selectedImageView setHidden:YES];
    }
    return _selectedImageView;
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

@interface SelectAlumbPhotoTableViewCell ()
{
    NSArray* photoCells;
}
@end

@implementation SelectAlumbPhotoTableViewCell

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
        SelectAlumbPhotoInfoCell* control = [[SelectAlumbPhotoInfoCell alloc] init];
        [self.contentView addSubview:control];
        [controls addObject:control];
        [control addTarget:self action:@selector(photoCellClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    photoCells = controls;
    
    __block MASViewAttribute* cellLeft = self.contentView.mas_left;
    [photoCells enumerateObjectsUsingBlock:^(SelectAlumbPhotoInfoCell* control, NSUInteger idx, BOOL * _Nonnull stop) {
        [control mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(cellLeft);
            
            if (idx > 0) {
                //                PhotoInfoCell* perControl = photoCells[idx - 1];
                make.width.mas_equalTo(@(ScreenWidth/4));
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
    if (![sender isKindOfClass:[SelectAlumbPhotoInfoCell class]]) {
        return;
    }
    NSInteger clickIndex = [photoCells indexOfObject:sender];
    if (self.selectDelegate && [self.selectDelegate respondsToSelector:@selector(photoControlSelect:)])
    {
        [self.selectDelegate photoControlSelect:clickIndex + (self.cellRow * 4)];
    }
}

- (void) setPhotoInfos:(NSArray<PhotoInfoModel *>*) photoInfos{
    [photoCells enumerateObjectsUsingBlock:^(SelectAlumbPhotoInfoCell* cell, NSUInteger idx, BOOL * _Nonnull stop)
     {
         
         [cell setThumbImageUrl:nil];
     }];
    
    [photoInfos enumerateObjectsUsingBlock:^(PhotoInfoModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 3) {
            return ;
        }
        
        SelectAlumbPhotoInfoCell* cell = photoCells[idx];
        [cell setThumbImageUrl:model.thumbUrl];
    }];
}
@end
