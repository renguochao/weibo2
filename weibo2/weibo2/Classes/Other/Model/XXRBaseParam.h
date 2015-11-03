//
//  XXRBaseParam.h
//  weibo2
//
//  Created by rgc on 15/11/1.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXRBaseParam : NSObject
/**
 *  采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得
 */
@property (nonatomic, copy) NSString *access_token;


+ (id)param;
@end
