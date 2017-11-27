//
//  CDBaseViewController.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/8.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "CDBaseViewController.h"

@interface CDBaseViewController ()

@end

@implementation CDBaseViewController

@synthesize controllerId = _controllerId;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - settingAndGetting
- (NSString*) controllerId
{
    if (!_controllerId) {
        NSString* classname = NSStringFromClass([self class]);
        NSMutableDictionary* controllerIdDictionary = [NSMutableDictionary dictionary];
        [controllerIdDictionary setValue:classname forKey:@"controllerName"];
        
        NSDictionary* controllerParamDictionary = [self controllerParamDictionary];
        if (controllerParamDictionary) {
            [controllerIdDictionary setValue:controllerParamDictionary forKey:@"controllParam"];
        }
        _controllerId = [controllerIdDictionary mj_JSONString];
    }
    
    return _controllerId;
}

- (NSDictionary*) controllerParamDictionary
{
    return nil;
}


@end
