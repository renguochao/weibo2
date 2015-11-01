//
//  XXRStatusTool.m
//  weibo2
//
//  Created by rgc on 15/10/29.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRStatusTool.h"
#import "XXRHttpTool.h"
#import "XXRStatus.h"
#import "XXRPhoto.h"
#import <MJExtension/MJExtension.h>

@implementation XXRStatusTool

+ (void)homeStatusWithParam:(XXRHomeStatusesParam *)param success:(void (^)(XXRHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure {
    [XXRHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.keyValues success:^(id json) {
        if (success) {
            // 将字典数组转换成模型数组
            XXRHomeStatusesResult *result = [XXRHomeStatusesResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)sendStatusWithParam:(XXRSendStatusParam *)param success:(void (^)(XXRSendStatusResult *result))success failure:(void (^)(NSError *error))failure {
    [XXRHttpTool postWithURL:@"https://api.weibo.com/2/statuses/update.json" params:param.keyValues success:^(id json) {
        if (success) {
            // 将字典数组转换成模型数组
            XXRSendStatusResult *result = [XXRSendStatusResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
