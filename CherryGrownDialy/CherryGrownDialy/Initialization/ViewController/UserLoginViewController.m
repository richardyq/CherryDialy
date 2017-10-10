//
//  UserLoginViewController.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/6.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "UserLoginViewController.h"

@interface UserLoginViewController ()

@property (nonatomic, strong) UIImageView* logoImageView;
@property (nonatomic, strong) UIImageView* accountImageView;
@property (nonatomic, strong) UIImageView* passwordImageView;

@property (nonatomic, strong) UITextField* accountTextField;
@property (nonatomic, strong) UITextField* passwordTextField;

@property (nonatomic, strong) UIButton* loginButton;

@end

@implementation UserLoginViewController

+ (void) showWithBlock:(UserLoginBlock) block{
    UserLoginViewController* loginViewController = [[UserLoginViewController alloc] initWithNibName:nil bundle:nil];
    [loginViewController setBlock:block];
    
    UIViewController* topMostViewController = [[ViewControllerManager defaultManager] topMostViewController];
    [topMostViewController presentViewController:loginViewController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self layoutElements];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) layoutElements{
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(48, 48));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
    }];
    
    [self.accountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.top.equalTo(self.logoImageView.mas_bottom).offset(23);
    }];
    
    [self.passwordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.top.equalTo(self.accountImageView.mas_bottom).offset(27);
    }];
    
    [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.accountImageView);
        make.left.equalTo(self.accountImageView.mas_right).offset(12);
        make.right.equalTo(self.view).offset(-30);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.passwordImageView);
        make.left.equalTo(self.passwordImageView.mas_right).offset(12);
        make.right.equalTo(self.view).offset(-30);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(@45);
        make.width.equalTo(self.view).offset(-100);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(30);
    }];
}

#pragma mark - settingAndGeting
- (UIImageView*) logoImageView
{
    if (!_logoImageView)
    {
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo"] ];
        [self.view addSubview:_logoImageView];
    }
    return _logoImageView;
}

- (UIImageView*) accountImageView
{
    if (!_accountImageView) {
        _accountImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_account"]];
        [self.view addSubview:_accountImageView];
    }
    return _accountImageView;
}

- (UIImageView*) passwordImageView
{
    if (!_passwordImageView) {
        _passwordImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_password"]];
        [self.view addSubview:_passwordImageView];
    }
    return _passwordImageView;
}

- (UITextField*) accountTextField
{
    if (!_accountTextField)
    {
        _accountTextField = [[UITextField alloc] init];
        [self.view addSubview:_accountTextField];
        
        [_accountTextField showBottomLine];
        
        [_accountTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_accountTextField setPlaceholder:@"输入登录账号"];
        
        [_accountTextField setKeyboardType:UIKeyboardTypeASCIICapable];
        _accountTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    
    return _accountTextField;
}

- (UITextField*) passwordTextField
{
    if (!_passwordTextField)
    {
        _passwordTextField = [[UITextField alloc] init];
        [self.view addSubview:_passwordTextField];
        
        [_passwordTextField showBottomLine];
        
        [_passwordTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_passwordTextField setPlaceholder:@"输入登录密码"];
        
        [_passwordTextField setSecureTextEntry:YES];
    }
    
    return _passwordTextField;
}

- (UIButton*) loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_loginButton];
        
        [_loginButton setBackgroundImage:[UIImage rectImage:CGSizeMake(350, 49) Color:[UIColor mainThemeColor]] forState:UIControlStateNormal];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
        
        _loginButton.layer.cornerRadius = 5;
        _loginButton.layer.masksToBounds = YES;
        [_loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}


#pragma mark - button event
- (void) loginButtonClicked:(id) sender
{
    [self closeKeyBoard];
    
    NSDictionary* requestParams = [self makeLoginRequestParams];
    if (!requestParams) {
        return;
    }
    
    //调用接口，获取登录信息
    [self showWaitingHub:@"正在登录。。。"];
    
//    [paramDictionary setValue:loginAccount forKey:@"loginAccount"];
//    [paramDictionary setValue:loginPassword forKey:@"loginPassword"];
    NSString* loginAccount = [requestParams valueForKey:@"loginAccount"];
    NSString* loginPassword = [requestParams valueForKey:@"loginPassword"];
    
    [UserMoudleUtil startUserLogin:loginAccount Password:loginPassword observiceObject:self resultSelector:nil returnSelector:@selector(staffLoginReturn:)];
}

- (NSDictionary*) makeLoginRequestParams{
    NSMutableDictionary* paramDictionary = nil;
    
    NSString* loginAccount = self.accountTextField.text;
    NSString* loginPassword = self.passwordTextField.text;
    
    if (!loginAccount || loginAccount.length == 0) {
        [self showAlertMessage:@"用户的登录名不能空。"];
        return paramDictionary;
    }
    
    if (!loginPassword || loginPassword.length == 0) {
        [self showAlertMessage:@"用户的登录密码不能空。"];
        return paramDictionary;
    }
    
    if (loginAccount.length < 6 || loginAccount.length > 20) {
        [self showAlertMessage:@"请输入6-20位的登录名。"];
        return paramDictionary;
    }
    
    if (loginPassword.length < 6 || loginPassword.length > 20) {
        [self showAlertMessage:@"请输入6-20位的登录密码。"];
        return paramDictionary;
    }
    
    paramDictionary = [NSMutableDictionary dictionary];
    [paramDictionary setValue:loginAccount forKey:@"loginAccount"];
    [paramDictionary setValue:loginPassword forKey:@"loginPassword"];
    return paramDictionary;
}

- (void) closeKeyBoard{
    NSArray* subviews = self.view.subviews;
    [subviews enumerateObjectsUsingBlock:^(UIView* subview, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([subview isKindOfClass:[UITextField class]]) {
            UITextField* textfield = (UITextField*)subview;
            [textfield resignFirstResponder];
        }
    }];
}

#pragma mark - Request Callback
- (void) staffLoginReturn:(JYJKRequestRetModel*) model
{
    [self.view closeWaitingHub];
    if (model.errorCode != Error_None) {
        //登录失败
        [self showAlertMessage:model.errorMessage];
        return;
    }
    
    if (self.block) {
        self.block();
    }
    
    //登录成功
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
