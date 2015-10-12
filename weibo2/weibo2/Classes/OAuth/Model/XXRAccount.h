//
//  XXRAccount.h
//  weibo2
//
//  Created by rgc on 15/9/30.
//  Copyright © 2015年 rgc. All rights reserved.
//  账号模型

#import <Foundation/Foundation.h>

@interface XXRAccount : NSObject

@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, strong) NSDate *expiresTime;
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
@property (nonatomic, assign) long long uid;

/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
