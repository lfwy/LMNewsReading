//
//  LMHomeViewController.m
//  LMNewsApp
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMHomeViewController.h"
#import "LMTitleLabel.h"
#import "LMNewsTableViewController.h"

@interface LMHomeViewController ()<UIScrollViewDelegate>
/**
 *  标题栏滚动视图
 */
@property (nonatomic,strong) UIScrollView *smallScrollView;
/**
 *  内容部分滚动视图
 */
@property (nonatomic,strong) UIScrollView *bigScrollView;
/**
 *  所有标题数组
 */
@property (nonatomic,strong) NSArray *allTitles;

@property (nonatomic,strong) UIImageView *backImageView;

@end

@implementation LMHomeViewController

//懒加载标题数组
- (NSArray *)allTitles {
    if (!_allTitles) {
        _allTitles = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NewsURLs" ofType:@"plist"]];
    }
    return _allTitles;
}
//恢复navigationBar的显示状态
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置中间视图
    [self setUpTitleView];
    //加载背景视图
    [self addBackGroudImageView];
    //加载滚动视图
    [self setUpScrollView];

    //加载标题label
    [self setUpTitleLabel];
    //添加内容子控制器
    [self setUpNewsTableViewController];
    
}

- (void)setUpTitleView {
    UIImageView *titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 23)];
    titleImageView.image = [UIImage imageNamed:@"11111"];
    titleImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = titleImageView;
}

- (void)addBackGroudImageView {
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backImageView.image = [UIImage imageNamed:@"22222"];
    backImageView.backgroundColor = [UIColor lightGrayColor];
    backImageView.contentMode = UIViewContentModeCenter;
    _backImageView = backImageView;
    [self.view addSubview:backImageView];
}

#pragma mark - 加载滚动视图
- (void)setUpScrollView {
    //关闭scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置标题栏滚动视图
    self.smallScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, LMScreenW, 40)];
    //关闭弹跳效果
    self.smallScrollView.bounces = NO;
    //设置背景颜色
    self.smallScrollView.backgroundColor = [UIColor whiteColor];
    //设置内容大小
    self.smallScrollView.contentSize = CGSizeMake(self.allTitles.count * 70, 0);
    //关闭水平滚动条
    self.smallScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.smallScrollView];
    //设置内容滚动视图
    self.bigScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 104, LMScreenW, LMScreenH - 154)];
    //设置内容大小
    self.bigScrollView.contentSize = CGSizeMake(LMScreenW * self.allTitles.count, 0);
    //设置分页
    self.bigScrollView.pagingEnabled = YES;
    //关闭弹跳效果
    self.bigScrollView.bounces = NO;
    //设置代理
    self.bigScrollView.delegate = self;
    self.bigScrollView.backgroundColor = [UIColor clearColor];
    //关闭水平滚动条
    self.bigScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.bigScrollView];
}
#pragma mark - 加载标题label
- (void)setUpTitleLabel {
    //设置标题栏title
    for (int i = 0; i < self.allTitles.count; i++) {

        LMTitleLabel *label = [[LMTitleLabel alloc]init];
    
        label.text = self.allTitles[i][@"title"];
        
        CGFloat lblW = 70;
        CGFloat lblH = 40;
        CGFloat lblY = 0;
        CGFloat lblX = i * lblW;
        
        label.frame = CGRectMake(lblX, lblY, lblW, lblH);
        label.font = [UIFont systemFontOfSize:19];
        [self.smallScrollView addSubview:label];
        label.tag = i;
        label.userInteractionEnabled = YES;
        //添加label点击手势 点击时调用clickLabel方法
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLabel:)]];
        
        if (i == 0) {
            label.scale = 1;
        }
        
    }
}

#pragma mark - label点击
- (void)clickLabel:(UITapGestureRecognizer *)tap {
    //取得点击来源的label
    LMTitleLabel *tapLabel = (LMTitleLabel *)tap.view;
    //设置内容滚动视图应跳转到位置的偏移点
    CGFloat offsetX = tapLabel.tag * LMScreenW;
    CGFloat offsetY = 0;
    CGPoint offsetPoint = CGPointMake(offsetX, offsetY);
    //将内容滚动视图滚动到偏移点
    [self.bigScrollView setContentOffset:offsetPoint animated:YES];
}

#pragma mark - 添加内容子控制器
- (void)setUpNewsTableViewController {
    for (int i=0 ; i<self.allTitles.count ;i++){
        LMNewsTableViewController *vc1 = [[LMNewsTableViewController alloc]init];
        vc1.title = self.allTitles[i][@"title"];
        vc1.urlString = self.allTitles[i][@"urlString"];
        [self addChildViewController:vc1];
        
        
        if (i == 0) {
            vc1.view.frame = self.bigScrollView.bounds;
            [self.bigScrollView addSubview:vc1.view];
        }
    }
}
#pragma mark - 停止滚动
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / LMScreenW;
    
    // 滚动标题栏
    LMTitleLabel *titleLable = (LMTitleLabel *)self.smallScrollView.subviews[index];
    
    CGFloat offsetx = titleLable.center.x - self.smallScrollView.frame.size.width * 0.5;
    
    CGFloat offsetMax = self.smallScrollView.contentSize.width - self.smallScrollView.frame.size.width;
    //判断显示的label是否在屏幕的另一边
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx, self.smallScrollView.contentOffset.y);
    [self.smallScrollView setContentOffset:offset animated:YES];
    // 添加控制器
    LMNewsTableViewController *newsVc = self.childViewControllers[index];
    newsVc.view.frame = scrollView.bounds;
    [self.bigScrollView addSubview:newsVc.view];
    
}
#pragma mark - 滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - 正在滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 取出绝对值 避免最左边往右拉时形变超过1 滚动视图偏移量的x除以一屏宽 得到的值为第几屏+当前屏滑动的百分比
    CGFloat value = ABS(scrollView.contentOffset.x / LMScreenW);
    //强转value得到上一view/label的下标
    NSUInteger leftIndex = (int)value;
    //+1得到当前view/label的下标
    NSUInteger rightIndex = leftIndex + 1;
    //得到当前view/label大小和颜色变化的百分比
    CGFloat scaleRight = value - leftIndex;
    //得到上一view/label大小和颜色变化的百分比
    CGFloat scaleLeft = 1 - scaleRight;
    //取得上一label对象
    LMTitleLabel *labelLeft = self.smallScrollView.subviews[leftIndex];
    //改变上一label对象的字体以及颜色
    labelLeft.scale = scaleLeft;
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < self.smallScrollView.subviews.count-1) {
        //取得当前label对象
        LMTitleLabel *labelRight = self.smallScrollView.subviews[rightIndex];
        //改变当前label对象的字体以及颜色
        labelRight.scale = scaleRight;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
