//
//  LMPhotoDetail.m
//  LMNewsApp
//
//  Created by tarena on 16/1/25.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMPhotoDetail.h"

@implementation LMPhotoDetail

+ (instancetype)photoDetailWithDict:(NSDictionary *)dict {
    LMPhotoDetail *photoDetail = [[LMPhotoDetail alloc]init];
    [photoDetail setValuesForKeysWithDictionary:dict];
    return photoDetail;
}

@end
