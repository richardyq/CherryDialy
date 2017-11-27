//
//  AppendPhotoStartViewController.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/20.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "AppendPhotoStartViewController.h"
#import "AppendPhotoListViewController.h"

@interface AppendPhotoStartViewController ()

@property (nonatomic, strong) CategorySelectedControl* categoryControl;
@property (nonatomic, readonly) CategoryModel* categoryModel;

@property (nonatomic, strong) TagSelectedControl* tagControl;
@property (nonatomic, strong) NSMutableArray* selectedTagModels;

@property (nonatomic, strong) AppendPhotoListViewController* photosViewController;

@property (nonatomic, strong) UIView* submitView;
@property (nonatomic, strong) UIButton* submitButton;

@end

@implementation AppendPhotoStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.title = @"添加照片";
    [self layoutElements];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) layoutElements{
    [self.categoryControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(15);
        make.height.mas_equalTo(@55);
    }];
    
    [self.tagControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.categoryControl.mas_bottom);
        make.height.mas_equalTo(@55);
    }];
    
    [self.submitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(@64);
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.submitView).insets(UIEdgeInsetsMake(5, 20, 9, 20));
    }];
    
    [self.photosViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.tagControl.mas_bottom);
        make.bottom.equalTo(self.submitView.mas_top);
    }];
}

#pragma mark - settingAndGetting
- (CategorySelectedControl*) categoryControl
{
    if (!_categoryControl) {
        _categoryControl = [[CategorySelectedControl alloc] init];
        [self.view addSubview:_categoryControl];
        [_categoryControl addTarget:self action:@selector(categoryControlClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _categoryControl;
}

- (TagSelectedControl*) tagControl
{
    if (!_tagControl) {
        _tagControl = [[TagSelectedControl alloc] init];
        [self.view addSubview:_tagControl];
        [_tagControl addTarget:self action:@selector(tagsControlClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tagControl;
}

- (UIView*) submitView
{
    if (!_submitView) {
        _submitView = [[UIView alloc] init];
        [self.view addSubview:_submitView];
        
        [_submitView setBackgroundColor:[UIColor whiteColor]];
        [_submitView showTopLine];
    }
    return _submitView;
}

- (UIButton*) submitButton{
    if(!_submitButton){
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.submitView addSubview:_submitButton];
        
        [_submitButton setBackgroundImage:[UIImage rectImage:CGSizeMake(320, 46) Color:[UIColor mainThemeColor]] forState:UIControlStateNormal];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        
        _submitButton.layer.cornerRadius = 5;
        _submitButton.layer.masksToBounds = YES;
        
        [_submitButton addTarget:self action:@selector(appendButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

- (AppendPhotoListViewController*) photosViewController{
    if (!_photosViewController) {
        _photosViewController = [[AppendPhotoListViewController alloc] init];
        [self addChildViewController:_photosViewController];
        [self.view addSubview:_photosViewController.view];
    }
    return _photosViewController;
}

#pragma mark - control click event
- (void) categoryControlClicked:(id) sender
{
    [CategorySelectViewController showWithHandel:^(CategoryModel *model) {
        [self.categoryControl setCategoryModel:model];
        _categoryModel = model;
        
        //TODO:refresh tableview
    }];
}

- (void) tagsControlClicked:(id) sender
{
    __weak typeof(self) weakSelf = self;
    [TagsSelectViewController showWithSelectedTags:self.selectedTagModels selectHandle:^(TagModel *tagModel) {
        if (!weakSelf) {
            return ;
        }
        if (!weakSelf.selectedTagModels) {
            _selectedTagModels = [NSMutableArray array];
        }
        NSInteger index = [self.selectedTagModels indexOfObject:tagModel];
        if (index == NSNotFound) {
            [weakSelf.selectedTagModels addObject:tagModel];
        }
        else
        {
            [weakSelf.selectedTagModels removeObject:tagModel];
        }
        
        [weakSelf.tagControl setSelectTagModels:weakSelf.selectedTagModels];
        
        //TODO:refresh tableview
    }];
}

- (void) appendButtonClicked:(id) sender
{
    NSArray<AppendPhotoImageModel*>* photos = self.photosViewController.photoModels;
    if (!photos || photos.count == 0) {
        [self showAlertMessage:@"请选择照片"];
        return;
    }
    
    [self.photosViewController startUplodaPhotos:self.categoryModel tags:self.selectedTagModels];
}



@end
