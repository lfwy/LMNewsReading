//
//  UIImage+Image.h
//  李明微博
//
//  Created by tarena on 16/1/7.
//  Copyright © 2016年 lim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)
//instancetype默认会识别当前是哪个类或者对象调用，就会转换成响应的类的对象
//加载最原始的图片，没有渲染
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

@end
