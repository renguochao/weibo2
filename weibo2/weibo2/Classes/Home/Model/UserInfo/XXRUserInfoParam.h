//
//  XXRUserInfoParam.h
//  weibo2
//
//  Created by rgc on 15/10/29.
//  Copyright © 2015年 rgc. All rights reserved.
//  封装加载用户信息的参数

#import <Foundation/Foundation.h>

//access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
//uid	false	int64	需要查询的用户ID。
//screen_name	false	string	需要查询的用户昵称。

@interface XXRUserInfoParam : NSObject
/**
 *  采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  需要查询的用户ID
 */
@property (nonatomic, assign) long long uid;
/**
 *  需要查询的用户昵称
 */
@property (nonatomic, copy) NSString *screen_name;
@end
