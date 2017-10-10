//
//  TagsSelectViewController.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/9.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TagSelectHandle)(TagModel* tagModel);

@interface TagsSelectViewController : UIViewController

+ (void) showWithSelectedTags:(NSMutableArray*) selectedTags
                 selectHandle:(TagSelectHandle) handle;
@end
