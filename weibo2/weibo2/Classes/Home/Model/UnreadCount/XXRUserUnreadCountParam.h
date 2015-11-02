//
//  XXRUserUnreadCountParam.h
//  weibo2
//
//  Created by rgc on 15/11/1.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXRBaseParam.h"

@interface XXRUserUnreadCountParam :XXRBaseParam
/**
 *  需要获取消息未读数的用户UID
 */
@property (nonatomic, strong) NSNumber *uid;
@end
