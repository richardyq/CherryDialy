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
{
    NSArray* resentlyPhotos;
}
@end

@implementation ResentlyPhotoListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self makeTestPhotoList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


@end
