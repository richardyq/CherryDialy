//
//  AppendPhotoListViewController.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/20.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "AppendPhotoListViewController.h"
#import "AppendPhotoControl.h"
#import "AssetsLibrarySelectViewController.h"

static const NSInteger kMaxPhotoCount = 8;

@interface AppendPhotoListViewController ()
{
    NSMutableArray<AppendPhotoControl*>* appendImageControls;
}

@end

@implementation AppendPhotoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appendImageControls = [NSMutableArray array];
    _imageList = [NSMutableArray array];
    _thumbList = [NSMutableArray array];
    
    AppendPhotoControl* appendControl = [[AppendPhotoControl alloc] init];
    [appendImageControls addObject:appendControl];
    [self.view addSubview:appendControl];
    [appendControl addTarget:self action:@selector(photoControlClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self layoutPhotoControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) layoutPhotoControls{
    CGFloat controlLength = (ScreenWidth - 70)/4;
    
    [appendImageControls enumerateObjectsUsingBlock:^(AppendPhotoControl * control, NSUInteger idx, BOOL * _Nonnull stop) {
        [control mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(controlLength, controlLength));
            AppendPhotoControl* perControl = nil;
            if (idx > 0) {
                perControl = appendImageControls[idx - 1];
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

- (void) photoControlClicked:(id) sender{
    NSInteger controlIndex = [appendImageControls indexOfObject:sender];
    if (controlIndex == NSNotFound) {
        return;
    }
    
    if (controlIndex == (self.imageList.count + 1)) {
        //添加新的照片
    }
    else{
         UIAlertController *sheetalert = [UIAlertController alertControllerWithTitle:@"选择照片来源" message:nil preferredStyle:  UIAlertControllerStyleActionSheet];
        
        [sheetalert addAction:[UIAlertAction actionWithTitle:@"手机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            //手机拍照
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [self showAlertMessage:@"对不起，您的手机暂时不支持手机拍摄照片。"];
                return ;
            }
        }]];
        [sheetalert addAction:[UIAlertAction actionWithTitle:@"从手机相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                [self showAlertMessage:@"对不起，您的手机暂时不支持手机照片库。"];
                return ;
            }
            
            [self showAssetsLibrarySelectViewController];
            
        }]];
        
        [sheetalert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
            
        }]];
        
        [self presentViewController:sheetalert animated:true completion:nil];
    }
}

- (void) showAssetsLibrarySelectViewController{
    AssetsLibrarySelectViewController* selectViewController = [[AssetsLibrarySelectViewController alloc] initWithLimitCount:kMaxPhotoCount];
    [self.navigationController pushViewController:selectViewController animated:YES];
    
}


@end
