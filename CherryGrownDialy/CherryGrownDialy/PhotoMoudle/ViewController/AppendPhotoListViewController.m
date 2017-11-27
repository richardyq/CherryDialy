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
<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSMutableArray<AppendPhotoControl*>* appendImageControls;
}

@end

@implementation AppendPhotoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appendImageControls = [NSMutableArray array];
    _photoModels = [NSMutableArray array];
    
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
    
    if (controlIndex == (self.photoModels.count + 1)) {
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
            UIImagePickerController * imagePickerVC = [[UIImagePickerController alloc] init];
            // 设置资源来源（
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            imagePickerVC.mediaTypes = @[(NSString *)kUTTypeImage];
            // 设置代理，遵守UINavigationControllerDelegate, UIImagePickerControllerDelegate 协议
            imagePickerVC.delegate = self;
            
            [self presentViewController:imagePickerVC animated:YES completion:nil];
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

    NSInteger count = kMaxPhotoCount - self.photoModels.count;
    [AssetsLibrarySelectViewController showWithLimitCount:count hanle:^(NSArray<AppendPhotoImageModel *> *models) {
        [self.photoModels addObjectsFromArray:models];
        //刷新
        [self refreshPhotoControls];
    }];
    
}

- (void) startUplodaPhotos:(CategoryModel*) categoryModel
                      tags:(NSArray<TagModel*>*) tagModels
{
    [self.photoModels enumerateObjectsUsingBlock:^(AppendPhotoImageModel * photoModel, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage* photoImage = photoModel.photoImage;
        NSData* imageData = UIImageJPEGRepresentation(photoImage, 1);
        NSLog(@"uploadImge ....");
        NSMutableDictionary* params = [NSMutableDictionary dictionary];
        [params setValue:@"imageService" forKey:@"service"];
        [params setValue:@"uploadPhoto" forKey:@"method"];
        if (categoryModel)
        {
            [params setValue:[NSString stringWithFormat:@"%ld", categoryModel.id] forKey:@"cateId"];
        }
        
        if (tagModels && tagModels.count > 0)
        {
            __block NSString* tags = nil;
            [tagModels enumerateObjectsUsingBlock:^(TagModel* tagModel, NSUInteger idx, BOOL * _Nonnull stop) {
                if (!tags || tags.length == 0) {
                    tags = [NSString stringWithFormat:@"%@", tagModel.name];
                }
                else
                {
                    tags = [tags stringByAppendingFormat:@",%@", tagModel.name];
                }
                
            }];
            if (tags && tags.length > 0) {
                [params setValue:tags forKey:tags];
            }
        }
        
        AppendPhotoControl* control = appendImageControls[idx];
        
        [PhotoMoudleUtil startUploadPhoto:params imageData:imageData observiceObject:control resultSelector:nil returnSelector:nil uploadProgressSelector:@selector(uploadPhotoProgress:)];
    }];
}

- (void) refreshPhotoControls{
    if(appendImageControls && appendImageControls.count > 0){
        [appendImageControls enumerateObjectsUsingBlock:^(AppendPhotoControl * control, NSUInteger idx, BOOL * _Nonnull stop) {
            [control removeFromSuperview];
        }];
        
        [appendImageControls removeAllObjects];
    }
    
    [self.photoModels enumerateObjectsUsingBlock:^(AppendPhotoImageModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        AppendPhotoControl* control = [[AppendPhotoControl alloc] init];
        [control setThumbImage:model.thumbImage];
        [self.view addSubview:control];
        [appendImageControls addObject:control];
        
    }];
    
    if (self.photoModels.count < kMaxPhotoCount) {
        AppendPhotoControl* appendControl = [[AppendPhotoControl alloc] init];
        [appendImageControls addObject:appendControl];
        [self.view addSubview:appendControl];
        [appendControl addTarget:self action:@selector(photoControlClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self layoutPhotoControls];
}

#pragma mark - UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    AppendPhotoImageModel* model = [[AppendPhotoImageModel alloc] init];
    [model setThumbImage:[PhotoMoudleUtil thumbImageFormImage:image]];
    [model setPhotoImage:[PhotoMoudleUtil screenFitedImageFormImage:image]];
    [self.photoModels addObject:model];
    //刷新
    [self refreshPhotoControls];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
