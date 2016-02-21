//
//  LMNewsDetailViewController.m
//  LMNewsApp
//
//  Created by tarena on 16/1/21.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMNewsDetailViewController.h"
#import "LMNewsTool.h"
#import "LMDetailNews.h"
#import "LMDetailImage.h"
#import "LMReplyViewController.h"
#import "LMReplyTool.h"

@interface LMNewsDetailViewController ()

@property (nonatomic,strong) UIWebView *detailWebView;
@property (nonatomic,strong) LMDetailNews *detailNews;
@property (nonatomic,weak) UIButton *replyButton;

@end

@implementation LMNewsDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置顶部视图
    [self setUpTopView];
    //添加网页视图
    [self addWebView];
    //请求新闻网络数据
    [self requestDataFromSever];

}

- (void)setUpTopView {
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LMScreenW, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    UIButton *backButton = [[UIButton alloc]init];
    [backButton setBackgroundImage:[UIImage imageNamed:@"night_icon_back"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(5, 20, 45, 35);
    [backButton addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backButton];
    
    UIButton *button = [[UIButton alloc]init];
    [button setBackgroundImage:[UIImage imageNamed:@"contentview_commentbacky"] forState:UIControlStateNormal];
    NSString *reply = nil;
    [button setValue:[UIFont systemFontOfSize:13] forKey:@"font"];
    if ([self.news.replyCount intValue] > 10000) {
        reply = [NSString stringWithFormat:@"%d万跟帖",[self.news.replyCount intValue] / 10000];
    }else {
        reply = [NSString stringWithFormat:@"%@条跟帖",self.news.replyCount];
    }
    
    [button setTitle:[NSString stringWithFormat:@"%@",reply] forState:UIControlStateNormal];
    [button sizeToFit];
    button.frame = CGRectMake(LMScreenW - 5 - button.width*1.5, 15, button.width*1.5, button.height);
    
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:button];
    
    [self.view addSubview:topView];
    
}

- (void)clickButton {
    LMReplyViewController *replyViewController = [[LMReplyViewController alloc]init];
    replyViewController.news = self.news;
    [self.navigationController pushViewController:replyViewController animated:YES];
}

- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)addWebView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIWebView *detailWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, LMScreenW, LMScreenH-64)];
    _detailWebView = detailWebView;
    [self.view addSubview:detailWebView];
    
}

- (void)requestDataFromSever {
    
    NSString *docid = self.news.docid;
    
    [LMNewsTool detailNewsFromSeverWithDocid:docid success:^(NSDictionary *responseObject) {
        self.detailNews = [LMDetailNews detailWithDict:responseObject[self.news.docid]];
        [self showDetailWebView];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 拼接html语言
- (void)showDetailWebView
{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"LMDetails.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body>"];
    [html appendString:[self touchBody]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    [self.detailWebView loadHTMLString:html baseURL:nil];
}

- (NSString *)touchBody
{
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\">%@</div>",self.detailNews.title];
    [body appendFormat:@"<div class=\"time\">%@</div>",self.detailNews.ptime];
    if (self.detailNews.body != nil) {
        [body appendString:self.detailNews.body];
    }
    // 遍历img
    for (LMDetailImage *detailImg in self.detailNews.img) {
        NSMutableString *imgHtml = [NSMutableString string];
        
        // 设置img的div
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        
        // 数组存放被切割的像素
        NSArray *pixel = [detailImg.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [[pixel firstObject]floatValue];
        CGFloat height = [[pixel lastObject]floatValue];
        // 判断是否超过最大宽度
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width * 0.96;
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        
        NSString *onload = @"this.onclick = function() {"
        "  window.location.href = 'sx:src=' +this.src;"
        "};";
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,detailImg.src];
        // 结束标记
        [imgHtml appendString:@"</div>"];
        // 替换标记
        [body replaceOccurrencesOfString:detailImg.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    return body;
}

@end
