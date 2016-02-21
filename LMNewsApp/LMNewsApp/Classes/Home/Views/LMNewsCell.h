//
//  LMNewsCell.h
//  LMNewsApp
//
//  Created by tarena on 16/1/20.
//  Copyright © 2016年 lim. All rights reserved.
//  普通文字描述cell模型

#import <UIKit/UIKit.h>
#import "LMNews.h"

@interface LMNewsCell : UITableViewCell

/**
 *  图片
 */
@property (nonatomic,strong) UIImageView *iconImageView;
/**
 *  标题
 */
@property (nonatomic,strong) UILabel *titleLabel;
/**
 *  回复数
 */
@property (nonatomic,strong) UILabel *replyLabel;
/**
 *  描述
 */
@property (nonatomic,strong) UILabel *descLabel;

@property (nonatomic,strong) LMNews *news;

@end
