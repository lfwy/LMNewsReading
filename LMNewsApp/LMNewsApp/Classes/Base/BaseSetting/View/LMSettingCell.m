//
//  LMSettingCell.m
//  李明微博
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMSettingCell.h"
#import "LMBaseSetting.h"
#import "LMBadgeView.h"

@interface LMSettingCell ()
//箭头
@property (nonatomic,strong) UIImageView *arrowView;
//badgeView
@property (nonatomic,strong) LMBadgeView *badgeView;
//开关
@property (nonatomic,strong) UISwitch *switchView;
//对勾
@property (nonatomic,strong) UIImageView *checkView;
/**
 *  中央label 可用weak 要加载到视图上
 */
@property (nonatomic,strong) UILabel *label;

@end

@implementation LMSettingCell

- (UIImageView *)arrowView {
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _arrowView;
}

- (LMBadgeView *)badgeView {
    if (!_badgeView) {
        _badgeView = [LMBadgeView buttonWithType:UIButtonTypeCustom];
    }
    return _badgeView;
}

- (UISwitch *)switchView {
    if (!_switchView) {
        _switchView = [[UISwitch alloc]init];
    }
    return _switchView;
}

- (UIImageView *)checkView {
    if (!_checkView) {
        _checkView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_icon_checkmark"]];
    }
    return _checkView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.font = [UIFont boldSystemFontOfSize:17];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor redColor];
    }
    return _label;
}
    


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"cell";
    
    LMSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;
}

- (void)setItem:(LMSettingItem *)item {
    _item = item;
    
    //设置内容
    [self setUpData];
    //设置右边视图
    [self setUpRightView];
    
    if ([_item isKindOfClass:[LMLabelItem class]]) {//是labelItem就加载到cell上
        //设置label
        LMLabelItem *labelItem = (LMLabelItem *)_item;
        self.label.text = labelItem.text;
        [self addSubview:self.label];
    }else {//不是就移除
        [_label removeFromSuperview];
    }
}
/**
 *  设置内容
 */
- (void)setUpData {
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.subTitle;
    self.imageView.image = _item.image;
}
/**
 *  设置右边视图
 */
- (void)setUpRightView {
    //模型决定cell样式
    if ([_item isKindOfClass:[LMArrowItem class]]) {//箭头
        self.accessoryView = self.arrowView;
    }else if ([_item isKindOfClass:[LMBadgeItem class]]) {//badge
        LMBadgeItem *item = (LMBadgeItem *)_item;
        self.badgeView.badgeValue = item.badgeValue;
        self.accessoryView = self.badgeView;
    }else if ([_item isKindOfClass:[LMSwitchItem class]]) {//开关
        self.accessoryView = self.switchView;
    }else if ([_item isKindOfClass:[LMCheckItem class]]) {//对勾
        LMCheckItem *checkItem = (LMCheckItem *)_item;
        if (checkItem.check) {
            self.accessoryView = self.checkView;
        }else {
            self.accessoryView = nil;
        }
    }else {
        self.accessoryView = nil;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.label.frame = self.bounds;
}

@end
