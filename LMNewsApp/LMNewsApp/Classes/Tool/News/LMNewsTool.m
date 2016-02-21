//
//  LMNewsTool.m
//  LMNewsApp
//
//  Created by tarena on 16/1/19.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMNewsTool.h"
#import "LMHttpTool.h"
#import "LMNews.h"
#import "MJExtension.h"

@implementation LMNewsTool

+(void)newsFromSeverWithIndex:(NSInteger)index urlString:(NSString *)urlString success:(void (^)(NSMutableArray *))success failure:(void (^)(NSError *))failure {
    NSString *allUrlStr = [NSString stringWithFormat:@"http://c.m.163.com//nc/article/%@/%ld-20.html",urlString,index];
    [LMHttpTool GET:allUrlStr parameters:nil success:^(NSDictionary *responseObject) {
            //字典数组转模型数组
            NSString *key = [responseObject.keyEnumerator nextObject];
            NSArray *dictArray = responseObject[key];
            NSMutableArray *newses = [LMNews mj_objectArrayWithKeyValuesArray:dictArray];
        if (success) {
            success(newses);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)detailNewsFromSeverWithDocid:(NSString *)docid success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    NSString *allUrlStr = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",docid];
    
    [LMHttpTool GET:allUrlStr parameters:nil success:^(NSDictionary *responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
