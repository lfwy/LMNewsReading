//
//  LMProfileViewController.m
//  LMNewsApp
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMProfileViewController.h"
#import "LMBaseSetting.h"

@interface LMProfileViewController ()

@end

@implementation LMProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    //设置导航栏
    [self setUpNavigationItem];
    
    //设置顶部视图
    [self setUpHeaderView];
    //设置各个分组
    [self setUpGroup0];
    [self setUpGroup1];
    [self setUpGroup2];
}

- (void)setUpNavigationItem {
    UIBarButtonItem *setting = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(clickSettingButton)];
    self.navigationItem.rightBarButtonItem = setting;
}

- (void)clickSettingButton {
    
}

- (void)setUpHeaderView {
    
}

- (void)setUpGroup0 {
    LMArrowItem *msgItem = [LMArrowItem itemWithTitle:@"我的消息" image:[UIImage imageNamed:@"user_set_icon_message"]];
    LMGroupItem *group = [[LMGroupItem alloc]init];
    group.items = @[msgItem];
    [self.groups addObject:group];
    
}
- (void)setUpGroup1 {
    LMArrowItem *gold = [LMArrowItem itemWithTitle:@"金币商城" image:[UIImage imageNamed:@"user_set_icon_wallet"]];
    LMArrowItem *task = [LMArrowItem itemWithTitle:@"我的任务" image:[UIImage imageNamed:@"user_set_icon_groupon"]];
    LMArrowItem *pocket = [LMArrowItem itemWithTitle:@"我的钱包" image:[UIImage imageNamed:@"user_set_icon_wallet"]];
    LMGroupItem *group = [[LMGroupItem alloc]init];
    group.items = @[gold,task,pocket];
    [self.groups addObject:group];
}
- (void)setUpGroup2 {
    LMArrowItem *read = [LMArrowItem itemWithTitle:@"离线阅读" image:[UIImage imageNamed:@"user_set_icon_wallet"]];
    LMArrowItem *activity = [LMArrowItem itemWithTitle:@"活动广场" image:[UIImage imageNamed:@"user_set_icon_groupon"]];
    LMArrowItem *game = [LMArrowItem itemWithTitle:@"游戏中心" image:[UIImage imageNamed:@"user_set_icon_wallet"]];
    LMArrowItem *email = [LMArrowItem itemWithTitle:@"我的邮箱" image:[UIImage imageNamed:@"user_set_icon_groupon"]];
    LMArrowItem *friend = [LMArrowItem itemWithTitle:@"邀请好友" image:[UIImage imageNamed:@"user_set_icon_wallet"]];
    LMGroupItem *group = [[LMGroupItem alloc]init];
    group.items = @[read,activity,game,email,friend];
    [self.groups addObject:group];
}


@end
