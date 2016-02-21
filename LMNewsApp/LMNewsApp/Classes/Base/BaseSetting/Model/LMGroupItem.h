//
//  LMGroupItem.h
//  李明微博
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 lim. All rights reserved.
//  描述每一组长什么样子

#import <Foundation/Foundation.h>

@interface LMGroupItem : NSObject
/**
 *  一组有多少行cell(LMSettingItem)
 */
@property (nonatomic,strong) NSArray *items;
/**
 *  头部标题
 */
@property (nonatomic,copy) NSString *headerTitle;
/**
 *  尾部标题
 */
@property (nonatomic,copy) NSString *footerTitle;

@end
