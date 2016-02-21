//
//  LMTabBar.h
//  LMNewsApp
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 lim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LMTabBar;
@protocol LMTabBarDelegate <NSObject>

@optional
/**
 *  tabBar切换控制器
 *
 *  @param tabBar 自定义的tabBar
 *  @param index  点击tabBarButton的索引
 */
- (void)tabBar:(LMTabBar *)tabBar didClickButton:(NSInteger)index;

@end

@interface LMTabBar : UIView

@property (nonatomic,strong) NSArray *items;

@property (nonatomic,strong) id<LMTabBarDelegate> delegate;
@end
