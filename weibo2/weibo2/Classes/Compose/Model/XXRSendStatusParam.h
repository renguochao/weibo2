//
//  XXRSendStatusParam.h
//  weibo2
//
//  Created by rgc on 15/10/29.
//  Copyright © 2015年 rgc. All rights reserved.
//  封装发送微博数据的参数

#import <Foundation/Foundation.h>

@interface XXRSendStatusParam : NSObject
/**
 *  采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 */
@property (nonatomic, copy) NSString *access_token;

/**
 *  要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
 */
@property (nonatomic, copy) NSString *status;
@end
