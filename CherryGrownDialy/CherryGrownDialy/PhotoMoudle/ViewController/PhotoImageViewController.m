//
//  PhotoImageViewController.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/12.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "PhotoImageViewController.h"

@interface PhotoImageViewController ()

@property (nonatomic, strong) UIImageView* photoImageView;
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

#pragma mark - settingAndGetting
- (UIImageView*) photoImageView{
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_default"]];
        [self.view addSubview:_photoImageView];
    }
    return _photoImageView;
}

@end
