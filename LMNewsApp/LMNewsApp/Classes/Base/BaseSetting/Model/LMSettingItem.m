//
//  LMSettingItem.m
//  李明微博
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMSettingItem.h"

@implementation LMSettingItem

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(UIImage *)image {
    LMSettingItem *item = [[self alloc]init];
    item.title = title;
    item.subTitle = subTitle;
    item.image = image;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image {
    return [self itemWithTitle:title subTitle:nil image:image];
}

+ (instancetype)itemWithTitle:(NSString *)title {
    return [self itemWithTitle:title subTitle:nil image:nil];
}

@end
