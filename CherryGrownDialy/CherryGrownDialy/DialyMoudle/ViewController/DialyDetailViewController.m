//
//  DialyDetailViewController.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/10.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "DialyDetailViewController.h"

@interface DialyDetailViewController ()

@property (nonatomic, readonly) NSInteger dialyId;

@property (nonatomic, strong) DialyModel* dialyDetail;

@property (nonatomic, strong) UILabel* createTimeLabel;
@property (nonatomic, strong) UILabel* createUserLabel;

@property (nonatomic, strong) UITextView* detailTextView;
@end

@implementation DialyDetailViewController

- (id) initWithDialyId:(NSInteger) id
{
    self = [super initWithNibName:nil bundle:nil];
    if(self){
        _dialyId = id;
    }
    return self;
}

- (NSDictionary*) controllerParamDictionary
{
    NSMutableDictionary* paramDictionary = [NSMutableDictionary dictionary];
    [paramDictionary setValue:[NSNumber numberWithInteger:self.dialyId] forKey:@"dialyId"];
    
    return paramDictionary;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"详情";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self layoutElements];
    
//    [self makeTestDialyData];
    [self loadDialyModel];
}

- (void) loadDialyModel{
    [self showWaitingHub];
    [DialyMoudleUtil startGetDialyDetail:self.dialyId observiceObject:self resultSelector:@selector(dialyDetailLoaded:) returnSelector:@selector(dialyDetailReturn:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) layoutElements{
    [self.createUserLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(17.5);
    }];
    
    [self.createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.createUserLabel);
    }];
    
    [self.detailTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.createTimeLabel.mas_bottom).offset(25);
        make.width.equalTo(self.view).offset(-20);
        make.bottom.equalTo(self.view).offset(-15);
    }];
}

- (void) dialyDetailLoaded:(DialyModel*) model{
    _dialyDetail = model;
    
    [self.createTimeLabel setText:self.dialyDetail.createTime];
    [self.createUserLabel setText:self.dialyDetail.createUserName];
    
//    [self.detailTextView setText:model.content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 6;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    self.detailTextView.attributedText = [[NSAttributedString alloc] initWithString:model.content attributes:attributes];
}

- (void) dialyDetailReturn:(JYJKRequestRetModel*) retModel{
    [self closeWaitingHub];
    if (retModel.errorCode != Error_None) {
        [self showAlertMessage:retModel.errorMessage];
        return;
    }
}

#if 0
- (void) makeTestDialyData{
    DialyModel* model = [[DialyModel alloc] init];
    model.id = self.dialyId;
    model.createUserName = @"殷全";
    model.createTime = @"2017-10-05";
    model.content = @"阿斯顿福克斯的饭卡上；大家阿斯顿开发速度加快水淀粉；卡卷上的撒地方看见啊煞风景啊；阿斯顿卡洛斯发动机阿斯顿发快乐的。\n阿斯顿肌肤 i 阿萨德驾驶的感觉爱上的感觉啊说\n啊水平的风景啊死的感觉阿斯感觉阿斯阿克苏多久啊丝迦德国 i 啊丝迦的；阿斯顿发集散地发觉死的发生是的风景啊死的风景啊\n阿斯顿发哈撒地方哈山东发生地方是的飞机上的就发生地方";
    model.cateId = 3;
    model.cateName = @"学习教育";
    model.tags = @"快乐,成长,学习";
 
    [self dialyDetailLoaded:model];
}
#endif

#pragma mark - settingAndGetting

- (UILabel*) createTimeLabel
{
    if (!_createTimeLabel) {
        _createTimeLabel = [[UILabel alloc] init];
        [self.view addSubview:_createTimeLabel];
        
        [_createTimeLabel setFont:[UIFont systemFontOfSize:11]];
        [_createTimeLabel setTextColor:[UIColor commonGrayTextColor]];
    }
    return _createTimeLabel;
}

- (UILabel*) createUserLabel{
    if(!_createUserLabel){
        _createUserLabel = [[UILabel alloc] init];
        [self.view addSubview:_createUserLabel];
        [_createUserLabel setFont:[UIFont systemFontOfSize:11]];
        [_createUserLabel setTextColor:[UIColor commonGrayTextColor]];
    }
    return _createUserLabel;
}

- (UITextView*) detailTextView
{
    if (!_detailTextView) {
        _detailTextView = [[UITextView alloc] init];
        [self.view addSubview:_detailTextView];
        
        [_detailTextView setTextColor:[UIColor commonTextColor]];
        [_detailTextView setFont:[UIFont systemFontOfSize:15]];
        [_detailTextView setEditable:NO];
    }
    return _detailTextView;
}
@end
