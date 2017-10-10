//
//  WelcomeViewController.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/6.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "WelcomeViewController.h"
#import "InitializeUtil.h"


@interface WelcomeViewController ()

@property (nonatomic, strong) UIImageView* backgroundImageView;
@property (nonatomic, strong) InitializeUtil* initializeUtil;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self layoutElements];
    
    [self.initializeUtil startInitialize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) layoutElements{
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

#pragma mark - settingAndGetting
- (UIImageView*) backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"welcome_background"]];
        [self.view addSubview:_backgroundImageView];
    }
    return _backgroundImageView;
}

- (InitializeUtil*) initializeUtil
{
    if (!_initializeUtil) {
        _initializeUtil = [[InitializeUtil alloc] init];
        
    }
    return _initializeUtil;
}

@end
