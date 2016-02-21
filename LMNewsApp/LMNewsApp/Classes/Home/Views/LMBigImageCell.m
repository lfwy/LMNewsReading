//
//  LMBigImageCell.m
//  LMNewsApp
//
//  Created by tarena on 16/1/20.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMBigImageCell.h"
#include "UIImageView+WebCache.h"

#define LM_CORNER_INSET 15

#define LM_INSET 8

#define LM_MARGIN 20

#define LM_LABEL_HEIGHT 19

#define LM_IMAGE_HEIGHT 102

@implementation LMBigImageCell


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

    //添加图片
    CGFloat iconX = LM_CORNER_INSET;
    CGFloat iconY = LM_INSET + CGRectGetMaxY(titleFrame);
    CGFloat iconW = LMScreenW - 2* LM_MARGIN;
    CGFloat iconH = LM_IMAGE_HEIGHT;
    CGRect iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    self.iconImageView = [[UIImageView alloc]initWithFrame:iconFrame];
    [self addSubview:self.iconImageView];
    
    //添加描述
    CGFloat descX = LM_CORNER_INSET;
    CGFloat descY = LM_INSET + CGRectGetMaxY(iconFrame);
    CGFloat descW = LMScreenW - LM_INSET - titleX;
    CGFloat descH = LM_LABEL_HEIGHT;
    CGRect descFrame = CGRectMake(descX, descY, descW, descH);
    self.descLabel = [[UILabel alloc]initWithFrame:descFrame];
    self.descLabel.font = [UIFont systemFontOfSize:11];
    self.descLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.descLabel];
    
}

- (void)setNews:(LMNews *)news {
    [super setNews:news];
    //设置各个子控件属性
    self.titleLabel.text = news.title;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc] placeholderImage:[UIImage imageWithOriginalName:@"11111"]];
    self.descLabel.text = news.digest;
    self.descLabel.font = [UIFont systemFontOfSize:15];
}

@end
