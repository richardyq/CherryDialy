//
//  TagsSelectViewController.m
//  CherryGrownDialy
//
//  Created by yinquan on 2017/10/9.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "TagsSelectViewController.h"
#import "SelectTagsView.h"

@interface TagsSelectViewController ()

@property (nonatomic, strong) TagSelectHandle selectHandle;
@property (nonatomic, strong) UIView* appendTagView;
@property (nonatomic, strong) UIButton* appendTagButton;
@property (nonatomic, strong) SelectTagsView* selectTagsView;

@property (nonatomic, strong) NSArray* tagModels;
@property (nonatomic, strong) NSMutableArray* selectedTagModels;

@end

@implementation TagsSelectViewController

+ (void) showWithSelectedTags:(NSArray*) selectedTags
                 selectHandle:(TagSelectHandle) handle{
    TagsSelectViewController* selectViewController = [[TagsSelectViewController alloc] initWithSelectHandle:handle];
    [selectViewController setSelectedTags:selectedTags];
    
    UIViewController* rootViewCotroller = [CommonUtil rootWindow].rootViewController;
//    UIViewController* topmostViewController = [[ViewControllerManager defaultManager] topMostViewController];
    
    [rootViewCotroller addChildViewController:selectViewController];
    [rootViewCotroller.view addSubview:selectViewController.view];
    [selectViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(rootViewCotroller.view);
    }];
}

- (id) initWithSelectHandle:(TagSelectHandle) handle{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        [self setSelectHandle:handle];
        
        _tagModels = [CommonDataHelper defaultManager].tagsList;
        if (!_tagModels)
        {
            //构造测试数据
            [self makeTestModels];
        }
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
    
    [self.selectTagsView setTagModels:self.tagModels selectedTagModels:self.selectedTagModels];
}


- (void) makeTestModels{
    NSArray* tagNames = @[@"和爸爸一起", @"和妈妈一起", @"乖乖地吃饭", @"大哭大闹", @"调皮捣蛋", @"认真学习", @"愉快的玩耍", @"和小伙伴分享"];
    NSMutableArray* tagModels = [NSMutableArray array];
    [tagNames enumerateObjectsUsingBlock:^(NSString* name, NSUInteger idx, BOOL * _Nonnull stop) {
        TagModel* model = [[TagModel alloc] init];
        [model setName:name];
        [model setId:idx + 1];
        [tagModels addObject:model];
    }];
    [[CommonDataHelper defaultManager] setTagsList:tagModels];
    self.tagModels = [NSArray arrayWithArray:tagModels];

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
    [self.appendTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(@64);
    }];
    
    [self.appendTagButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.appendTagView);
        make.width.equalTo(self.appendTagView).offset(-45);
        make.height.mas_equalTo(@45);
    }];
    
    [self.selectTagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.appendTagView.mas_top);
        make.height.mas_equalTo(@236);
    }];
}

- (void) setSelectedTags:(NSArray *)selectedTags
{
    _selectedTagModels = [NSMutableArray array];
    
    [self.tagModels enumerateObjectsUsingBlock:^(TagModel* model, NSUInteger idx, BOOL * _Nonnull stop) {
        __block BOOL isExisted = NO;
        [selectedTags enumerateObjectsUsingBlock:^(TagModel* selectedModel, NSUInteger idx, BOOL * _Nonnull selectedstop) {
            if (selectedModel.id == model.id)
            {
                isExisted = YES;
                *selectedstop = YES;
            }
        }];
        if (isExisted) {
            [self.selectedTagModels addObject:model];
        }
        
        
    }];
}

#pragma mark settingAndGetting
- (UIView*) appendTagView
{
    if (!_appendTagView) {
        _appendTagView = [[UIView alloc] init];
        [self.view addSubview:_appendTagView];
        [_appendTagView setBackgroundColor:[UIColor whiteColor]];
        [_appendTagView showTopLine];
    }
    return _appendTagView;
}

- (UIButton*) appendTagButton
{
    if (!_appendTagButton) {
        _appendTagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.appendTagView addSubview:_appendTagButton];
        [_appendTagButton setBackgroundImage:[UIImage rectImage:CGSizeMake(300, 45) Color:[UIColor mainThemeColor]] forState:UIControlStateNormal];
        
        _appendTagButton.layer.cornerRadius = 5;
        _appendTagButton.layer.masksToBounds = YES;
        
        [_appendTagButton setTitle:@"添加标签" forState:UIControlStateNormal];
        [_appendTagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_appendTagButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    }
    return _appendTagButton;
}

- (SelectTagsView*) selectTagsView{
    if (!_selectTagsView)
    {
        __weak typeof(self) weakSelf = self;
        _selectTagsView = [[SelectTagsView alloc] initWithSelectHandle:^(UIControl *cell, NSInteger index) {
            if (!weakSelf) {
                return ;
            }
            TagModel* model = weakSelf.tagModels[index];
            if (!cell.selected)
            {
                if (weakSelf.selectedTagModels.count >= 4) {
                    [weakSelf showAlertMessage:@"最多只能选择4个标签。"];
                    return;
                }
                [weakSelf.selectedTagModels addObject:model];
                [cell setSelected:YES];
            }
            else
            {
                [weakSelf.selectedTagModels removeObject:model];
                [cell setSelected:NO];
            }
            
            if (self.selectHandle) {
                self.selectHandle(model);
            }
                
        }];
        [self.view addSubview:_selectTagsView];
    }
    return _selectTagsView;
}

@end
