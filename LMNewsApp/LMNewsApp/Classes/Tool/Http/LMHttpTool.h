//
//  LMHttpTool.h
//  LMNewsApp
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 lim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMHttpTool : NSObject

/**
 *  get请求 不需要返回值:1.用不到 2.返回网络数据有延迟，不会马上返回，只能通过block回调（接收到数据后再返回）
 *
 *  @param URLString  基本网址字符串
 *  @param parameters 拼接参数字典
 *  @param success    请求成功回调block
 *  @param failure    请求失败回调block
 *
 */
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
