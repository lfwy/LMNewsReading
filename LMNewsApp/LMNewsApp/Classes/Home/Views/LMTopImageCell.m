//
//  LMTopImageCell.m
//  LMNewsApp
//
//  Created by tarena on 16/1/20.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMTopImageCell.h"
#import "UIImageView+WebCache.h"

#define LM_CORNER_INSET 15

#define LM_INSET 8

#define LM_MARGIN 20

#define LM_LABEL_HEIGHT 24

#define LM_IMAGE_HEIGHT 210

@implementation LMTopImageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllChildViews];
    }
    return self;
}

- (void)setUpAllChildViews {
    
    //添加图片
    CGFloat iconX = 0;
    CGFloat iconY = 0;
    CGFloat iconW = LMScreenW;
    CGFloat iconH = LM_IMAGE_HEIGHT;
    CGRect iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    self.iconImageView = [[UIImageView alloc]initWithFrame:iconFrame];
    [self addSubview:self.iconImageView];
    
    //添加头像
    CGFloat imageX = LM_INSET;
    CGFloat imageY = CGRectGetMaxY(iconFrame) + LM_INSET;
    CGFloat imageW = LM_LABEL_HEIGHT;
    CGFloat imageH = LM_LABEL_HEIGHT;
    CGRect imageFrame = CGRectMake(imageX, imageY, imageW, imageH);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageFrame];
    imageView.image = [UIImage imageNamed:@"night_photoset_list_cell_icon"];
    [self addSubview:imageView];
    
    //添加标题
    CGFloat titleX = LM_CORNER_INSET*2;
    CGFloat titleY = CGRectGetMaxY(iconFrame) + LM_INSET;
    CGFloat titleW = LMScreenW - 2 * LM_INSET;
    CGFloat titleH = LM_LABEL_HEIGHT;
    CGRect titleFrame = CGRectMake(titleX, titleY, titleW, titleH);
    self.titleLabel = [[UILabel alloc]initWithFrame:titleFrame];
    [self addSubview:self.titleLabel];
    
    //添加点点点
    CGFloat labelX = LMScreenW - LM_MARGIN - LM_LABEL_HEIGHT;
    CGFloat labelY = CGRectGetMaxY(iconFrame) + LM_INSET;
    CGFloat labelW = LM_LABEL_HEIGHT;
    CGFloat labelH = LM_LABEL_HEIGHT;
    CGRect labelFrame = CGRectMake(labelX, labelY, labelW, labelH);
    UILabel *label = [[UILabel alloc]initWithFrame:labelFrame];
    label.font = [UIFont systemFontOfSize:33];
    label.text = @"···";
    [self addSubview:label];
}

- (void)setNews:(LMNews *)news {
    [super setNews:news];
    //设置各个子控件属性
    self.titleLabel.text = news.title;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc] placeholderImage:[UIImage imageWithOriginalName:@"11111"]];
}

@end
