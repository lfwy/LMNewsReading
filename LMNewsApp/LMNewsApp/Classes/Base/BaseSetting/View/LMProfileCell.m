//
//  LMProfileCell.m
//  李明微博
//
//  Created by tarena on 16/1/18.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMProfileCell.h"

@implementation LMProfileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 5;
}

@end
