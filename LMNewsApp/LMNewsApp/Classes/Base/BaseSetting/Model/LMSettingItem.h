//
//  LMSettingItem.h
//  李明微博
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 lim. All rights reserved.
//  描述每一行的cell长什么样

#import <Foundation/Foundation.h>

@class LMCheckItem;
@interface LMSettingItem : NSObject
/**
 *  描述imageView
 */
@property (nonatomic,strong) UIImage *image;
/**
 *  描述textLabel
 */
@property (nonatomic,copy) NSString *title;
/**
 *  描述detailLabel
 */
@property (nonatomic,copy) NSString *subTitle;
/**
 *  保存每一行需要做的事情
 */
@property (nonatomic,copy) void(^option)(LMCheckItem *item);

/**
 *  跳转到控制器的类名
 */
@property (nonatomic, assign) Class destVCClass;

+ (instancetype)itemWithTitle:(NSString *)title;

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image;

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(UIImage *)image;

@end
