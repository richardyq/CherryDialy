//
//  ViewControllerManager.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/6.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "ViewControllerManager.h"
#import "WelcomeViewController.h"
#import "HomeTabbarViewController.h"

static ViewControllerManager* defaultControllerManager;


@interface ViewControllerManager ()
{
    
}
@property (nonatomic, strong) HomeTabbarViewController* homeTabbarController;

@end

@implementation ViewControllerManager

- (void) entryWelcomePage{
    WelcomeViewController* welcomeViewController = [[WelcomeViewController alloc] initWithNibName:nil bundle:nil];
    [[CommonUtil rootWindow] setRootViewController:welcomeViewController];
    
}

+ (ViewControllerManager*) defaultManager
{
    if (!defaultControllerManager)
    {
        defaultControllerManager = [[ViewControllerManager alloc] init];
    }
    
    return defaultControllerManager;
}

- (void) entryHomePage{
    if (!self.homeTabbarController) {
        _homeTabbarController = [[HomeTabbarViewController alloc] initWithNibName:nil bundle:nil];
        
    }
    UIViewController* rootViewController = [CommonUtil rootWindow].rootViewController;
    if (rootViewController != self.homeTabbarController) {
        [[CommonUtil rootWindow] setRootViewController:self.homeTabbarController];
        return;
    }
    
    [self.homeTabbarController setSelectedIndex:0];
}

- (UIViewController *) topMostViewController {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *topMostViewController = keyWindow.rootViewController;
    
    UIViewController* upperViewController = [self upperViewController:topMostViewController];
    while (topMostViewController != upperViewController) {
        topMostViewController = upperViewController;
        upperViewController = [self upperViewController:upperViewController];
    }
    
    return topMostViewController;
}

- (UIViewController*) upperViewController:(UIViewController*) viewController
{
    UIViewController* upperViewController = viewController;
    while (upperViewController.presentedViewController) {
        upperViewController = upperViewController.presentedViewController;
    };
    
    if ([upperViewController isKindOfClass:[UINavigationController class]]) {
        upperViewController = [(UINavigationController *)upperViewController visibleViewController];
    } else if ([upperViewController isKindOfClass:[UITabBarController class]]) {
        upperViewController = [(UITabBarController *)upperViewController selectedViewController];
    }
    
    return upperViewController;
}

- (CDBaseViewController*) entryPageViewController:(CDBaseViewController*) pageViewController{
    UIViewController* topMostViewController = [self topMostViewController];
    NSLog(@"currentViewController %@", [topMostViewController class]);
    
    UINavigationController* selectedNavigationContoller = topMostViewController.navigationController;
    if (!selectedNavigationContoller) {
        return nil;
    }
    if (![selectedNavigationContoller isKindOfClass:[UINavigationController class]])
    {
        return nil;
    }
    
    NSArray* pageContorllers = [selectedNavigationContoller viewControllers];
    __block CDBaseViewController* existedPageViewController = nil;
    
    [pageContorllers enumerateObjectsUsingBlock:^(UIViewController* viewController, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([viewController isKindOfClass:[CDBaseViewController class]])
        {
            CDBaseViewController* pageController = (CDBaseViewController*) viewController;
            if (!pageController.controllerId || pageController.controllerId.length == 0) {
                return ;
            }
            
            if ([pageController.controllerId isEqualToString:pageViewController.controllerId]) {
                existedPageViewController = pageController;
                
                
                *stop = YES;
                return;
            }
        }
    }];
    
    if (existedPageViewController) {
        [selectedNavigationContoller popToViewController:existedPageViewController animated:YES];
        return existedPageViewController;
    }
    
    [selectedNavigationContoller pushViewController:pageViewController animated:YES];
    
    return pageViewController;
}

@end
