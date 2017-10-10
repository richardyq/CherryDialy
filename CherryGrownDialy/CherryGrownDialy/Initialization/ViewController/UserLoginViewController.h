//
//  UserLoginViewController.h
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/6.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UserLoginBlock)(void);

@interface UserLoginViewController : UIViewController

@property (nonatomic, strong) UserLoginBlock block;

+ (void) showWithBlock:(UserLoginBlock) block;
@end
