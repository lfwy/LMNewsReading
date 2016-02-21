//
//  LMBadgeItem.h
//  李明微博
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 lim. All rights reserved.
//  带badge的Cell模型

#import "LMSettingItem.h"

@interface LMBadgeItem : LMSettingItem

/**
 *  设置badge的值
 */
@property (nonatomic,copy) NSString *badgeValue;

@end
