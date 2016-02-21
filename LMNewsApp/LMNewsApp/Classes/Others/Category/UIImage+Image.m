//
//  UIImage+Image.m
//  李明微博
//
//  Created by tarena on 16/1/7.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

+ (instancetype)imageWithOriginalName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
