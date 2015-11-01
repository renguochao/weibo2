//
//  XXRStatusTool.h
//  weibo2
//
//  Created by rgc on 15/10/29.
//  Copyright © 2015年 rgc. All rights reserved.
//  微博业务处理类（工具类）

#import <Foundation/Foundation.h>
#import "XXRHomeStatusesParam.h"
#import "XXRHomeStatusesResult.h"
#import "XXRSendStatusParam.h"
#import "XXRSendStatusResult.h"

@interface XXRStatusTool : NSObject
/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)homeStatusWithParam:(XXRHomeStatusesParam *)param success:(void (^)(XXRHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一条微博
 */
+ (void)sendStatusWithParam:(XXRSendStatusParam *)param success:(void (^)(XXRSendStatusResult *result))success failure:(void (^)(NSError *error))failure;
@end
