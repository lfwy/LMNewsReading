//
//  LMReplyViewController.m
//  LMNewsApp
//
//  Created by tarena on 16/1/23.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMReplyViewController.h"
#import "LMReplyTool.h"
#import "LMReplyCell.h"
#import "LMReply.h"

@interface LMReplyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *replyView;
@property (nonatomic,strong) NSArray *allReplies;
@property (nonatomic,assign) CGFloat currentCellHeight;
@end

@implementation LMReplyViewController

- (NSArray *)allReplies {
    if (!_allReplies) {
        _allReplies = [NSArray array];
    }
    return _allReplies;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加顶部视图
    [self setUpTopView];
    //添加跟帖表视图
    [self setUpReplyTableView];
    //请求跟帖网络数据
    [self requestReplyDataFromSever];
    
}

- (void)setUpTopView {
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LMScreenW, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    UIButton *backButton = [[UIButton alloc]init];
    [backButton setBackgroundImage:[UIImage imageNamed:@"night_icon_back"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(5, 20, 45, 35);
    [backButton addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backButton];
    
    [self.view addSubview:topView];
    
}

- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)requestReplyDataFromSever {
    NSString *url = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/10/10/2/2",self.news.boardid,self.news.docid];
    [LMReplyTool replyFromSeverWithUrlString:url success:^(NSArray *replies) {
        self.allReplies = replies;
        [self.replyView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)setUpReplyTableView {
    UITableView *replyView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, LMScreenW, LMScreenH-64)];
    replyView.delegate = self;
    replyView.dataSource = self;
    _replyView = replyView;
    [self.view addSubview:replyView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.allReplies.count) {
        return 1;
    }else {
        NSLog(@"%lu",self.allReplies.count);
        return self.allReplies.count;
    }
}
static NSString *ID = @"cell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LMReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LMReplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (self.allReplies.count) {
        cell.textLabel.text = @"";
        LMReply *reply = self.allReplies[indexPath.row];
        cell.reply = reply;
        self.currentCellHeight = cell.frame.size.height;
    }else {
        cell.textLabel.text = @"暂无跟帖数据";
    }

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LMScreenW, 40)];
    
    UIButton *button = [[UIButton alloc]init];
    [button setBackgroundImage:[UIImage imageNamed:@"contentview_commentbacky"] forState:UIControlStateNormal];
    [button setValue:[UIFont systemFontOfSize:13] forKey:@"font"];
    [button sizeToFit];
    button.frame = CGRectMake(10, 0, button.width*2.5, button.height);
    [headerView addSubview:button];
    
    if (section == 0) {
        [button setTitle:@"最新评论" forState:UIControlStateNormal];
    }else {
        [button setTitle:@"最热评论" forState:UIControlStateNormal];
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.allReplies.count == 0){
        return 40;
    }else{
        NSLog(@"~~%g",self.currentCellHeight);
        return self.currentCellHeight;
    }
}

@end
