//
//  LMBaseSettingTableViewController.m
//  李明微博
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMBaseSettingTableViewController.h"
#import "LMGroupItem.h"
#import "LMSettingCell.h"
#import "LMSettingItem.h"

@interface LMBaseSettingTableViewController ()

@end

@implementation LMBaseSettingTableViewController

- (NSMutableArray *)groups {
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (instancetype)init {
    //重写init方法，让控制器全部为group样式
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//返回多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}
//返回一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LMGroupItem *group = self.groups[section];
    return group.items.count;
}

//返回每一行长什么样 第一个cell的y是35
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1.创建cell
    LMSettingCell *cell = [LMSettingCell cellWithTableView:self.tableView];
    //2.给cell传递模型
    LMGroupItem *group = self.groups[indexPath.section];
    LMSettingItem *item = group.items[indexPath.row];
    cell.item = item;
    
    return cell;
}

//返回头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    LMGroupItem *group = self.groups[section];
    return group.headerTitle;
}
//返回尾部标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    LMGroupItem *group = self.groups[section];
    return group.headerTitle;
}

//点击某一行cell的时候做事情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //取消
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //取出模型
    LMGroupItem *group = self.groups[indexPath.section];
    LMSettingItem *item = group.items[indexPath.row];
    
    if (item.option) {
        item.option((LMCheckItem *)item);
        return;
    }
    
    //判断是否可以跳转
    if (item.destVCClass) {
       //获取目标控制器
        UIViewController *vc = [[item.destVCClass alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
