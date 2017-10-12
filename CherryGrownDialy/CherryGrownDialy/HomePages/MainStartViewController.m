//
//  MainStartViewController.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/7.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "MainStartViewController.h"

@interface MainStartViewController ()

@end

@implementation MainStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"最近动态";
    
    SegmentViewController* segmentController = [[SegmentViewController alloc] init];
    [self addChildViewController:segmentController];
    [self.view addSubview:segmentController.view];
    
    [segmentController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.and.bottom.equalTo(self.view);
    }];
    
    RecentDialyListTableViewController* resentDialysViewController = [[RecentDialyListTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [resentDialysViewController setTitle:@"最近日记"];
    
    ResentlyPhotoListTableViewController* resentPhotosViewController = [[ResentlyPhotoListTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [resentPhotosViewController setTitle:@"最近照片"];
    
    [segmentController setViewControllers:@[resentDialysViewController, resentPhotosViewController]];
//    [segmentController setHighlightColor:[UIColor redColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
