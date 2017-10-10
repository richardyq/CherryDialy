//
//  DialyStartViewController.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/7.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "DialyStartViewController.h"
#import "DialyInfoTableViewCell.h"

@interface DialyStartViewController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) CategorySelectedControl* categoryControl;
@property (nonatomic, readonly) CategoryModel* categoryModel;

@property (nonatomic, strong) TagSelectedControl* tagControl;
@property (nonatomic, strong) NSMutableArray* selectedTagModels;

@property (nonatomic, strong) UITableView* dialyTableView;

@property (nonatomic, strong) NSMutableArray* dialyModels;
@end

@implementation DialyStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"日记";
    
    UIBarButtonItem* appendBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(appendDialyButtonClicked:)];
    [self.navigationItem setRightBarButtonItem:appendBarButton];
    
    [self layoutElements];
    
    [self makeTestDialyData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void) makeTestDialyData{
    NSMutableArray* models = [NSMutableArray array];
    for (NSInteger index = 0; index < 15; ++index)
    {
        DialyModel* model = [[DialyModel alloc] init];
        model.id = index + 20;
        model.createUserName = @"殷全";
        model.createTime = @"2017-10-05";
        model.content = @"阿斯顿福克斯的饭卡上；大家阿斯顿开发速度加快水淀粉；卡卷上的撒地方看见啊煞风景啊；";
        model.cateId = 3;
        model.cateName = @"学习教育";
        model.tags = @"快乐,成长,学习";
        [models addObject:model];
    }
    _dialyModels = [NSMutableArray arrayWithArray:models];
}

- (void) appendDialyButtonClicked:(id) sender{
    [DialyViewControllerManager entryDialyInputPage];
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
    
    [self.dialyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.tagControl.mas_bottom);
    }];
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

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    if (self.dialyModels) {
        return self.dialyModels.count;
    }
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 97;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DialyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DialyInfoTableViewCell"];
    if (!cell) {
        cell = [[DialyInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DialyInfoTableViewCell"];
    }
    // Configure the cell...
    
    DialyModel* model = self.dialyModels[indexPath.row];
    [cell setDialyModel:model];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
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

- (UITableView*) dialyTableView
{
    if (!_dialyTableView) {
        _dialyTableView = [[UITableView alloc] init];
        [self.view addSubview:_dialyTableView];
        
        [_dialyTableView setBackgroundColor:[UIColor commonBackgroundColor]];
        
        [_dialyTableView setDelegate:self];
        [_dialyTableView setDataSource:self];
    }
    return _dialyTableView;
}
@end
