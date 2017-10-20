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





@interface AssetsLibrarySelectViewController ()
<UICollectionViewDelegate, UICollectionViewDataSource>
{
    PHFetchResult *assets;
    PHImageRequestOptions *option;
}

@property (nonatomic, assign) NSInteger limitCount;
@property (nonatomic,strong) NSMutableArray *photoArray;
@property (nonatomic, strong) NSMutableArray* selectedArray;


@end

@implementation AssetsLibrarySelectViewController

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

- (void) loadView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    // 自定义的布局对象
    
    UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds  collectionViewLayout:flowLayout];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[AssetsLibraryCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([AssetsLibraryCollectionViewCell class])];
    [self setView:collectionView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"选择照片";
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
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
    
    UICollectionView* collectionView = (UICollectionView*) self.view;
    [collectionView reloadData];

    
   
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
    PHAsset *asset = [assets objectAtIndex:indexPath.row];
    
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(250, 250) contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        UIImage* image = [UIImage imageWithData:UIImageJPEGRepresentation(result, 1.0)];
        [cell setThumbImage:image];
        
    }];
    
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PHAsset *asset = [assets objectAtIndex:indexPath.row];
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



@end
