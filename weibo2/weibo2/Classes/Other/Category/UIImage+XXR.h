//
//  UIImage+XXR.h
//  weibo2
//
//  Created by rgc on 15/8/11.
//  Copyright (c) 2015年 rgc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XXR)
/**
 *  加载图片
 *
 *  @param name 图片名
 *
 *  @return 图片对象
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  拉伸图片
 *
 *  @param name 图片名
 *
 *  @return 拉伸后的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;

@end
