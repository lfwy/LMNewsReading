//
//  LMSettingCell.h
//  李明微博
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 lim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMSettingItem.h"

@interface LMSettingCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) LMSettingItem *item;

@end
