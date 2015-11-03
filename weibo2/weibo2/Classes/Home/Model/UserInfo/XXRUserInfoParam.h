//
//  XXRUserInfoParam.h
//  weibo2
//
//  Created by rgc on 15/10/29.
//  Copyright © 2015年 rgc. All rights reserved.
//  封装加载用户信息的参数

#import <Foundation/Foundation.h>
#import "XXRBaseParam.h"

@interface XXRUserInfoParam : XXRBaseParam
/**
 *  需要查询的用户ID
 */
@property (nonatomic, assign) NSNumber *uid;
/**
 *  需要查询的用户昵称
 */
@property (nonatomic, copy) NSString *screen_name;
@end
