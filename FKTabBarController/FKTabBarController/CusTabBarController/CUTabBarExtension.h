//
//  CUTabBarExtension.h
//  FKTabBarController
//
//  Created by 你懂得的神 on 16/1/28.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CUTabBarExtension;

@protocol CUTabBarExtensionDelegate <NSObject>

//当点击Item时响应的方法
- (void)cu_tabBar:(CUTabBarExtension *_Nonnull)tabBar didSelectItem:(NSInteger)index;

@end

@interface CUTabBarExtension : UIView

@property(nullable,nonatomic,assign) id<CUTabBarExtensionDelegate> delegate;     // weak reference. default is nil

@property(nullable,nonatomic,copy) NSArray<UITabBarItem *> *items;        // get/set visible UITabBarItems. default is nil. changes not animated. shown in order

// 设置个性化中间按钮
@property (nonatomic,weak) UIButton *centerButton;

// 取消动画
@property (nonatomic,assign) BOOL cancelAnimation;

/**
 *  设置设置TabBar标题颜色
 *
 *  @param norTitleColor 标题颜色
 *  @param selTitleColor 标题选中颜色
 */
- (void)cu_setTabBarItemTitleColor:(UIColor * _Nonnull)norTitleColor andSelTitleColor:(UIColor * _Nonnull)selTitleColor;


/**
 *  设置高亮背景图片
 *
 *  @param backgroundImage 高亮背景图片
 */
- (void)cu_setShadeItemBackgroundImage:(UIImage * _Nonnull)backgroundImage;


/**
 *  设置高亮背景颜色
 *
 *  @param coloer 高亮背景颜色
 */
- (void)cu_setShadeItemBackgroundColor:(UIColor * _Nonnull)coloer;

@end
