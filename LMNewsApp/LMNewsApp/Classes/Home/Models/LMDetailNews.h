//
//  LMDetailNews.h
//  LMNewsApp
//
//  Created by tarena on 16/1/21.
//  Copyright © 2016年 lim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMDetailNews : NSObject

/** 新闻标题 */
@property (nonatomic, copy) NSString *title;
/** 新闻发布时间 */
@property (nonatomic, copy) NSString *ptime;
/** 新闻内容 */
@property (nonatomic, copy) NSString *body;
/** 新闻配图(希望这个数组中以后放HMNewsDetailImg模型) */
@property (nonatomic, strong) NSArray *img;

+ (instancetype)detailWithDict:(NSDictionary *)dict;

@end
