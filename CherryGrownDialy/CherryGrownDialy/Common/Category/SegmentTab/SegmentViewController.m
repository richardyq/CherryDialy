//
//  SegmentViewController.m
//  SegmentDemo
//
//  Created by yinquan on 17/2/14.
//  Copyright © 2017年 yinquan. All rights reserved.
//

#import "SegmentViewController.h"
#import "UIColor+Segment.h"

@interface SegmentViewController ()
{
    UITabBarController* tabbarController;
//    NSArray* viewControllers;
}
@end

@implementation SegmentViewController

@synthesize segmentBar = _segmentBar;
@synthesize viewControllers = _viewControllers;

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _segmentBarHeight = 47;
        
        tabbarController = [[UITabBarController alloc] init];
        [self addChildViewController:tabbarController];
        [tabbarController.tabBar setHidden:YES];
        
        _segmentBar = [[SegmentBar alloc] init];
    }
    return self;
}

- (void)dealloc
{
    if (self.segmentBar)
    {
        [self.segmentBar removeObserver:self forKeyPath:@"selectedIndex"];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:tabbarController.view];
    [self.view addSubview:self.segmentBar];
    
    [self.segmentBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo([NSNumber numberWithFloat:self.segmentBarHeight]);
    }];
    
    
    
    [tabbarController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.segmentBar.mas_bottom);
    }];
    
    if (self.viewControllers) {
        [self.tabBarController setViewControllers:self.viewControllers];
    }
    [self initSegmentBarTitles];
    
    [self.segmentBar addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setHighlightColor:(UIColor*) aHighlightColor
{
    [self.segmentBar setHighlightColor:aHighlightColor];
}

- (void) setViewControllers:(NSArray<__kindof UIViewController *> *)aViewControllers
{
//    _selectedIndex = 0;
    _viewControllers = aViewControllers;
    [tabbarController setViewControllers:_viewControllers];
    
    [self initSegmentBarTitles];
}

- (void) setSegmentBarHeight:(CGFloat)segmentBarHeight
{
    _segmentBarHeight = segmentBarHeight;
    if (self.segmentBar)
    {
        [self.segmentBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo([NSNumber numberWithFloat:_segmentBarHeight]);
        }];
    }
}

- (void) initSegmentBarTitles
{
    if (!self.viewControllers) {
        return;
    }
    __block NSMutableArray* controllerTitls = [NSMutableArray array];
    [_viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull controller, NSUInteger idx, BOOL * _Nonnull stop) {
        [controllerTitls addObject:controller.title];
    }];
    
    if (self.segmentBar) {
        [self.segmentBar createCells:controllerTitls];
        
        [self.segmentBar setSelectedIndex:self.selectedIndex];
    }
}

- (void) setSegmentTitle:(NSString*) title atIndex:(NSInteger) index
{
    if (!title || title.length == 0) {
        return;
    }
    if (self.segmentBar) {
        [self.segmentBar setSegmentTitle:title atIndex:index];
    }
}

- (NSInteger) selectedIndex
{
    if (tabbarController) {
        return tabbarController.selectedIndex;
    }
    
    return 0;
}

- (void) setSelectedIndex:(NSInteger)selectedIndex
{
    [tabbarController setSelectedIndex:selectedIndex];
    [self.segmentBar setSelectedIndex:selectedIndex];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"selectedIndex"])
    {
        
        NSNumber* numIndex =  [object valueForKey:keyPath];;
        if (![numIndex isKindOfClass:[NSNumber class]]) {
            return;
        }
        
        if (object == self.segmentBar) {
            
            [tabbarController setSelectedIndex:numIndex.integerValue];
        }
        
    }
}
@end
