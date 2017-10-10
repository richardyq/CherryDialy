//
//  SegmentBar.m
//  SegmentDemo
//
//  Created by yinquan on 17/2/14.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "SegmentBar.h"
#import "UIView+Segment_Size.h"
#import "UIColor+Segment.h"

@interface SegmentBar ()
{
    UIScrollView* scrollView;
    UIView* contentView;
    
    UIView* highlightLineView;
    UIView* bottomLine;
    
    UIColor* highlightColor;
}

@property (nonatomic, readonly) NSMutableArray<SegmentCell*>* segmentCells;
@end

@implementation SegmentBar

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWdidth, 47)];
    if (self)
    {
        highlightColor = [UIColor mainThemeColor];
        scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:scrollView];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        
        contentView = [[UIView alloc] initWithFrame:self.bounds];
        [scrollView addSubview:contentView];
        
        bottomLine = [[UIView alloc] init];
        [bottomLine setBackgroundColor:[UIColor colorWithHexString:@"DADADA"]];
        
        [contentView addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(contentView);
            make.bottom.equalTo(contentView);
            make.height.mas_equalTo(@0.5);
        }];
        
        highlightLineView = [[UIView alloc] init];
        [contentView addSubview:highlightLineView];
        [highlightLineView setBackgroundColor:highlightColor];
        [highlightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(contentView);
            make.height.mas_equalTo(@3);
        }];
    }
    return self;
}

- (void) setHighlightColor:(UIColor*) aHighlightColor
{
    highlightColor = aHighlightColor;
    [highlightLineView setBackgroundColor:aHighlightColor];
    if (self.segmentCells)
    {
        [self.segmentCells enumerateObjectsUsingBlock:^(SegmentCell * cell, NSUInteger idx, BOOL * _Nonnull stop) {
            [cell setHighlightColor:highlightColor];
        }];
    }
}

- (void) createCells:(NSArray*) titles
{
    if (_segmentCells) {
        [_segmentCells enumerateObjectsUsingBlock:^(SegmentCell* cell, NSUInteger idx, BOOL * _Nonnull stop) {
            [cell removeFromSuperview];
            
        }];
        [_segmentCells removeAllObjects];
        
    }
    else
    {
        _segmentCells = [NSMutableArray array];
    }
    
    [titles enumerateObjectsUsingBlock:^(NSString* title, NSUInteger idx, BOOL * _Nonnull stop) {
        SegmentCell* cell = [[SegmentCell alloc] init];
        [contentView addSubview:cell];
        [cell setTitle:title];
        [self.segmentCells addObject:cell];
    }];
    
    
    [self layoutCells];
}

- (void) layoutCells
{
    if (!self.segmentCells || self.segmentCells.count == 0) {
        return;
    }
    __block MASViewAttribute* cellLeft = contentView.mas_left;
    
    
    CGFloat cellWidth = contentView.width / self.segmentCells.count;
    
    [highlightLineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([NSNumber numberWithFloat:cellWidth]);
    }];
    
    if (self.segmentCells.count > 4) {
        cellWidth = contentView.width / 4;
        [contentView setWidth:cellWidth * self.segmentCells.count];
        [scrollView setContentSize:[contentView size]];
    }
    
    [self.segmentCells enumerateObjectsUsingBlock:^(SegmentCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop)
     {
         
        [cell addTarget:self action:@selector(segmentCellClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(contentView);
            make.left.equalTo(cellLeft);
            if (cell == self.segmentCells.lastObject) {
                make.right.equalTo(contentView);
            }
            make.width.mas_equalTo([NSNumber numberWithFloat:cellWidth]);
        }];
         
         cellLeft = cell.mas_right;
         
    }];
}

- (void) setSelectedIndex:(NSInteger)selectedIndex
{
    SegmentCell* oriCell = nil;
    if (self.segmentCells)
    {
        oriCell = self.segmentCells[self.selectedIndex];
    }
    _selectedIndex = selectedIndex;
    
//    [self setValue:[NSNumber numberWithInteger:selectedIndex] forKey:@"selectedIndex"];
    if (self.segmentCells) {
        [self.segmentCells enumerateObjectsUsingBlock:^(SegmentCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
            [cell setSelected:(selectedIndex == idx)];
        }];
    }
    if (!self.segmentCells) {
        return;
    }
    SegmentCell* selCell = self.segmentCells[selectedIndex];
    CGPoint ptOri = highlightLineView.center;
    
    [highlightLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selCell);
        make.bottom.equalTo(contentView);
        make.height.mas_equalTo(@3);
        make.width.mas_equalTo(selCell);
    }];
    
    [highlightLineView setCenter:ptOri];
    ptOri.x = selCell.center.x;
    
    //动画
    if (!oriCell)
    {
        return;
    }
    
    [UIView animateWithDuration:0.11 animations:^{
        [highlightLineView setCenter:ptOri];
    }];
}

- (void) setSegmentTitle:(NSString*) title atIndex:(NSInteger) index
{
    if (!title || title.length == 0) {
        return;
    }
    if (!self.segmentCells || index < 0 || index >= self.segmentCells.count) {
        return;
    }
    
    SegmentCell* cell = self.segmentCells[index];
    [cell setTitle:title];
}

- (void) segmentCellClicked:(id) sender
{
    SegmentCell* cell = (SegmentCell*) sender;
    if (!cell || ![cell isKindOfClass:[SegmentCell class]]) {
        return;
    }
    
    NSInteger cellIndex = [self.segmentCells indexOfObject:cell];
    if (cellIndex == NSNotFound) {
        return;
    }
    
    [self setSelectedIndex:cellIndex];
}



@end
