//
//  XXRAccount.m
//  weibo2
//
//  Created by rgc on 15/9/30.
//  Copyright © 2015年 rgc. All rights reserved.
//  

#import "XXRAccount.h"

@interface XXRAccount() <NSCoding>

@end

@implementation XXRAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        // KVC
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

/**
 *  从文件中解析对象的时候调用
 */
- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expiresTime = [decoder decodeObjectForKey:@"expiresTime"];
        self.expires_in = [decoder decodeInt64ForKey:@"expires_in"];
        self.remind_in = [decoder decodeInt64ForKey:@"remind_in"];
        self.uid = [decoder decodeInt64ForKey:@"uid"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 *
 */
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expiresTime forKey:@"expiresTime"];
    [encoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [encoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [encoder encodeInt64:self.uid forKey:@"uid"];
}

@end
