//
//  AssetsLibrarySelectViewController.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/20.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "AssetsLibrarySelectViewController.h"
#import <Photos/Photos.h>
#import "AssetsLibraryCollectionViewCell.h"

#import "AppendPhotoImageModel.h"



@interface AssetsLibrarySelectViewController ()
<UICollectionViewDelegate, UICollectionViewDataSource>
{
    PHFetchResult *assets;
    PHImageRequestOptions *option;
}

@property (nonatomic, assign) NSInteger limitCount;
@property (nonatomic,strong) NSMutableArray *photoArray;
@property (nonatomic, strong) NSMutableArray<PHAsset*>* selectedArray;

@property (nonatomic, strong) UICollectionView* photoListCollectionView;

@property (nonatomic, strong) UIView* submitView;
@property (nonatomic, strong) UILabel* submitLabel;
@property (nonatomic, strong) UIButton* submitButton;

@property (nonatomic, strong) SelectUploadPhotosHandle selectHandle;
@end

@implementation AssetsLibrarySelectViewController

+ (void) showWithLimitCount:(NSInteger) limitCount
                      hanle:(SelectUploadPhotosHandle) handle
{
    AssetsLibrarySelectViewController* selectViewController = [[AssetsLibrarySelectViewController alloc] initWithLimitCount:limitCount];
    [selectViewController setSelectHandle:handle];
    
    BaseNavigationViewController* selectNavigationController = [[BaseNavigationViewController alloc]initWithRootViewController:selectViewController];
    [selectNavigationController.navigationBar setTranslucent:NO];
    
    
    UINavigationController* topmostNavigationController = [[ViewControllerManager defaultManager] topMostViewController].navigationController;
    [topmostNavigationController presentViewController:selectNavigationController animated:YES completion:nil];
}

- (id) initWithLimitCount:(NSInteger) limitCount
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _limitCount = limitCount;
        _photoArray = [NSMutableArray array];
        _selectedArray = [NSMutableArray array];
    }
    return self;
}

- (void) backUp{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"选择照片";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageNamed:@"back.png" targe:self action:@selector(backUp)];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self layoutElements];
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        // 这里便是无访问权限
        //可以弹出个提示框，叫用户去设置打开相册权限
        [self showAlertMessage:@"对不起，您没有设置照片权限"];
    }  else {
        //这里就是用权限， 获取相册中的照片
        [self loadAllPhotos];
    }
    
}

- (void) layoutElements
{
    [self.photoListCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-64);
    }];
    
    [self.submitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.photoListCollectionView.mas_bottom);
    }];
    
    [self.submitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.submitView).offset(12.5);
        make.centerY.equalTo(self.submitView);
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.submitView).offset(-12.5);
        make.size.mas_equalTo(CGSizeMake(75, 29));
        make.centerY.equalTo(self.submitView);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadAllPhotos{
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    
    //获取相机胶卷所有图片
    assets = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];
    option = [[PHImageRequestOptions alloc] init];
    
    //设置显示模式
    /*
     PHImageRequestOptionsResizeModeNone    //选了这个就不会管传如的size了 ，要自己控制图片的大小，建议还是选Fast
     PHImageRequestOptionsResizeModeFast    //根据传入的size，迅速加载大小相匹配(略大于或略小于)的图像
     PHImageRequestOptionsResizeModeExact    //精确的加载与传入size相匹配的图像
     */
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    option.synchronous = NO;
    option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;

    [self.photoListCollectionView reloadData];

}

#pragma mark - settingAndGetting
- (UICollectionView*) photoListCollectionView
{
    if (!_photoListCollectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        // 自定义的布局对象
        
        _photoListCollectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds  collectionViewLayout:flowLayout];
        
        _photoListCollectionView.backgroundColor = [UIColor whiteColor];
        _photoListCollectionView.dataSource = self;
        _photoListCollectionView.delegate = self;
        [_photoListCollectionView registerClass:[AssetsLibraryCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([AssetsLibraryCollectionViewCell class])];
        [self.view addSubview:_photoListCollectionView];
        //[self setView:collectionView];
    }
    
    return _photoListCollectionView;
}

- (UIView*) submitView
{
    if(!_submitView)
    {
        _submitView = [[UIView alloc] init];
        [self.view addSubview:_submitView];
        
        [_submitView showTopLine];
        [_submitView setBackgroundColor:[UIColor whiteColor]];
    }
    return _submitView;
}

- (UILabel*) submitLabel
{
    if (!_submitLabel) {
        _submitLabel = [[UILabel alloc] init];
        [_submitLabel setFont:[UIFont systemFontOfSize:14]];
        [_submitLabel setTextColor:[UIColor commonGrayTextColor]];
        [self.submitView addSubview:_submitLabel];
        NSString* totalString = [NSString stringWithFormat:@"已选0张／一共可选%ld张", self.limitCount];
        [_submitLabel setText:totalString];
    }
    return _submitLabel;
}

- (UIButton*) submitButton{
    if(!_submitButton){
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.submitView addSubview:_submitButton];
        
        [_submitButton setBackgroundImage:[UIImage rectImage:CGSizeMake(320, 46) Color:[UIColor mainThemeColor]] forState:UIControlStateNormal];
        [_submitButton setTitle:@"确定" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        
        _submitButton.layer.cornerRadius = 5;
        _submitButton.layer.masksToBounds = YES;
        
        [_submitButton addTarget:self action:@selector(submitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (assets) {
        NSLog(@"numberOfItemsInSection count = %ld", assets.count);
        return assets.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AssetsLibraryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AssetsLibraryCollectionViewCell class]) forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    PHAsset *asset = [assets objectAtIndex:assets.count - indexPath.row - 1];
    
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(500, 500) contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        UIImage* image = [UIImage imageWithData:UIImageJPEGRepresentation(result, 1.0)];
        
        [cell setThumbImage:[PhotoMoudleUtil thumbImageFormImage:image]];
        
    }];
    
    //是否已经选择
    [cell setIsSelected:([self.selectedArray indexOfObject:asset] != NSNotFound)];
    
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PHAsset *asset = [assets objectAtIndex:assets.count - indexPath.row - 1];
    NSInteger index = [self.selectedArray indexOfObject:asset];
    BOOL selected = NO;
    if (index == NSNotFound) {
        if (self.selectedArray.count >= self.limitCount) {
            NSString* alertMessage = [NSString stringWithFormat:@"最多只能选择%ld张照片", self.limitCount];
            [self showAlertMessage:alertMessage];
            return;
        }
        [self.selectedArray addObject:asset];
        selected = YES;
    }
    else
    {
        [self.selectedArray removeObject:asset];
    }
    
    AssetsLibraryCollectionViewCell *cell = (AssetsLibraryCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setIsSelected:selected];
    
    NSString* totalString = [NSString stringWithFormat:@"已选%ld张／一共可选%ld张", self.selectedArray.count, self.limitCount];
    [self.submitLabel setText:totalString];
}

#pragma mark - CollectionFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(ScreenWidth/4 , ScreenWidth/4 );
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - button click event
- (void) submitButtonClicked:(id) sender
{
    if (!self.selectedArray || self.selectedArray.count == 0) {
        [self showAlertMessage:@"请选择照片"];
        return;
    }
    
    NSMutableArray* selectedImageModels = [NSMutableArray array];
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHImageRequestOptions* orioption = [[PHImageRequestOptions alloc] init];
    PHImageRequestOptions* thumboption = [[PHImageRequestOptions alloc] init];
    //设置显示模式
    /*
     PHImageRequestOptionsResizeModeNone    //选了这个就不会管传如的size了 ，要自己控制图片的大小，建议还是选Fast
     PHImageRequestOptionsResizeModeFast    //根据传入的size，迅速加载大小相匹配(略大于或略小于)的图像
     PHImageRequestOptionsResizeModeExact    //精确的加载与传入size相匹配的图像
     */
    orioption.resizeMode = PHImageRequestOptionsResizeModeNone;
    orioption.synchronous = YES;
    orioption.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    thumboption.resizeMode = PHImageRequestOptionsResizeModeFast;
    thumboption.synchronous = YES;
    thumboption.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    [self.selectedArray enumerateObjectsUsingBlock:^(PHAsset * asset, NSUInteger idx, BOOL * _Nonnull stop) {
        AppendPhotoImageModel* photoModel = [[AppendPhotoImageModel alloc] init];
        //获取缩略图
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(500, 500) contentMode:PHImageContentModeAspectFit options:thumboption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            UIImage* thumbImage = [UIImage imageWithData:UIImageJPEGRepresentation(result, 1.0)];
            thumbImage = [PhotoMoudleUtil thumbImageFormImage:thumbImage];
            [photoModel setThumbImage:thumbImage];
            
        }];
        //获取原图
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(ScreenWidth, ScreenHeight) contentMode:PHImageContentModeAspectFit options:orioption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            UIImage* image = [UIImage imageWithData:UIImageJPEGRepresentation(result, 1.0)];
            
            [photoModel setPhotoImage:[PhotoMoudleUtil screenFitedImageFormImage:image]];
            NSLog(@"photoModel imageSize (%.2f, %.2f)", image.size.width, image.size.height);
            
        }];
        
        [selectedImageModels addObject:photoModel];
    }];
    
    //回调
    if (self.selectHandle) {
        self.selectHandle(selectedImageModels);
    }
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


@end
