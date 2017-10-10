//
//  DialyInputViewController.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/8.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "DialyInputViewController.h"

@interface DialyInputViewController ()

@property (nonatomic, strong) CategorySelectedControl* categoryControl;
@property (nonatomic, readonly) CategoryModel* categoryModel;

@property (nonatomic, strong) TagSelectedControl* tagControl;
@property (nonatomic, strong) NSMutableArray* selectedTagModels;

@property (nonatomic, strong) UITextView* dialyTextView;

@end

@implementation DialyInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"新增日记";
    [self.view setBackgroundColor:[UIColor commonBackgroundColor]];
    
    UIBarButtonItem* commitBarButton = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(commitBarButtonClicked:)];
    [self.navigationItem setRightBarButtonItem:commitBarButton];
    _selectedTagModels = [NSMutableArray array];
    
    [self layoutElements];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) commitBarButtonClicked:(id) sender
{
    NSString* content = self.dialyTextView.text;
    if (!content || content.length < 10)
    {
        [self showAlertMessage:@"最少输入10个字。"];
        return;
    }
    
    NSInteger cateId = 0;
    if (self.categoryModel) {
        cateId = self.categoryModel.id;
    }
    
    NSString* tags = nil;
    
    [self showWaitingHub:@"正在提交日记数据。。。"];
    [DialyMoudleUtil startAppendDialy:content cateId:cateId tags:tags observiceObject:self resultSelector:nil returnSelector:@selector(appendDialyReturn:)];
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
    
    [self.dialyTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view).offset(-25);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.tagControl.mas_bottom).offset(10);
        make.bottom.equalTo(self.view).offset(-274);
        
//        make.height.mas_equalTo([NSNumber numberWithFloat:(ScreenHeight - 64 - 274)]);
    }];
}

- (void) categoryControlClicked:(id) sender
{
    [CategorySelectViewController showWithHandel:^(CategoryModel *model) {
        [self.categoryControl setCategoryModel:model];
        _categoryModel = model;
    }];
}

- (void) tagsControlClicked:(id) sender
{
    __weak typeof(self) weakSelf = self;
    [TagsSelectViewController showWithSelectedTags:self.selectedTagModels selectHandle:^(TagModel *tagModel) {
        if (!weakSelf) {
            return ;
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

- (UITextView*) dialyTextView
{
    if (!_dialyTextView) {
        _dialyTextView = [[UITextView alloc] init];
        [self.view addSubview:_dialyTextView];
        
        _dialyTextView.layer.borderWidth = 1;
        _dialyTextView.layer.borderColor = [UIColor commonControlBorderColor].CGColor;
        _dialyTextView.layer.cornerRadius = 5;
        _dialyTextView.layer.masksToBounds = YES;
        
        [_dialyTextView setTextColor:[UIColor commonTextColor]];
        [_dialyTextView setFont:[UIFont systemFontOfSize:15]];
    }
    return _dialyTextView;
}

#pragma mark - Request Callback
- (void) appendDialyReturn:(JYJKRequestRetModel*) retModel
{
    [self closeWaitingHub];
    if (retModel.errorCode != Error_None) {
        [self showAlertMessage:retModel.errorMessage];
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
