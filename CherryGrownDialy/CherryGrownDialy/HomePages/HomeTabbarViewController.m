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
    [self.tabBar setBackgroundImage:[UIImage rectImage:CGSizeMake(ScreenWidth, 49) Color:[UIColor mainThemeColor]]];
    [self.tabBar setTintColor:[UIColor whiteColor]];
    if (@available(iOS 10.0, *)) {
        [self.tabBar setUnselectedItemTintColor:[UIColor commonLightGrayTextColor]];
    } else {
        // Fallback on earlier versions
        
    }
    
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
    mainNavigationController.tabBarItem.title = @"最近";
    mainNavigationController.tabBarItem.image = [UIImage imageNamed:@"tabbar_home_m"];
    
    //日记
    DialyStartViewController* dialyStartViewController = [[DialyStartViewController alloc] initWithNibName:nil bundle:nil];
    BaseNavigationViewController* dialyNavigationController = [[BaseNavigationViewController alloc]initWithRootViewController:dialyStartViewController];
    dialyNavigationController.tabBarItem.title = @"最近";
    dialyNavigationController.tabBarItem.image = [UIImage imageNamed:@"tabbar_dialy_m"];
    
    //相册
    AlbumStartViewController* albumStartViewController = [[AlbumStartViewController alloc] initWithNibName:nil bundle:nil];
    BaseNavigationViewController* albumNavigationController = [[BaseNavigationViewController alloc]initWithRootViewController:albumStartViewController];
    albumNavigationController.tabBarItem.title = @"相册";
    albumNavigationController.tabBarItem.image = [UIImage imageNamed:@"tabbar_album_m"];
    
    //照片
    PhotoStartViewController* photoStartViewController = [[PhotoStartViewController alloc] initWithNibName:nil bundle:nil];
    BaseNavigationViewController* photoNavigationController = [[BaseNavigationViewController alloc]initWithRootViewController:photoStartViewController];
    photoNavigationController.tabBarItem.title = @"照片";
    photoNavigationController.tabBarItem.image = [UIImage imageNamed:@"tabbar_photo_m"];
    
    [self setViewControllers:@[mainNavigationController,
                               dialyNavigationController,
                               albumNavigationController,
                               photoNavigationController]];
}

@end
