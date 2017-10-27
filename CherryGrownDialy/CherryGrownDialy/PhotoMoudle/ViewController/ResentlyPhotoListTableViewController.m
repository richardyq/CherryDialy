//
//  ResentlyPhotoListTableViewController.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/12.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "ResentlyPhotoListTableViewController.h"
#import "PhotoTableViewCell.h"

@interface ResentlyPhotoListTableViewController ()
<PhotoControlSelectDelegate>
{
    NSArray* resentlyPhotos;
}
@end

@implementation ResentlyPhotoListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //[self makeTestPhotoList];
    [self startGetResentlyPhotoList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) startGetResentlyPhotoList{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(startGetResentlyPhotoListRequest)];
    MJRefreshNormalHeader* refHeader = (MJRefreshNormalHeader*)self.tableView.mj_header;
    refHeader.lastUpdatedTimeLabel.hidden = YES;
    [self.tableView.mj_header beginRefreshing];
}

- (void) startGetResentlyPhotoListRequest{
    [PhotoMoudleUtil startLoadResentlyPhotos:self resultSelector:@selector(resentlyPhotoListLoaded:) returnSelector:@selector(resentlyPhotoListReturn:)];
}

- (void) makeTestPhotoList{
    NSMutableArray* photoModels = [NSMutableArray array];
    for(NSInteger index = 0; index < 14; ++ index){
        PhotoInfoModel* model = [[PhotoInfoModel alloc] init];
        model.thumbUrl = @"http://oeimg2.cache.oeeee.com/201308/13/5209874b7de8c.jpg";
        model.imageUrl = @"http://oeimg2.cache.oeeee.com/201308/13/5209874b7de8c.jpg";
        [photoModels addObject:model];
    }
    resentlyPhotos = photoModels;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    if (resentlyPhotos) {
        NSInteger rows = resentlyPhotos.count / 4;
        if ((resentlyPhotos.count % 4) > 0) {
            rows += 1;
        }
        return rows;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoTableViewCell"];
    if (!cell) {
        cell = [[PhotoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PhotoTableViewCell"];
    }
    // Configure the cell...
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSInteger startIndex = indexPath.row * 4;
    NSInteger length = 4;
    if (startIndex + length > resentlyPhotos.count) {
        length = resentlyPhotos.count - startIndex;
    }
    NSRange subRange = NSMakeRange(startIndex, length);
    
    NSArray* photos = [resentlyPhotos subarrayWithRange:subRange];
    [cell setPhotoInfos:photos];
    [cell setSelectDelegate:self];
    return cell;
}

#pragma mark - UITableView Delegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenWidth/4;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

#pragma mark - Request CallBack
- (void) resentlyPhotoListLoaded:(id) result{
    if (result && [result isKindOfClass:[NSArray class]]) {
        resentlyPhotos = (NSArray<PhotoInfoModel*>*) result;
    }
}

- (void) resentlyPhotoListReturn:(JYJKRequestRetModel*) retModel{
    [self.tableView.mj_header endRefreshing];
    if (retModel.errorCode != Error_None) {
        [self showAlertMessage:retModel.errorMessage];
        return;
    }
    [self.tableView reloadData];
}

#pragma mark - PhotoControlSelectDelegate
- (void) photoControlSelect:(NSInteger) selectIndex{
    [PhotoViewControllerManager entryPhotoDetailPage:resentlyPhotos currentIndex:selectIndex];
}
@end
