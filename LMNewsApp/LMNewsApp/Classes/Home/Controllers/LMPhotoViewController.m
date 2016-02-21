//
//  LMPhotoViewController.m
//  LMNewsApp
//
//  Created by tarena on 16/1/25.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMPhotoViewController.h"
#import "LMReplyViewController.h"
#import "LMNewsTool.h"
#import "LMPhotoTool.h"
#import "LMPhotoView.h"
#import "UIImageView+WebCache.h"
#import "LMPhotoDetail.h"
#import "MJExtension.h"

@interface LMPhotoViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) LMPhoto *photo;
@property (nonatomic,strong) LMPhotoView *photoView;

@end

@implementation LMPhotoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //请求新闻网络数据
    [self requestDataFromSever];
    //设置顶部视图
//    [self setUpTopView];
    
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
    
    topView.backgroundColor = [UIColor blackColor];
    [self.photoView addSubview:topView];
    
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

- (void)requestDataFromSever {
    
    NSString *fullStr = self.news.photosetID;
    NSString *subStr = [fullStr substringFromIndex:4];
    NSArray *params = [subStr componentsSeparatedByString:@"|"];
    NSString *urlString = [NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/%@/%@.json",[params firstObject],[params lastObject]];
    
    [LMPhotoTool photoFromSeverWithUrlString:urlString success:^(LMPhoto *photo) {
        self.photo = photo;
        [self setUpPhotoView];
    } failure:^(NSError *error) {
        
    }];
}

- (void)setUpPhotoView {
    self.photoView = [[LMPhotoView alloc]initWithFrame:CGRectMake(0, 0, LMScreenW, LMScreenH-64)];
    self.photoView.userInteractionEnabled = YES;
    [self.view addSubview:self.photoView];
    self.photoView.titleLabel.text = self.photo.setname;
    self.photoView.descLabel.text = self.photo.desc;
    
    NSUInteger count = self.photo.photos.count;
    self.photoView.photoScrollView.frame = CGRectMake(0, 64, LMScreenW, LMScreenH-160-64);
    self.photoView.photoScrollView.contentOffset = CGPointZero;
    self.photoView.photoScrollView.contentSize = CGSizeMake(self.photoView.photoScrollView.width * count, 0);
    self.photoView.photoScrollView.showsHorizontalScrollIndicator = NO;
    self.photoView.photoScrollView.showsVerticalScrollIndicator = NO;
    self.photoView.photoScrollView.pagingEnabled = YES;
    self.photoView.photoScrollView.delegate = self;
    //设置图片
    [self setUpImageViews:(NSUInteger)count];
    //设置顶部视图
    [self setUpTopView];
}

- (void)setUpImageViews:(NSUInteger)count {
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(LMScreenW*i, 0, LMScreenW, self.photoView.photoScrollView.height)];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        if (i == 0) {
        LMPhotoDetail *photoDetail = [LMPhotoDetail mj_objectWithKeyValues:self.photo.photos[i]];
        NSURL *photoUrl = [NSURL URLWithString:photoDetail.imgurl];
        [imageView sd_setImageWithURL:photoUrl placeholderImage:[UIImage imageNamed:@"photoview_image_default_white"]];
        self.photoView.countLabel.text = [NSString stringWithFormat:@"%d/%lu",i+1,count];
        }
        [self.photoView.photoScrollView addSubview:imageView];
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int i = self.photoView.photoScrollView.contentOffset.x  / LMScreenW;
    int count = self.photoView.photoScrollView.contentSize.width / LMScreenW;
    UIImageView *currentImageView = self.photoView.photoScrollView.subviews[i];
    if (currentImageView.image == nil) {
        LMPhotoDetail *photoDetail = [LMPhotoDetail mj_objectWithKeyValues:self.photo.photos[i]];
        NSURL *photoUrl = [NSURL URLWithString:photoDetail.imgurl];
        [currentImageView sd_setImageWithURL:photoUrl placeholderImage:[UIImage imageNamed:@"photoview_image_default_white"]];
    }
    self.photoView.countLabel.text = [NSString stringWithFormat:@"%d/%d",i+1,count];
}

@end
