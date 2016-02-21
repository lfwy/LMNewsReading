//
//  LMBarButton.m
//  LMNewsApp
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMBarButton.h"
#import "LMBadgeView.h"

#define LMImageRidio 0.7

@interface LMBarButton ()

@property (nonatomic, weak) LMBadgeView *badgeView;

@end

@implementation LMBarButton

// 重写setHighlighted，取消高亮做的事情
- (void)setHighlighted:(BOOL)highlighted{

}

// 懒加载badgeView
- (LMBadgeView *)badgeView
{
    if (_badgeView == nil) {
        LMBadgeView *btn = [LMBadgeView buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:btn];
        
        _badgeView = btn;
    }
    
    return _badgeView;
}

// 传递UITabBarItem给tabBarButton,给tabBarButton内容赋值
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    // KVO：时刻监听一个对象的属性有没有改变
    // 给谁添加观察者
    // Observer:按钮
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    
}

// 只要监听的属性一有新值，就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    [self setTitle:_item.title forState:UIControlStateNormal];
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    
    // 设置badgeValue
    self.badgeView.badgeValue = _item.badgeValue;
}

// 修改按钮内部子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //    self.titleLabel.x = self.imageView.x;
    self.imageView.y = 5;
    self.imageView.width = 25;
    self.imageView.height = 25;
    self.imageView.x = (self.width - self.imageView.width)/2.0;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.x = self.imageView.x - (self.titleLabel.width - self.imageView.width)/2.0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + 2;
    
    self.titleLabel.font = [UIFont systemFontOfSize:10];
    self.titleLabel.shadowColor = [UIColor clearColor];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    // 3.badgeView
    self.badgeView.x = self.width - self.badgeView.width - 10;
    self.badgeView.y = 0;
}

@end
