//
//  LMReplyCell.m
//  LMNewsApp
//
//  Created by tarena on 16/1/23.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMReplyCell.h"

#define LM_INSET 8
#define LM_IMAGE_WIDTH 40
#define LM_IMAGE_HEIGHT 40
#define LM_USER_LABEL_HEIGHT 17
#define LM_SUB_LABEL_HEIGHT 15
#define LM_DESC_LABEL_HEIGHT 21
#define LM_SUPPOSE_WH 15

@interface LMReplyCell ()

@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subTitleLabel;
@property (nonatomic,strong) UILabel *descLabel;
@property (nonatomic,strong) UILabel *supposeLabel;
@property (nonatomic,strong) UIImageView *supposeImageView;

@end

@implementation LMReplyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllChildViews];
    }
    return self;
}

- (void)setUpAllChildViews {
    //添加缩略图
    CGFloat iconX = LM_INSET;
    CGFloat iconY = LM_INSET;
    CGFloat iconW = LM_IMAGE_WIDTH;
    CGFloat iconH = LM_IMAGE_HEIGHT;
    CGRect iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    _iconView = [[UIImageView alloc]initWithFrame:iconFrame];

    [self addSubview:_iconView];
    //添加用户名标题
    CGFloat titleX = LM_INSET + CGRectGetMaxX(iconFrame);
    CGFloat titleY = LM_INSET;
    CGFloat titleW = LMScreenW - titleX - 65;
    CGFloat titleH = LM_USER_LABEL_HEIGHT;
    CGRect titleFrame = CGRectMake(titleX, titleY, titleW, titleH);
    _titleLabel = [[UILabel alloc]initWithFrame:titleFrame];
    [self addSubview:_titleLabel];
    //添加ADDRESS
    CGFloat addX = LM_INSET + CGRectGetMaxX(iconFrame);
    CGFloat addY = LM_INSET + CGRectGetMaxY(titleFrame);
    CGFloat addW = LMScreenW - LM_IMAGE_HEIGHT - titleX;
    CGFloat addH = LM_SUB_LABEL_HEIGHT;
    CGRect addFrame = CGRectMake(addX, addY, addW, addH);
    _subTitleLabel = [[UILabel alloc]initWithFrame:addFrame];
    _subTitleLabel.textColor = [UIColor lightGrayColor];
    _subTitleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_subTitleLabel];
    //添加描述
    CGFloat descX = LM_INSET + CGRectGetMaxX(iconFrame);
    CGFloat descY = LM_INSET + CGRectGetMaxY(addFrame);
    CGFloat descW = LMScreenW - LM_IMAGE_HEIGHT - titleX;
    CGFloat descH = LM_DESC_LABEL_HEIGHT * 2;
    CGRect descFrame = CGRectMake(descX, descY, descW, descH);
    _descLabel = [[UILabel alloc]initWithFrame:descFrame];
    _descLabel.numberOfLines = -1;
    [self addSubview:_descLabel];
    
    //添加点赞图
    CGFloat supposeW = LM_SUPPOSE_WH;
    CGFloat supposeH = LM_SUPPOSE_WH;
    CGFloat supposeX = LMScreenW - LM_INSET - LM_SUPPOSE_WH;
    CGFloat supposeY = LM_INSET;
    CGRect supposeFrame = CGRectMake(supposeX, supposeY, supposeW, supposeH);
    _supposeImageView = [[UIImageView alloc]initWithFrame:supposeFrame];

    [self addSubview:_supposeImageView];
    
    //添加跟帖数
    CGFloat replyW = 40;
    CGFloat replyH = LM_SUPPOSE_WH;
    CGFloat replyX = CGRectGetMaxX(titleFrame);
    CGFloat replyY = LM_INSET;
    CGRect replyFrame = CGRectMake(replyX, replyY, replyW, replyH);
    _supposeLabel = [[UILabel alloc]initWithFrame:replyFrame];
    _supposeLabel.textAlignment = NSTextAlignmentRight;
    _supposeLabel.textColor = [UIColor lightGrayColor];
    _supposeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_supposeLabel];
}

- (void)setReply:(LMReply *)reply {
    _reply = reply;
    self.titleLabel.text = reply.name;
    self.iconView.image = [UIImage imageNamed:@"comment_profile_mars"];
    self.supposeImageView.image = [UIImage imageNamed:@"night_duanzi_up"];
    self.subTitleLabel.text = reply.address;
    NSRange rangeAddress = [reply.address rangeOfString:@"&nbsp"];
    if (rangeAddress.location != NSNotFound) {
        self.subTitleLabel.text = [reply.address substringToIndex:rangeAddress.location];
    }
    self.descLabel.text = reply.say;

    NSRange rangeSay = [reply.say rangeOfString:@"<br>"];
    if (rangeSay.location != NSNotFound) {
        NSMutableString *temSay = [reply.say mutableCopy];
        [temSay replaceOccurrencesOfString:@"<br>" withString:@"\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, temSay.length)];
        self.descLabel.text = temSay;
    }
    self.descLabel.width = 350;
    [self.descLabel sizeToFit];
    self.descLabel.height = self.descLabel.height + 10;
    self.height = CGRectGetMaxY(self.descLabel.frame);
    self.supposeLabel.text = reply.suppose;
}

@end
