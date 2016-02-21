//
//  LMDetailNews.m
//  LMNewsApp
//
//  Created by tarena on 16/1/21.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMDetailNews.h"
#import "LMDetailImage.h"

@implementation LMDetailNews

/** 便利构造器 */
+ (instancetype)detailWithDict:(NSDictionary *)dict
{
    LMDetailNews *detail = [[self alloc]init];
    detail.title = dict[@"title"];
    detail.ptime = dict[@"ptime"];
    detail.body = dict[@"body"];
    
    NSArray *imgArray = dict[@"img"];
    NSMutableArray *temArray = [NSMutableArray arrayWithCapacity:imgArray.count];
    
    for (NSDictionary *dict in imgArray) {
        LMDetailImage *image = [LMDetailImage detailImgWithDict:dict];
        [temArray addObject:image];
    }
    detail.img = temArray;

    return detail;
}

@end
