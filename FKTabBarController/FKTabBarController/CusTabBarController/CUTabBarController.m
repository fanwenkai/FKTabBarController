//
//  CUTabBarController.m
//  FKTabBarController
//
//  Created by 你懂得的神 on 16/1/28.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "CUTabBarController.h"
#import "CUTabBarExtension.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"

@interface CUTabBarController ()<CUTabBarExtensionDelegate>

/** 模型数组 */
@property (nonatomic, strong)NSMutableArray *itemArray;

@end

@implementation CUTabBarController

- (NSMutableArray *)itemArray
{
    if (_itemArray == nil) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 添加子控制器 */
    UIViewController *hallVC = [[FirstViewController alloc] init];
    [self tabBarChildViewController:hallVC norImage:[UIImage imageNamed:@"tabBar_essence_icon"] selImage:[UIImage imageNamed:@"tabBar_essence_click_icon"] title:@"essence"];
    
    UIViewController *arenaVC = [[SecondViewController alloc] init];
    [self tabBarChildViewController:arenaVC norImage:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"] title:@"friend"];
    
    UIViewController *discoverVC = [[ThreeViewController alloc] init];
    [self tabBarChildViewController:discoverVC norImage:[UIImage imageNamed:@"tabBar_me_icon"] selImage:[UIImage imageNamed:@"tabBar_me_click_icon"] title:@"me"];
    
    UIViewController *historyVC = [[FourViewController alloc] init];
    [self tabBarChildViewController:historyVC norImage:[UIImage imageNamed:@"tabBar_new_icon"] selImage:[UIImage imageNamed:@"tabBar_new_click_icon"] title:@"new"];
    
    /** 自定义tabbar */
    [self setTatBar];
}

- (void)setTatBar
{
    /** 创建自定义tabbar */
    CUTabBarExtension *tabBar = [[CUTabBarExtension alloc] init];
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.frame = self.tabBar.bounds;
    //一定要在tabBar.items = self.itemArray;前面设置
    [tabBar cu_setTabBarItemTitleColor:[UIColor blackColor] andSelTitleColor:[UIColor grayColor]];
    /** 传递模型数组 */
    tabBar.items = self.itemArray;
    [tabBar cu_setShadeItemBackgroundColor:[UIColor cyanColor]];
    
    /** 设置代理 */
    tabBar.delegate = self;
    
    // 设置中间按钮
    [tabBar.centerButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [tabBar.centerButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];

    [tabBar.centerButton addTarget:self action:@selector(chickCenterButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tabBar addSubview:tabBar];
}

- (void)chickCenterButton
{
    NSLog(@"点击了中间按钮");
}

/** View激将显示时 */
- (void)viewWillAppear:(BOOL)animated
{   [super viewWillAppear:animated];
    for (UIView *childView in self.tabBar.subviews) {
        if (![childView isKindOfClass:[CUTabBarExtension class]]) {
            [childView removeFromSuperview];
        }
    }
}

- (void)tabBarChildViewController:(UIViewController *)vc norImage:(UIImage *)norImage selImage:(UIImage *)selImage title:(NSString *)title
{
    /** 创建导航控制器 */
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    /** 创建模型 */
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] init];
    tabBarItem.image = norImage;
    tabBarItem.title = title;
    tabBarItem.selectedImage = selImage;
    /** 添加到模型数组 */
    [self.itemArray addObject:tabBarItem];
    [self addChildViewController:nav];
}

/** 代理方法 */
- (void)cu_tabBar:(CUTabBarExtension *)tabBar didSelectItem:(NSInteger)index{
    self.selectedIndex = index;
}

@end
