//
//  LMImagesCell.m
//  LMNewsApp
//
//  Created by tarena on 16/1/20.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMImagesCell.h"
#include "UIImageView+WebCache.h"

#define LM_CORNER_INSET 15

#define LM_INSET 8

#define LM_MARGIN 20

#define LM_LABEL_HEIGHT 19

#define LM_IMAGE_HEIGHT 80
#define LM_IMAGE_WIDTH 113

@interface LMImagesCell ()

@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) NSArray *imageArray;

@end

@implementation LMImagesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllChildViews];
    }
    return self;
}

- (void)setUpAllChildViews {
    
    //添加标题
    CGFloat titleX = LM_CORNER_INSET;
    CGFloat titleY = LM_INSET;
    CGFloat titleW = LMScreenW - 2 * LM_INSET - LM_IMAGE_HEIGHT;
    CGFloat titleH = LM_LABEL_HEIGHT;
    CGRect titleFrame = CGRectMake(titleX, titleY, titleW, titleH);
    self.titleLabel = [[UILabel alloc]initWithFrame:titleFrame];
    [self addSubview:self.titleLabel];
    
    //添加跟帖背景图
    UIImageView *backImageView = [[UIImageView alloc]init];
    backImageView.image = [UIImage imageNamed:@"night_contentcell_comment_border"];
    _backImageView = backImageView;
    [self addSubview:backImageView];
    //添加跟帖数
    CGFloat replyW = 40;
    CGFloat replyH = 10;
    CGFloat replyX = LMScreenW - LM_INSET;
    CGFloat replyY = titleFrame.origin.y;
    
    CGRect replyFrame = CGRectMake(replyX, replyY, replyW, replyH);
    self.replyLabel = [[UILabel alloc]initWithFrame:replyFrame];
    [self addSubview:self.replyLabel];
    

    
    //添加第一张图片
    CGFloat iconX = LM_CORNER_INSET;
    CGFloat iconY = LM_INSET + CGRectGetMaxY(titleFrame);
    CGFloat iconW = LM_IMAGE_WIDTH;
    CGFloat iconH = LM_IMAGE_HEIGHT;
    CGRect iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    self.iconImageView = [[UIImageView alloc]initWithFrame:iconFrame];
    [self addSubview:self.iconImageView];
    
    //添加缩略图
    iconX = LM_CORNER_INSET + LM_IMAGE_WIDTH + LM_MARGIN;
    iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    self.secondImageView = [[UIImageView alloc]initWithFrame:iconFrame];
    self.secondImageView.backgroundColor = [UIColor blueColor];
    [self addSubview:self.secondImageView];
    
    //添加缩略图
    iconX = LM_CORNER_INSET + (LM_IMAGE_WIDTH + LM_MARGIN)*2;
    iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    self.thirdImageView = [[UIImageView alloc]initWithFrame:iconFrame];
    self.thirdImageView.backgroundColor = [UIColor blueColor];
    [self addSubview:self.thirdImageView];
    
}

- (void)setNews:(LMNews *)news {
    [super setNews:news];
    //设置各个子控件属性
    self.titleLabel.text = news.title;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc] placeholderImage:[UIImage imageWithOriginalName:@"11111"]];
    [self.secondImageView sd_setImageWithURL:[NSURL URLWithString:news.imgextra[0][@"imgsrc"]] placeholderImage:[UIImage imageWithOriginalName:@"11111"]];
    [self.thirdImageView sd_setImageWithURL:[NSURL URLWithString:news.imgextra[1][@"imgsrc"]] placeholderImage:[UIImage imageWithOriginalName:@"11111"]];
    int replyCount = [news.replyCount intValue];
    if (replyCount < 10000) {
        self.replyLabel.text = [NSString stringWithFormat:@"%@跟帖",news.replyCount];
    }else {
        self.replyLabel.text = [NSString stringWithFormat:@"%d万跟帖",replyCount/10000];
    }
    self.replyLabel.textAlignment = NSTextAlignmentCenter;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize replyLabelSize = [self.replyLabel.text sizeWithFont:[UIFont systemFontOfSize:12]];
    CGFloat replyX = LMScreenW - LM_INSET - replyLabelSize.width;
    CGRect finalFrame = {{replyX,self.replyLabel.frame.origin.y},replyLabelSize};
    self.replyLabel.frame = finalFrame;
    self.backImageView.frame = finalFrame;
    self.replyLabel.font = [UIFont systemFontOfSize:10];
}

@end
