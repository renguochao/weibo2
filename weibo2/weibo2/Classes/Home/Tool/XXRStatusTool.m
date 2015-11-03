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
#import "XXRStatusCacheTool.h"

@implementation XXRStatusTool

+ (void)homeStatusWithParam:(XXRHomeStatusesParam *)param success:(void (^)(XXRHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure {
    
    // 1.从缓存中加载数据
    NSArray *dictArray = [XXRStatusCacheTool statusesWithParam:param];
    if (dictArray.count) {  // 有缓存
        // 传递了block
        if (success) {
            XXRHomeStatusesResult *result = [[XXRHomeStatusesResult alloc] init];
            result.statuses = [XXRStatus objectArrayWithKeyValuesArray:dictArray];
            
            success(result);
        }
    } else {
        [XXRHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.keyValues success:^(id json) {
            // 缓存数据
            [XXRStatusCacheTool addStatuses:json[@"statuses"]];
            
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
