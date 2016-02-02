# FKTabBarController
分类导航控制器、自定义UITabBarController

测试环境：Xcode 7 iOS9

自定义TabBar，实现点击按钮实现动画效果（放大后缩小再还原）
效果还不错欢迎大家点赞，谢谢

 ![image](https://github.com/fanwenkai/FKTabBarController/1.png)
 ![image](https://github.com/fanwenkai/FKTabBarController/2.png)
 ![image](https://github.com/fanwenkai/FKTabBarController/3.png)
    
    /** 添加子控制器 */
    UIViewController *hallVC = [[FirstViewController alloc] init];
    [self tabBarChildViewController:hallVC norImage:[UIImage imageNamed:@"tabBar_essence_icon"] selImage:[UIImage imageNamed:@"tabBar_essence_click_icon"] title:@"essence"];
    
    UIViewController *arenaVC = [[SecondViewController alloc] init];
    [self tabBarChildViewController:arenaVC norImage:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"] title:@"friend"];
    
    UIViewController *discoverVC = [[ThreeViewController alloc] init];
    [self tabBarChildViewController:discoverVC norImage:[UIImage imageNamed:@"tabBar_me_icon"] selImage:[UIImage imageNamed:@"tabBar_me_click_icon"] title:@"me"];
    
    UIViewController *historyVC = [[FourViewController alloc] init];
    [self tabBarChildViewController:historyVC norImage:[UIImage imageNamed:@"tabBar_new_icon"] selImage:[UIImage imageNamed:@"tabBar_new_click_icon"] title:@"new"];
    
    
     /** 创建自定义tabbar */
    CUTabBarExtension *tabBar = [[CUTabBarExtension alloc] init];
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.frame = self.tabBar.bounds;
    //一定要在tabBar.items = self.itemArray;前面设置
    [tabBar cu_setTabBarItemTitleColor:[UIColor blackColor] andSelTitleColor:[UIColor grayColor]];
    /** 传递模型数组 */
    tabBar.items = self.itemArray;
    [tabBar cu_setShadeItemBackgroundColor:[UIColor cyanColor]];
    
    
    // 设置中间按钮
    [tabBar.centerButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [tabBar.centerButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];

    [tabBar.centerButton addTarget:self action:@selector(chickCenterButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tabBar addSubview:tabBar];
    
    
