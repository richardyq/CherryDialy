//
//  PhotoStartViewController.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/7.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "PhotoStartViewController.h"
#import "PhotoTableViewCell.h"

@interface PhotoStartViewController ()
<UITableViewDelegate,
UITableViewDataSource,
PhotoControlSelectDelegate>

@property (nonatomic, strong) CategorySelectedControl* categoryControl;
@property (nonatomic, readonly) CategoryModel* categoryModel;

@property (nonatomic, strong) TagSelectedControl* tagControl;
@property (nonatomic, strong) NSMutableArray* selectedTagModels;

@property (nonatomic, strong) UITableView* photoTableView;

@property (nonatomic, strong) NSMutableArray* photoModels;
@end

@implementation PhotoStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"照片";
    
    [self layoutElements];
    
    [self makeTestPhotoData];
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
    
    [self.photoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.tagControl.mas_bottom);
    }];
}

- (void) makeTestPhotoData{
    NSMutableArray* models = [NSMutableArray array];
    for (NSInteger index = 0; index < 35; ++index)
    {
        PhotoInfoModel* model = [[PhotoInfoModel alloc] init];
        model.thumbUrl = @"http://oeimg2.cache.oeeee.com/201308/13/5209874b7de8c.jpg";
        model.imageUrl = @"http://oeimg2.cache.oeeee.com/201308/13/5209874b7de8c.jpg";
        model.id = index + 0x230;
        [models addObject:model];
    }
    _photoModels = [NSMutableArray arrayWithArray:models];
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
    if (self.photoModels) {
        NSInteger rows = self.photoModels.count / 4;
        if ((self.photoModels.count % 4) > 0) {
            rows += 1;
        }
        return rows;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoTableViewCell"];
    if (!cell) {
        cell = [[PhotoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PhotoTableViewCell"];
    }
    // Configure the cell...
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSInteger startIndex = indexPath.row * 4;
    NSInteger length = 4;
    if (startIndex + length > self.photoModels.count) {
        length = self.photoModels.count - startIndex;
    }
    NSRange subRange = NSMakeRange(startIndex, length);
    
    NSArray* photos = [self.photoModels subarrayWithRange:subRange];
    [cell setPhotoInfos:photos];
    [cell setCellRow:indexPath.row];
    [cell setSelectDelegate:self];
    return cell;
}

#pragma mark - UITableView Delegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenWidth/4;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
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

- (UITableView*) photoTableView
{
    if (!_photoTableView) {
        _photoTableView = [[UITableView alloc] init];
        [self.view addSubview:_photoTableView];
        
        [_photoTableView setBackgroundColor:[UIColor whiteColor]];
        
        [_photoTableView setDelegate:self];
        [_photoTableView setDataSource:self];
    }
    return _photoTableView;
}

#pragma mark - PhotoControlSelectDelegate
- (void) photoControlSelect:(NSInteger) selectIndex{
    [PhotoViewControllerManager entryPhotoDetailPage:self.photoModels currentIndex:selectIndex];
}
@end
