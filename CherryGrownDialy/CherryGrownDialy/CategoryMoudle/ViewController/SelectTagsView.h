//
//  SelectTagsView.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/9.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TagSelectViewSelectHandle)(UIControl* cell, NSInteger index);

@interface SelectTagCell : UIControl

@end;

@interface SelectTagsView : UIScrollView

- (instancetype)initWithSelectHandle:(TagSelectViewSelectHandle) handle;

- (void) setTagModels:(NSArray*) tagModels
    selectedTagModels:(NSArray*) selectedTagModels;

@end
