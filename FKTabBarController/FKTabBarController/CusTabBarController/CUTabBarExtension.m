//
//  CUTabBarExtension.m
//  FKTabBarController
//
//  Created by 你懂得的神 on 16/1/28.
//  Copyright © 2016年 wenkai. All rights reserved.
//

#import "CUTabBarExtension.h"
#import "CUButton.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width

#define btnW  (_centerButton.currentImage || _centerButton.currentBackgroundImage ? (kScreenW/(self.items.count + 1)): (kScreenW/self.items.count))

static CGFloat const btnH = 49;

@interface CUTabBarExtension ()

@property (nonatomic,weak) UIButton *seletBtn;
@property (nonatomic,weak) UIButton *shadeItem;

@property(nonatomic, strong) UIColor *norTitleColor;
@property(nonatomic, strong) UIColor *selTitleColor;

@end

@implementation CUTabBarExtension

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 设置高亮背景
        UIButton *shadeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:shadeItem];
        _shadeItem = shadeItem;
        
        // 设置个性化中间按钮
        UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:centerButton];
        _centerButton = centerButton;
    }
    return self;
}

- (void)setItems:(NSArray<UITabBarItem *> *)items
{
    _items = items;
    
    /** 添加item */
    [items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull tabBarItem, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CUButton *item = [CUButton buttonWithType:UIButtonTypeCustom];
        
        item.tag = idx;
        
        [item setImage:tabBarItem.image forState:UIControlStateNormal];
        [item setImage:tabBarItem.selectedImage forState:UIControlStateSelected];
        [item setTitle:tabBarItem.title forState:UIControlStateNormal];
        [item setTitle:tabBarItem.title forState:UIControlStateSelected];
        [item setTitleColor:_norTitleColor forState:UIControlStateNormal];
        [item setTitleColor:_selTitleColor forState:UIControlStateSelected];
        
        
        [item addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:item];
        
    }];
    
}
- (void)cu_setTabBarItemTitleColor:(UIColor * _Nonnull)norTitleColor
                  andSelTitleColor:(UIColor * _Nonnull)selTitleColor
{
    _norTitleColor = norTitleColor;
    _selTitleColor = selTitleColor;
}

- (void)cu_setShadeItemBackgroundImage:(UIImage *)backgroundImage
{
    [_shadeItem setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [_shadeItem setBackgroundImage:backgroundImage forState:UIControlStateSelected];
}

- (void)cu_setShadeItemBackgroundColor:(UIColor *)coloer
{
    [_shadeItem setBackgroundColor:coloer];
    [_shadeItem setBackgroundImage:nil forState:UIControlStateNormal];
    [_shadeItem setBackgroundImage:nil forState:UIControlStateSelected];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    /** 布局按钮 */
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    _shadeItem.frame = CGRectMake(0, 0, btnW, btnH);
    
    if (_centerButton.currentImage || _centerButton.currentBackgroundImage) {
        
        // 设置尺寸
        CGRect frame = _centerButton.frame;
        frame.size = _centerButton.currentBackgroundImage.size;
        _centerButton.frame = frame;
        
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        
        _centerButton.center = CGPointMake(width * 0.5, height * 0.5);
        
        NSInteger index = 0;
        for (UIControl *button in self.subviews) {
            if (![button isKindOfClass:[UIControl class]] || button == _centerButton || button == _shadeItem) continue;
            
            // 计算按钮的x值
            btnX = btnW * (index > 1 ? (index + 1) : index);
            button.frame = CGRectMake(btnX, btnY, btnW, btnH);
            
            // 增加索引
            index++;
        }
        
    }else {
        for (int i = 2; i < self.subviews.count; i++) {
            UIButton *btn = self.subviews[i];
            btnX = (i - 2) * btnW;
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        }
    }
    
    
    
}

- (void)buttonClickAction:(UIButton *)btn{
    
    if (btn == self.seletBtn) return;
    
    self.seletBtn.selected = NO;
    
    btn.selected = YES;
    
    self.seletBtn = btn;
    
    if (!_cancelAnimation) {
        _shadeItem.hidden = NO;
        [self moveShadeBtn:btn];
        [self btnAnimate:btn];
    }else {
        _shadeItem.hidden = YES;
    }
    
    btn.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(cu_tabBar:didSelectItem:)]) {
        
        [self.delegate cu_tabBar:self didSelectItem:btn.tag];
    }
}


- (void)setCancelAnimation:(BOOL)cancelAnimation
{
    _cancelAnimation = cancelAnimation;
    
    _shadeItem.hidden = !cancelAnimation;
}


- (void)moveShadeBtn:(UIButton*)btn{
    
    [UIView animateWithDuration:0.3 animations:
     ^(void){
         
         CGRect frame = _shadeItem.frame;
         frame.origin.x = btn.frame.origin.x;
         _shadeItem.frame = frame;
         
         
     } completion:^(BOOL finished){//do other thing
     }];
    
}

- (void)btnAnimate:(UIButton*)btn{
    
    UIView *view=btn.imageView;
    
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         
         view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.5, 0.5);
         
     } completion:^(BOOL finished){//do other thing
         [UIView animateWithDuration:0.2 animations:
          ^(void){
              
              view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.2, 1.2);
              
          } completion:^(BOOL finished){//do other thing
              [UIView animateWithDuration:0.1 animations:
               ^(void){
                   
                   view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
                   
               } completion:^(BOOL finished){//do other thing
               }];
          }];
     }];
    
    
}
@end
