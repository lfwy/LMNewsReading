//
//  LMNewsTableViewController.m
//  LMNewsApp
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMNewsTableViewController.h"
#import "LMNewsTool.h"
#import "LMNews.h"
#import "LMNewsCell.h"
#import "LMBigImageCell.h"
#import "LMImagesCell.h"
#import "LMNewsCellTool.h"
#import "LMTopImageCell.h"
#import "MJRefresh.h"
#import "LMNewsDetailViewController.h"
#import "LMPhotoViewController.h"

@interface LMNewsTableViewController ()

@property (nonatomic,strong) NSMutableArray *allNews;
@property(nonatomic,assign) NSInteger index;

@end

@implementation LMNewsTableViewController

- (NSMutableArray *)allNews {
    if (!_allNews) {
        _allNews = [NSMutableArray array];
    }
    return _allNews;
}
    

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNewData];
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewData)];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
}

- (void)loadNewData {
    [self loadDataByMethodType:1 andUrlString:self.urlString];
}

- (void)loadMoreData {
    [self loadDataByMethodType:2 andUrlString:self.urlString];
}

- (void)loadDataByMethodType:(NSInteger)methodType andUrlString:(NSString *)urlString {
    if (methodType == 1) {
        _index = 0;
    }else {
        _index += 20;
    }
    [LMNewsTool newsFromSeverWithIndex:_index urlString:self.urlString success:^(NSMutableArray *newses) {
        if (methodType == 1) {
            [self.tableView headerEndRefreshing];
            self.allNews = newses;
        }else {
            [self.tableView footerEndRefreshing];
            [self.allNews addObjectsFromArray:newses];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allNews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //获得news对象
    LMNews *news = self.allNews[indexPath.row];
    NSString *ID = [LMNewsCellTool idForRow:news];

    LMNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        if (news.hasHead){
            cell = [[LMTopImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }else if (news.imgType) {
            cell = [[LMBigImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }else if (news.imgextra) {
            cell = [[LMImagesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }else {
            cell = [[LMNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }

    }
    
    cell.news = news;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 在选中时马上取消选中，做到不变灰的效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LMNews *news = self.allNews[indexPath.row];
    if (news.photosetID) {
        LMPhotoViewController *photoVC = [[LMPhotoViewController alloc]init];
        photoVC.news = news;
        photoVC.hidesBottomBarWhenPushed = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        [self.navigationController pushViewController:photoVC animated:YES];
    }else{
        
        LMNewsDetailViewController *detailVC = [[LMNewsDetailViewController alloc]init];
        detailVC.news = self.allNews[indexPath.row];
        detailVC.hidesBottomBarWhenPushed = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LMNews *news = self.allNews[indexPath.row];
    return [LMNewsCellTool heightForRow:news];
}

@end
