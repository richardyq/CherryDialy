//
//  AlbumStartViewController.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/7.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "AlbumStartViewController.h"

@interface AlbumStartViewController ()

@end

@implementation AlbumStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"相册";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIBarButtonItem* appendBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(appendAlbumButtonClicked:)];
    [self.navigationItem setRightBarButtonItem:appendBarButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) appendAlbumButtonClicked:(id) sender
{
    //新增相册
    [AlbumViewControllerManager entryAppendAlbumPage];
}

@end
