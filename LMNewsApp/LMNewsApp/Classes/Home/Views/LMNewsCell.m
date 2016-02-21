//
//  LMNewsCell.m
//  LMNewsApp
//
//  Created by tarena on 16/1/20.
//  Copyright © 2016年 lim. All rights reserved.
//  

#import "LMNewsCell.h"
#import "UIImageView+WebCache.h"

#define LM_CORNER_INSET 15
#define LM_INSET 8
#define LM_IMAGE_WIDTH 80
#define LM_IMAGE_HEIGHT 60
#define LM_LABEL_HEIGHT 17

@interface LMNewsCell ()

@property (nonatomic,strong) UIImageView *backImageView;

@end

@implementation LMNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllChildViews];
    }
    return self;
}

- (void)setUpAllChildViews {
    //添加缩略图
    CGFloat iconX = LM_CORNER_INSET;
    CGFloat iconY = LM_INSET;
    CGFloat iconW = LM_IMAGE_WIDTH;
    CGFloat iconH = LM_IMAGE_HEIGHT;
    CGRect iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    _iconImageView = [[UIImageView alloc]initWithFrame:iconFrame];
    [self addSubview:_iconImageView];
    //添加标题
    CGFloat titleX = LM_CORNER_INSET + CGRectGetMaxX(iconFrame);
    CGFloat titleY = LM_INSET;
    CGFloat titleW = LMScreenW - LM_IMAGE_HEIGHT - titleX;
    CGFloat titleH = LM_LABEL_HEIGHT;
    CGRect titleFrame = CGRectMake(titleX, titleY, titleW, titleH);
    _titleLabel = [[UILabel alloc]initWithFrame:titleFrame];
    [self addSubview:_titleLabel];
    //添加描述
    CGFloat descX = LM_CORNER_INSET + CGRectGetMaxX(iconFrame);
    CGFloat descY = LM_INSET + CGRectGetMaxY(titleFrame);
    CGFloat descW = LMScreenW - LM_IMAGE_HEIGHT - titleX;
    CGFloat descH = LM_LABEL_HEIGHT * 2;
    CGRect descFrame = CGRectMake(descX, descY, descW, descH);
    _descLabel = [[UILabel alloc]initWithFrame:descFrame];
    _descLabel.numberOfLines = 2;
    _descLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_descLabel];
    //添加跟帖背景图
    UIImageView *backImageView = [[UIImageView alloc]init];
    backImageView.image = [UIImage imageNamed:@"night_contentcell_comment_border"];
    _backImageView = backImageView;
    [self addSubview:backImageView];
    //添加跟帖数
    CGFloat replyW = 40;
    CGFloat replyH = 10;
    CGFloat replyX = CGRectGetMaxX(descFrame) + LM_INSET;
    CGFloat replyY = CGRectGetMaxY(iconFrame) - LM_INSET;
    
    CGRect replyFrame = CGRectMake(replyX, replyY, replyW, replyH);
    _replyLabel = [[UILabel alloc]initWithFrame:replyFrame];
    [self addSubview:_replyLabel];

    
}

- (void)setNews:(LMNews *)news {
    _news = news;
    //设置各个子控件属性
    self.titleLabel.text = news.title;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc] placeholderImage:[UIImage imageWithOriginalName:@"11111"]];
    int replyCount = [news.replyCount intValue];
    if (replyCount < 10000) {
        self.replyLabel.text = [NSString stringWithFormat:@"%@跟帖",news.replyCount];
    }else {
        self.replyLabel.text = [NSString stringWithFormat:@"%d万跟帖",replyCount/10000];
    }
    self.replyLabel.textAlignment = NSTextAlignmentCenter;
    self.descLabel.text = news.digest;
    self.descLabel.font = [UIFont systemFontOfSize:14];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize replyLabelSize = [self.replyLabel.text sizeWithFont:[UIFont systemFontOfSize:12]];
    CGFloat replyX = LMScreenW - LM_INSET - replyLabelSize.width;
    CGRect finalFrame = {{replyX,_replyLabel.frame.origin.y},replyLabelSize};
    self.replyLabel.frame = finalFrame;
    self.backImageView.frame = finalFrame;
    self.replyLabel.font = [UIFont systemFontOfSize:10];
}

@end
