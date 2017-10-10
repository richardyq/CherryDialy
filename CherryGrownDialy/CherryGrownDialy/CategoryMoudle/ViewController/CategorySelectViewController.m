//
//  CategorySelectViewController.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/8.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "CategorySelectViewController.h"

@interface CategorySelectViewController ()
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) CategorySelectHandle selectHandle;
@property (nonatomic, strong) UITableView* categoryTableView;
@property (nonatomic, strong) NSMutableArray* categoryList;

@end

@implementation CategorySelectViewController

+ (void) showWithHandel:(CategorySelectHandle) handle{
    CategorySelectViewController* selectViewController = [[CategorySelectViewController alloc] initWithCategorySelectHandle:handle];
    UIViewController* topmostViewController = [[ViewControllerManager defaultManager] topMostViewController];
    [topmostViewController addChildViewController:selectViewController];
    [topmostViewController.view addSubview:selectViewController.view];
    [selectViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(topmostViewController.view);
    }];
}

- (id) initWithCategorySelectHandle:(CategorySelectHandle) handle{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _selectHandle = handle;
    }
    return self;
}

- (void) loadView
{
    UIControl* closeControl = [[UIControl alloc] init];
    [self setView:closeControl];
    [closeControl setBackgroundColor:[UIColor commonTranslucentColor]];
    [closeControl addTarget:self action:@selector(closeControlClicked) forControlEvents:UIControlEventAllTouchEvents];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self layoutElements];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) closeControlClicked{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void) layoutElements{
    
    CGFloat tableHeight = self.categoryList.count * 49;
    CGFloat maxTableHeight = ScreenHeight - 64 - 72;
    if (tableHeight > maxTableHeight) {
        tableHeight = maxTableHeight;
    }
    
    [self.categoryTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view).offset(-40);
        make.height.mas_equalTo([NSNumber numberWithFloat:tableHeight]);
    }];
}

#pragma mark - settingAndGetting
- (UITableView*) categoryTableView
{
    if (!_categoryTableView) {
        _categoryTableView = [[UITableView alloc] init];
        [self.view addSubview:_categoryTableView];
        [_categoryTableView setBackgroundColor:[UIColor whiteColor]];
        [_categoryTableView setDataSource:self];
        [_categoryTableView setDelegate:self];
    }
    return _categoryTableView;
}

- (NSMutableArray*) categoryList
{
    if (!_categoryList) {
        _categoryList = [NSMutableArray array];
        CategoryModel* allModel = [[CategoryModel alloc] init];
        [allModel setName:@"全部"];
        [_categoryList addObject:allModel];
        
        NSArray* list = [CommonDataHelper defaultManager].categoryList;
        [_categoryList addObjectsFromArray:list];
    }
    return _categoryList;
}

#pragma mark - UITableView data source
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.categoryList) {
        return self.categoryList.count;
    }
    return 0;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CategorySelectTableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CategorySelectTableViewCell"];
    }
    
    CategoryModel* model = self.categoryList[indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.textLabel setText:model.name];
    [cell.textLabel setTextColor:[UIColor commonTextColor]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
    
    return cell;
}

#pragma mark - UITableView Delegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryModel* model = self.categoryList[indexPath.row];
    if (self.selectHandle)
    {
        self.selectHandle(model);
    }
    
    [self closeControlClicked];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}

@end
