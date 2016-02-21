//
//  LMPhotoTool.h
//  LMNewsApp
//
//  Created by tarena on 16/1/25.
//  Copyright © 2016年 lim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMPhoto.h"

@interface LMPhotoTool : NSObject

/**
 *  请求照片信息
 *
 *  @param url 请求网址
 *  @param success 请求成功时回调
 *  @param failure 请求失败时回调 错误传递给外界
 */

+ (void)photoFromSeverWithUrlString:(NSString *)url success:(void(^)(LMPhoto *photo))success failure:(void(^)(NSError *error))failure;

@end
