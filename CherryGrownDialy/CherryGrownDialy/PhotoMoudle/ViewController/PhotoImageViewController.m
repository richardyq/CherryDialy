//
//  PhotoImageViewController.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/12.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "PhotoImageViewController.h"
#import <Photos/Photos.h>

@interface PhotoImageViewController ()

@property (nonatomic, strong) UIImageView* photoImageView;
@property (nonatomic, strong) UIImage* photoImage;

@end

@implementation PhotoImageViewController

- (id) initWithPhotoModel:(PhotoInfoModel*) phototModel
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _photoModel = phototModel;
    }
    return self;
}

- (void) loadView{
    UIScrollView* scrollView = [[UIScrollView alloc] init];
    [self setView:scrollView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self layoutElements];
    __weak typeof(self) weakSelf = self;
    if (self.photoModel) {
        [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:self.photoModel.thumbUrl] placeholderImage:[UIImage imageNamed:@"img_default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!weakSelf) {
                return ;
            }
            if (error) {
                return;
            }
            [weakSelf performSelector:@selector(showImage:) withObject:image afterDelay:0.04];
            //
            //[weakSelf showImage:image];
        }];
    }
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTableviewCellLongPressed:)];
//    longPress.delegate = self;
    longPress.minimumPressDuration = 1.0;
    [self.view addGestureRecognizer:longPress];
}

- (void) showImage:(UIImage*) thumbImage{
    __weak typeof(self) weakSelf = self;
    NSURL* imageUrl = [NSURL URLWithString:self.photoModel.imageUrl];
    [self.photoImageView sd_setImageWithURL:imageUrl placeholderImage: thumbImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!weakSelf) {
            return ;
        }
        if (error) {
            return;
        }
        
        _photoImage = image;
        
        CGFloat imageHeight = ScreenWidth * (image.size.height / image.size.width);
        if (imageHeight < ScreenHeight) {
            [weakSelf.photoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(weakSelf.view);
                make.width.equalTo(weakSelf.view);
                make.height.mas_equalTo(@(imageHeight));
            }];
            UIScrollView* scrollView = (UIScrollView*) self.view;
            [scrollView setContentSize:CGSizeMake(ScreenWidth, ScreenHeight)];
        }
        else{
            [weakSelf.photoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.view);
                make.top.equalTo(weakSelf.view);
                make.width.equalTo(weakSelf.view);
                make.height.mas_equalTo(@(imageHeight));
            }];
            UIScrollView* scrollView = (UIScrollView*) self.view;
            [scrollView setContentSize:CGSizeMake(ScreenWidth, imageHeight)];
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) layoutElements{
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth / 3, ScreenWidth / 3));
    }];
}

- (void) showSaveMenu{
    UIAlertController *sheetalert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:  UIAlertControllerStyleActionSheet];
    __weak typeof(self) weakSelf = self;
    [sheetalert addAction:[UIAlertAction actionWithTitle:@"保存到相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        [weakSelf loadImageFinished:self.photoImage];
    }]];
    
    
    [sheetalert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        
    }]];
    
    [self presentViewController:sheetalert animated:true completion:nil];
}

#pragma mark - settingAndGetting
- (UIImageView*) photoImageView{
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_default"]];
        [self.view addSubview:_photoImageView];
    }
    return _photoImageView;
}

#pragma mark control events
- (void) handleTableviewCellLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        //弹出操作菜单
        if (self.photoImage) {
            [self showSaveMenu];
        }
        
    }
}

- (void)loadImageFinished:(UIImage *)image
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        NSLog(@"success = %d, error = %@", success, error);
        
    }];
}



@end
