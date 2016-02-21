//
//  LMNavigationController.m
//  LMNewsApp
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMNavigationController.h"

@interface LMNavigationController ()<UINavigationControllerDelegate>

@end

@implementation LMNavigationController

+ (void)initialize
{
    
    // 设置导航栏的主题
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.tintColor = [UIColor whiteColor];
    navBar.barStyle = UIBarStyleBlack;
    [navBar setBarTintColor:[UIColor redColor]];
    
    //获取当前类下的barButtonItem对象（外观）
    UIBarButtonItem *btnItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[self]];

    // 设置导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [btnItem setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
}

//在导航控制器即将显示时，移除系统tabBar
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //LMKeyWindow是pch文件中的宏定义
    UITabBarController *tabBarController = (UITabBarController *)LMKeyWindow.rootViewController;
    for (UIView *tabBarButton in tabBarController.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

@end
