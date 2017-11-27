//
//  AppendAlbumViewController.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/11/3.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "AppendAlbumViewController.h"
#import "AppendAlbumSelectedPhotosViewController.h"

@interface AppendAlbumTitleControl : UIControl
<UITextFieldDelegate>

@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UITextField* titleTextField;


@end


@implementation AppendAlbumTitleControl

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self showBottomLine];
        [self layoutElements];
    }
    return self;
}

- (void) layoutElements{
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(12.5);
    }];
    
    [self.titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.greaterThanOrEqualTo(@120);
        make.height.mas_equalTo(@32);
        make.left.equalTo(self.nameLabel.mas_right).offset(10);
        make.right.equalTo(self).offset(-12.5);
    
    }];
}

#pragma mark - settingAndGetting
- (UILabel*) nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        [self addSubview:_nameLabel];
        
        [_nameLabel setText:@"相册标题:"];
        [_nameLabel setFont:[UIFont systemFontOfSize:15]];
        [_nameLabel setTextColor:[UIColor commonTextColor]];
    }
    return _nameLabel;
}

- (UITextField*) titleTextField
{
    if (!_titleTextField) {
        _titleTextField = [[UITextField alloc] init];
        [self addSubview:_titleTextField];
        
        [_titleTextField setPlaceholder:@"请输入相册标题"];
        [_titleTextField setFont:[UIFont systemFontOfSize:15]];
        [_titleTextField setTextColor:[UIColor commonTextColor]];
        
        _titleTextField.returnKeyType = UIReturnKeyDone;
        [_titleTextField setDelegate:self];
    }
    return _titleTextField;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_titleTextField resignFirstResponder];
    return YES;
}

@end

@interface AppendAlbumViewController ()

@property (nonatomic, strong) AppendAlbumTitleControl* titleControl;
@property (nonatomic, strong) UIView* bottomView;
@property (nonatomic, strong) UIButton* commitButton;
@property (nonatomic, strong) AppendAlbumSelectedPhotosViewController* selectedViewController;
@end

@implementation AppendAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"新增相册";
    
    [self layoutElements];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) layoutElements{
    [self.titleControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(14);
        make.height.mas_equalTo(@49);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(@49);
    }];
    
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView).insets(UIEdgeInsetsMake(4, 20, 5, 20));
    }];
    
    [self.selectedViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.titleControl.mas_bottom);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
}

- (void) appendAlbumClicked:(id) sender{
    
}

#pragma mark - settingAndGetting
- (AppendAlbumTitleControl*) titleControl{
    if (!_titleControl) {
        _titleControl = [[AppendAlbumTitleControl alloc] init];
        [self.view addSubview:_titleControl];
    }
    return _titleControl;
}

- (UIView*) bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        [_bottomView setBackgroundColor:[UIColor commonBackgroundColor]];
        [_bottomView showBottomLine];
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}

- (UIButton*) commitButton{
    if (!_commitButton) {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bottomView addSubview:_commitButton];
        
        [_commitButton setBackgroundImage:[UIImage rectImage:CGSizeMake(320, 46) Color:[UIColor mainThemeColor]] forState:UIControlStateNormal];
        [_commitButton setTitle:@"创建相册" forState:UIControlStateNormal];
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        
        _commitButton.layer.cornerRadius = 5;
        _commitButton.layer.masksToBounds = YES;
        
        [_commitButton addTarget:self action:@selector(appendAlbumClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}

- (AppendAlbumSelectedPhotosViewController*) selectedViewController
{
    if (!_selectedViewController) {
        _selectedViewController = [[AppendAlbumSelectedPhotosViewController alloc] init];
        [self addChildViewController:_selectedViewController];
        [self.view addSubview:_selectedViewController.view];
    }
    return _selectedViewController;
}

@end
