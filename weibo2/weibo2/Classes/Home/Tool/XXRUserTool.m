//
//  XXRUserTool.m
//  weibo2
//
//  Created by rgc on 15/11/1.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRUserTool.h"
#import "XXRHttpTool.h"
#import "MJExtension.h"

@implementation XXRUserTool

+ (void)userInfoWithParam:(XXRUserInfoParam *)param success:(void (^)(XXRUserInfoResult *result))success failure:(void (^)(NSError *error))failure {
    [XXRHttpTool getWithURL:@"https://api.weibo.com/2/users/show.json" params:param.keyValues success:^(id json) {
        if (success) {
            XXRUserInfoResult *result = [XXRUserInfoResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userUnreadWithParam:(XXRUserUnreadCountParam *)param success:(void (^)(XXRUserUnreadCountResult *result))success failure:(void (^)(NSError *error))failure {
    [XXRHttpTool getWithURL:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:param.keyValues success:^(id json) {
        if (success) {
            XXRUserUnreadCountResult *result = [XXRUserUnreadCountResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
