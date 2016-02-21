//
//  LMPhotoView.m
//  LMNewsApp
//
//  Created by tarena on 16/1/25.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMPhotoView.h"

@implementation LMPhotoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpAllChildViews];
    }
    return self;
}

- (void)setUpAllChildViews {
    self.photoScrollView = [[UIScrollView alloc]init];
    [self addSubview:self.photoScrollView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, LMScreenH-160, LMScreenW-90, 40)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    
    self.countLabel = [[UILabel alloc]initWithFrame:CGRectMake(LMScreenW-90, LMScreenH-160, 90, 40)];
    self.countLabel.font = [UIFont boldSystemFontOfSize:20];
    self.countLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.countLabel];
    
    self.descLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame)+10, LMScreenW-40, 60)];
    self.descLabel.font = [UIFont systemFontOfSize:17];
    self.descLabel.numberOfLines = 2;
    self.descLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.descLabel];
    
    self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(LMScreenW-140, CGRectGetMaxY(self.descLabel.frame)+10, 40, 40)];
    self.leftImageView.contentMode = UIViewContentModeCenter;
    self.leftImageView.image = [UIImage imageNamed:@"top_navigation_more"];
    [self addSubview:self.leftImageView];
    
    self.middleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(LMScreenW-90, CGRectGetMaxY(self.descLabel.frame)+10, 40, 40)];
    self.middleImageView.contentMode = UIViewContentModeCenter;
    self.middleImageView.image = [UIImage imageNamed:@"weather_share"];
    [self addSubview:self.middleImageView];
    
    self.rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(LMScreenW-40, CGRectGetMaxY(self.descLabel.frame)+10, 40, 40)];
    self.rightImageView.contentMode = UIViewContentModeCenter;
    self.rightImageView.image = [UIImage imageNamed:@"icon_star"];
    [self addSubview:self.rightImageView];
}

@end
