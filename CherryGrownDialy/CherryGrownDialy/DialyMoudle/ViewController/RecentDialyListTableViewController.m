//
//  RecentDialyListTableViewController.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/10.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "RecentDialyListTableViewController.h"
#import "DialyInfoTableViewCell.h"

@interface RecentDialyListTableViewController ()

@property (nonatomic, strong) NSArray<DialyModel*>* dialyModels;
@end

@implementation RecentDialyListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setBackgroundColor:[UIColor commonBackgroundColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self makeTestDialyData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) makeTestDialyData{
    NSMutableArray* models = [NSMutableArray array];
    for (NSInteger index = 0; index < 5; ++index)
    {
        DialyModel* model = [[DialyModel alloc] init];
        model.id = index + 20;
        model.createUserName = @"殷全";
        model.createTime = @"2017-10-05";
        model.content = @"阿斯顿福克斯的饭卡上；大家阿斯顿开发速度加快水淀粉；卡卷上的撒地方看见啊煞风景啊；";
        model.cateId = 3;
        model.cateName = @"学习教育";
        model.tags = @"快乐,成长,学习";
        [models addObject:model];
    }
    _dialyModels = [NSArray arrayWithArray:models];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    if (self.dialyModels) {
        return self.dialyModels.count;
    }
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 97;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DialyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DialyInfoTableViewCell"];
    if (!cell) {
        cell = [[DialyInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DialyInfoTableViewCell"];
    }
    // Configure the cell...
    
    DialyModel* model = self.dialyModels[indexPath.row];
    [cell setDialyModel:model];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DialyModel* model = self.dialyModels[indexPath.row];
    [DialyViewControllerManager entryDialyDetailPage:model.id];
}


@end
