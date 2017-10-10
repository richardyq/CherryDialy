//
//  HomeTabbarViewController.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/7.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "HomeTabbarViewController.h"

#import "MainStartViewController.h"
#import "DialyStartViewController.h"
#import "PhotoStartViewController.h"
#import "AlbumStartViewController.h"

@interface HomeTabbarViewController ()

@end

@implementation HomeTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initControllers{
    
    //首页-最近动态
    MainStartViewController* mainViewController = [[MainStartViewController alloc] initWithNibName:nil bundle:nil];
    BaseNavigationViewController* mainNavigationController = [[BaseNavigationViewController alloc]initWithRootViewController:mainViewController];
    
    //日记
    DialyStartViewController* dialyStartViewController = [[DialyStartViewController alloc] initWithNibName:nil bundle:nil];
    BaseNavigationViewController* dialyNavigationController = [[BaseNavigationViewController alloc]initWithRootViewController:dialyStartViewController];
    
    //相册
    AlbumStartViewController* albumStartViewController = [[AlbumStartViewController alloc] initWithNibName:nil bundle:nil];
    BaseNavigationViewController* albumNavigationController = [[BaseNavigationViewController alloc]initWithRootViewController:albumStartViewController];
    
    //照片
    PhotoStartViewController* photoStartViewController = [[PhotoStartViewController alloc] initWithNibName:nil bundle:nil];
    BaseNavigationViewController* photoNavigationController = [[BaseNavigationViewController alloc]initWithRootViewController:photoStartViewController];
    
    [self setViewControllers:@[mainNavigationController,
                               dialyNavigationController,
                               albumNavigationController,
                               photoNavigationController]];
}

@end
