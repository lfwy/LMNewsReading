//
//  LMReply.h
//  LMNewsApp
//
//  Created by tarena on 16/1/23.
//  Copyright © 2016年 lim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMReply : NSObject

/** 用户的姓名 */
@property(nonatomic,copy) NSString *name;
/** 用户的ip信息 */
@property(nonatomic,copy) NSString *address;
/** 用户的发言 */
@property(nonatomic,copy) NSString *say;
/** 用户的点赞 */
@property(nonatomic,copy) NSString *suppose;

@end
