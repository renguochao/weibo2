//
//  XXRStatusCacheTool.h
//  weibo2
//
//  Created by rgc on 15/11/2.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXRHomeStatusesParam.h"

@interface XXRStatusCacheTool : NSObject

/**
 *  缓存一条微博数据
 */
+ (void)addStatus:(NSDictionary *)dict;

/**
 *  缓存N条微博数据
 */
+ (void)addStatuses:(NSArray *)dictArray;

/**
 *  根据请求参数获得微博数据
 *
 *  @param param 请求参数
 *
 *  @return 字典数组
 */
+ (NSArray *)statusesWithParam:(XXRHomeStatusesParam *)param;

@end
