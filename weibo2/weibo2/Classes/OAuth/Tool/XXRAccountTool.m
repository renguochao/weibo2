//
//  XXRAccountTool.m
//  weibo2
//
//  Created by rgc on 15/9/30.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRAccountTool.h"
#import "XXRHttpTool.h"
#import "MJExtension.h"
#import "Common.h"

#define XXRAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation XXRAccountTool

/**
 *  存储账号信息
 */
+ (void)saveAccount:(XXRAccount *)account {
    account.expiresTime = [[NSDate date] dateByAddingTimeInterval:account.expires_in];
    [NSKeyedArchiver archiveRootObject:account toFile:XXRAccountFile];
}

/**
 *  读取保存的账号信息
 */
+ (XXRAccount *)account {
    
    XXRAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:XXRAccountFile];
    
    NSDate *now = [NSDate date];
//  NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending
    if ([now compare:account.expiresTime] == NSOrderedDescending) {
        return nil;
    } else {
        return account;
    }
}

+ (void)authWithParam:(XXRAuthParam *)param success:(void (^)(XXRAuthResult *result))success failure:(void (^)(NSError *error))failure {
    // 1.发送请求
    [XXRHttpTool postWithURL:@"https://api.weibo.com/oauth2/access_token" params:param.keyValues success:^(id json) {
        if (success) {
            XXRAuthResult *result = [XXRAuthResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
@end
