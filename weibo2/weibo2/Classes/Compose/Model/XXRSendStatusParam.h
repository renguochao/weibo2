//
//  XXRSendStatusParam.h
//  weibo2
//
//  Created by rgc on 15/10/29.
//  Copyright © 2015年 rgc. All rights reserved.
//  封装发送微博数据的参数

#import <Foundation/Foundation.h>
#import "XXRBaseParam.h"

@interface XXRSendStatusParam : XXRBaseParam
/**
 *  要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
 */
@property (nonatomic, copy) NSString *status;
@end
