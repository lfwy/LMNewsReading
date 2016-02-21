//
//  LMNewsTool.h
//  LMNewsApp
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 lim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMNewsTool : NSObject

/**
 *  请求更久的微博数据
 *
 *  @param index 请求数据条数起点
 *  @param urlString 板块代表字符串
 *  @param success 请求成功时回调
 *  @param failure 请求失败时回调 错误传递给外界
 */

+ (void)newsFromSeverWithIndex:(NSInteger)index urlString:(NSString *)urlString success:(void(^)(NSMutableArray *newses))success failure:(void(^)(NSError *error))failure;

/**
 *  请求详细信息
 *
 *  @param docid 详细信息参数
 *  @param success 请求成功时回调
 *  @param failure 请求失败时回调 错误传递给外界
 */

+ (void)detailNewsFromSeverWithDocid:(NSString *)docid success:(void(^)(NSDictionary *responseObject))success failure:(void(^)(NSError *error))failure;

@end
