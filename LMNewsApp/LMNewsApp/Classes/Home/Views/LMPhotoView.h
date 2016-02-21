//
//  LMPhotoView.h
//  LMNewsApp
//
//  Created by tarena on 16/1/25.
//  Copyright © 2016年 lim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMPhotoView : UIView

@property (nonatomic,strong) UIScrollView *photoScrollView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *descLabel;
@property (nonatomic,strong) UILabel *countLabel;
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UIImageView *middleImageView;
@property (nonatomic,strong) UIImageView *rightImageView;

@end
