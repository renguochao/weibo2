//
//  XXRUserTool.h
//  weibo2
//
//  Created by rgc on 15/11/1.
//  Copyright © 2015年 rgc. All rights reserved.
//  用户业务工具类

#import <Foundation/Foundation.h>
#import "XXRUserInfoParam.h"
#import "XXRUserInfoResult.h"
#import "XXRUserUnreadCountParam.h"
#import "XXRUserUnreadCountResult.h"

@interface XXRUserTool : NSObject

/**
 *  获取用户的信息
 *
 *  @param param   请求参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)userInfoWithParam:(XXRUserInfoParam *)param success:(void (^)(XXRUserInfoResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取用户各种信息未读数
 *
 *  @param param   请求参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)userUnreadWithParam:(XXRUserUnreadCountParam *)param success:(void (^)(XXRUserUnreadCountResult *result))success failure:(void (^)(NSError *error))failure;

@end
