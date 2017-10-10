//
//  SelectTagsView.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/9.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "SelectTagsView.h"

@interface SelectTagCell ()

@property (nonatomic, strong) UILabel* tagNameLabel;


- (void) setTagName:(NSString*) tagName;
- (CGFloat) cellWidth;
@end

@implementation SelectTagCell
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self layoutElements];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor mainThemeColor] CGColor];
        self.layer.cornerRadius = 14;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void) layoutElements
{
    [self.tagNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 7, 0, 7));
    }];
}

- (void) setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        [self.tagNameLabel setTextColor:[UIColor whiteColor]];
        [self setBackgroundColor:[UIColor mainThemeColor]];
    }
    else
    {
        [self.tagNameLabel setTextColor:[UIColor mainThemeColor]];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
}

- (void) setTagName:(NSString*) tagName{
    [self.tagNameLabel setText:tagName];
}

- (CGFloat) cellWidth{
    CGFloat cellWidth = 15;
    if (self.tagNameLabel.text) {
        CGFloat nameWidth = [self.tagNameLabel.text widthSystemFont:self.tagNameLabel.font];
        cellWidth += nameWidth;
    }
    
    return cellWidth;
}

#pragma mark settingAndGetting
- (UILabel*) tagNameLabel
{
    if (!_tagNameLabel) {
        _tagNameLabel = [[UILabel alloc] init];
        [self addSubview:_tagNameLabel];
        [_tagNameLabel setFont:[UIFont systemFontOfSize:12]];
        [_tagNameLabel setTextColor:[UIColor mainThemeColor]];
    }
    return _tagNameLabel;
}
@end

@interface SelectTagsView ()
{
    NSMutableArray* tagCells;
}

@property (nonatomic, strong) TagSelectViewSelectHandle selectHandle;
@end

@implementation SelectTagsView

- (instancetype)initWithSelectHandle:(TagSelectViewSelectHandle) handle
{
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self showTopLine];
        _selectHandle = handle;
        tagCells = [NSMutableArray array];
    }
    return self;
}

- (void) setTagModels:(NSArray*) tagModels
    selectedTagModels:(NSArray*) selectedTagModels
{
    __block CGFloat cellRight = 15;
    __block CGFloat maxBottom = 15;
    [tagModels enumerateObjectsUsingBlock:^(TagModel* model, NSUInteger idx, BOOL * _Nonnull stop) {
        SelectTagCell* cell = [[SelectTagCell alloc] init];
        [cell addTarget:self action:@selector(tagSelectCellClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger index = [selectedTagModels indexOfObject:model];
        [cell setSelected:(index != NSNotFound)];
        
        [self addSubview:cell];
        [cell setTagName:model.name];
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(@28);
            SelectTagCell* lastCell = tagCells.lastObject;
            CGFloat cellWidth = [cell cellWidth];
            
            [tagCells addObject:cell];
            if (!lastCell)
            {
                make.left.equalTo(self).offset(15);
                make.top.equalTo(self).offset(15);
                cellRight = 15 + cellWidth + 10;
                maxBottom += 28;
                return ;
            }
            
            if (cellRight + 10 + cellWidth > (ScreenWidth - 15))
            {
                make.left.equalTo(self).offset(15);
                make.top.equalTo(lastCell.mas_bottom).offset(15);
                cellRight = 15 + cellWidth + 10;
                maxBottom += 28;
                return ;
            }
            else{
                make.left.equalTo(lastCell.mas_right).offset(10);
                make.top.equalTo(lastCell);
                cellRight += (cellWidth + 10);
            }
        }];
        
        
    }];
    
    [self setContentSize:CGSizeMake(ScreenWidth, maxBottom + 15)];
}

- (void) tagSelectCellClicked:(id) sender
{
    if (![sender isKindOfClass:[SelectTagCell class]]) {
        return;
    }
    SelectTagCell* cell = (SelectTagCell*) sender;
    NSInteger index = [tagCells indexOfObject:sender];
    if (index == NSNotFound) {
        return;
    }
    
    if (self.selectHandle)
    {
        self.selectHandle(cell, index);
    }
}
@end
