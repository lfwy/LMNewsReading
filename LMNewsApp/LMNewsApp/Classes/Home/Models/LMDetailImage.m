//
//  LMDetailImage.m
//  LMNewsApp
//
//  Created by tarena on 16/1/21.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMDetailImage.h"

@implementation LMDetailImage

/** 便利构造器方法 */
+ (instancetype)detailImgWithDict:(NSDictionary *)dict
{
    LMDetailImage *image = [[self alloc]init];
    image.ref = dict[@"ref"];
    image.pixel = dict[@"pixel"];
    image.src = dict[@"src"];
    
    return image;
}

@end
