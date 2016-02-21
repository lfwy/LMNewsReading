//
//  LMPhotoTool.m
//  LMNewsApp
//
//  Created by tarena on 16/1/25.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMPhotoTool.h"
#import "LMHttpTool.h"
#import "MJExtension.h"

@implementation LMPhotoTool

+ (void)photoFromSeverWithUrlString:(NSString *)url success:(void (^)(LMPhoto *))success failure:(void (^)(NSError *))failure {
    [LMHttpTool GET:url parameters:nil success:^(id responseObject) {
        LMPhoto *photo = [LMPhoto mj_objectWithKeyValues:responseObject];
        if (success) {
            success(photo);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
