//
//  PhotoDetailViewController.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/12.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "PhotoImageViewController.h"

@interface PhotoDetailViewController ()
<UIPageViewControllerDataSource>
@property (nonatomic, strong) NSArray<PhotoInfoModel*>* photos;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UIPageViewController* pageViewController;
@property (nonatomic, strong) UIButton* backButton;
@end

@implementation PhotoDetailViewController

- (id) initWithPhotos:(NSArray<PhotoInfoModel*>*) photos
         currentIndex:(NSInteger) currentIndex
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _photos = photos;
        _currentIndex = currentIndex;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //全屏显示
    [self setFd_prefersNavigationBarHidden:YES];
    
    [self layoutElements];
    
    PhotoInfoModel* model = self.photos[self.currentIndex];
    PhotoImageViewController* imageViewController = [[PhotoImageViewController alloc] initWithPhotoModel:model];
	[self.pageViewController setViewControllers:@[imageViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) layoutElements{
    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(17);
        make.top.equalTo(self.view).offset(25);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
}



#pragma mark - settingAndGetting
- (UIPageViewController*) pageViewController{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        
        [self addChildViewController:_pageViewController];
        [self.view addSubview:_pageViewController.view];
        [_pageViewController setDataSource:self];
        [_pageViewController.view setBackgroundColor:[UIColor blackColor]];
    }
    return _pageViewController;
}

- (UIButton*) backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_backButton];
        [_backButton setBackgroundImage:[UIImage rectImage:CGSizeMake(40, 40) Color:[UIColor commonTranslucentColor]] forState:UIControlStateNormal];
        [_backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        _backButton.layer.cornerRadius = 20;
        _backButton.layer.masksToBounds = YES;
        [_backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

#pragma mark - control events
- (void) backButtonClicked:(id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    PhotoImageViewController* photoViewController = (PhotoImageViewController*) viewController;
    PhotoInfoModel* photoModel = photoViewController.photoModel;
    NSInteger index = [self.photos indexOfObject:photoModel];
    if (index == 0) {
        return nil;
    }
    
    PhotoInfoModel* model = self.photos[index - 1];
    PhotoImageViewController* imageViewController = [[PhotoImageViewController alloc] initWithPhotoModel:model];
    
    return imageViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    PhotoImageViewController* photoViewController = (PhotoImageViewController*) viewController;
    PhotoInfoModel* photoModel = photoViewController.photoModel;
    NSInteger index = [self.photos indexOfObject:photoModel] + 1;
    if (index >= self.photos.count) {
        return nil;
    }
    
    PhotoInfoModel* model = self.photos[index];
    PhotoImageViewController* imageViewController = [[PhotoImageViewController alloc] initWithPhotoModel:model];
    
    return imageViewController;
}

@end
