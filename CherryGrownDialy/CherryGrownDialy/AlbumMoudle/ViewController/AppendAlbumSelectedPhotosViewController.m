//
//  AppendAlbumSelectedPhotosViewController.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/11/3.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "AppendAlbumSelectedPhotosViewController.h"
#import "AppendAlbumPhotoControl.h"
#import "SelectAlbumPhotosViewController.h"

@interface AppendAlbumSelectedPhotosViewController ()

@property (nonatomic, strong) NSMutableArray<AppendAlbumPhotoControl*>* photoControls;

@end

@implementation AppendAlbumSelectedPhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createPhotoControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) createPhotoControls
{
    if (self.photoControls) {
        [self.photoControls enumerateObjectsUsingBlock:^(AppendAlbumPhotoControl * control, NSUInteger idx, BOOL * _Nonnull stop) {
            [control removeFromSuperview];
        }];
        [self.photoControls removeAllObjects];
    }
    else
    {
        _photoControls = [NSMutableArray array];
        
    }
    
    [self.photoModels enumerateObjectsUsingBlock:^(PhotoInfoModel * photoModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        AppendAlbumPhotoControl* control = [[AppendAlbumPhotoControl alloc] init];
        [control setPhotoInfoModel:self.photoModels[idx]];
        [self.view addSubview:control];
        [self.photoControls addObject:control];
//        [control addTarget:self action:@selector(selectedControlClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if (idx == 15) {
            *stop = 0;
            return ;
        }
    }];
    
    if (self.photoControls.count < 16) {
        AppendAlbumPhotoControl* control = [[AppendAlbumPhotoControl alloc] init];
        [self.view addSubview:control];
        [self.photoControls addObject:control];
        [control addTarget:self action:@selector(appendControlClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self layoutPhotoControls];
}

- (void) layoutPhotoControls{
    CGFloat controlLength = (ScreenWidth - 70)/4;
    
    [self.photoControls enumerateObjectsUsingBlock:^(AppendAlbumPhotoControl * control, NSUInteger idx, BOOL * _Nonnull stop) {
        [control mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(controlLength, controlLength));
            AppendAlbumPhotoControl* perControl = nil;
            if (idx > 0) {
                perControl = self.photoControls[idx - 1];
            }
            
            if ((idx % 4) == 0) {
                make.left.equalTo(self.view).offset(15);
            }
            else
            {
                make.left.equalTo(perControl.mas_right).offset(10);
            }
            
            if (idx < 4) {
                make.top.equalTo(self.view).offset(15);
            }
            else if ((idx % 4) == 0){
                make.top.equalTo(perControl.mas_bottom).offset(10);
            }
            else{
                make.top.equalTo(perControl);
            }
        }];
    }];
}

- (void) selectedControlClicked:(id) sender
{
    
}

- (void) appendControlClicked:(id) sender
{
    NSInteger index = [self.photoControls indexOfObject:sender];
    if (index == NSNotFound) {
        return;
    }
    
    if (sender == self.photoControls.lastObject && index >= self.photoModels.count) {
        __weak typeof(self) weakSelf = self;
        [SelectAlbumPhotosViewController showWithSelectedPhotos:self.photoModels selectHandle:^(NSArray<PhotoInfoModel *> *selectPhotoModels) {
            if (!weakSelf) {
                weakSelf.photoModels = [NSMutableArray arrayWithArray:selectPhotoModels];
            }
        }];
    }
}

@end
