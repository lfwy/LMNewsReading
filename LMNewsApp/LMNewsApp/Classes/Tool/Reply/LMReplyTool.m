//
//  LMReplyTool.m
//  LMNewsApp
//
//  Created by tarena on 16/1/23.
//  Copyright © 2016年 lim. All rights reserved.
//

#import "LMReplyTool.h"
#import "LMHttpTool.h"
#import "LMReply.h"

@implementation LMReplyTool

+ (void)replyFromSeverWithUrlString:(NSString *)url success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    [LMHttpTool GET:url parameters:nil success:^(id responseObject) {
        
        NSMutableArray *mutableArray = [NSMutableArray array];
        if (responseObject[@"hotPosts"] != [NSNull null]) {
            NSArray *dictarray = responseObject[@"hotPosts"];
            for (int i = 0; i < dictarray.count; i++) {
                NSDictionary *dict = dictarray[i][@"1"];
                LMReply *reply = [[LMReply alloc]init];
                reply.name = dict[@"n"];
                if (reply.name == nil) {
                    reply.name = @"火星网友";
                }
                reply.address = dict[@"f"];
                reply.say = dict[@"b"];
                reply.suppose = dict[@"v"];
                [mutableArray addObject:reply];
            }
        }
        if (success) {
            success([mutableArray copy]);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
