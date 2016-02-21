//
//  LMPhoto.m
//  LMNewsApp
//
//  Created by tarena on 16/1/25.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMPhoto.h"
#import "LMPhotoDetail.h"

@implementation LMPhoto

+ (instancetype)photoWith:(NSDictionary *)dict {
    LMPhoto *photo = [[LMPhoto alloc]init];
    [photo setValuesForKeysWithDictionary:dict];
    
    NSArray *photoArray = photo.photos;
    NSMutableArray *photos = [NSMutableArray array];
    for (NSDictionary *dict in photoArray) {
        LMPhotoDetail *photoDetail = [LMPhotoDetail photoDetailWithDict:dict];
        [photos addObject:photoDetail];
    }
    photo.photos = photos;
    return photo;
}

@end
