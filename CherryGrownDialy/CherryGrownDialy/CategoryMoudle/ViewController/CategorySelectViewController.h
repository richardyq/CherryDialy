//
//  CategorySelectViewController.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/8.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CategorySelectHandle)(CategoryModel* model);

@interface CategorySelectViewController : UIViewController

+ (void) showWithHandel:(CategorySelectHandle) handle;
@end
