//
//  LMHttpTool.m
//  LMNewsApp
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMHttpTool.h"
#import "AFNetworking.h"

@implementation LMHttpTool

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    //创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //先把请求成功要做的事情，保存到这个代码块
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //先把请求失败要做的事情，保存到这个代码块
        if (failure) {
            failure(error);
            
        }
    }];
    
}

@end
