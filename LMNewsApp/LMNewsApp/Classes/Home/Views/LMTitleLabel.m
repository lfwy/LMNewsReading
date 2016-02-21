//
//  LMTitleLabel.m
//  LMNewsApp
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMTitleLabel.h"

@implementation LMTitleLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:18];
        
        self.scale = 0.0;
        
    }
    return self;
}

/** 通过scale的改变改变多种参数 */
- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    self.textColor = [UIColor colorWithRed:scale green:0.0 blue:0.0 alpha:1];
    
    CGFloat minScale = 0.7;
    CGFloat trueScale = minScale + (1-minScale)*scale;
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
}

@end
