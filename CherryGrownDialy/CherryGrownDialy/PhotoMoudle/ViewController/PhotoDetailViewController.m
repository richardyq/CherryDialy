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
    NSInteger index = [self.photos indexOfObject:photoModel];
    if (index >= self.photos.count) {
        return nil;
    }
    
    PhotoInfoModel* model = self.photos[index + 1];
    PhotoImageViewController* imageViewController = [[PhotoImageViewController alloc] initWithPhotoModel:model];
    
    return imageViewController;
}

@end
