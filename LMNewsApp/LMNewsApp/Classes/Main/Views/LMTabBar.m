//
//  LMTabBar.m
//  LMNewsApp
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMTabBar.h"
#import "LMBarButton.h"

@interface LMTabBar ()

@property (nonatomic,strong) UIButton *selectedButton;
@property(nonatomic,strong)NSMutableArray *buttons;

@end

@implementation LMTabBar

- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)setItems:(NSArray *)items {
    _items  = items;
    //遍历数组，取出tabBarButtonItem
    for (UITabBarItem *item in _items) {
        LMBarButton *button = [LMBarButton buttonWithType:UIButtonTypeCustom];
        button.item = item;
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        button.tag = self.buttons.count;
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchDown];

        if (button.tag == 0) { // 默认选中第0个
            [self clickButton:button];
        }
        
        [self addSubview:button];
        // 把按钮添加到按钮数组
        [self.buttons addObject:button];
    }
}

- (void)clickButton:(UIButton *)selButton {
    //切换button的选中状态
    _selectedButton.selected = NO;
    _selectedButton = selButton;
    _selectedButton.selected = YES;
    
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:selButton.tag];
    }
}

- (void)layoutSubviews
{
    
    for (int i = 0; i<self.subviews.count; i++) { // $$$$$
        
        UIButton *btn = self.subviews[i];
        
        CGFloat btnW = [UIScreen mainScreen].bounds.size.width/5;
        CGFloat btnH = 49;
        CGFloat btnX = i * btnW;
        CGFloat btnY = 0;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        // 绑定tag 便于后面使用
        btn.tag = i;
    }
}

@end
