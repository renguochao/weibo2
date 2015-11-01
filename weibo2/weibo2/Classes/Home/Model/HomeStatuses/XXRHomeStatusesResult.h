//
//  XXRHomeStatusesResult.h
//  weibo2
//
//  Created by rgc on 15/10/29.
//  Copyright © 2015年 rgc. All rights reserved.
//  封装加载首页微博数据的返回结果

#import <Foundation/Foundation.h>

//"previous_cursor": 0,                   // 暂未支持
//"next_cursor": 11488013766,    // 暂未支持
//"total_number": 81655

@interface XXRHomeStatusesResult : NSObject
/**
 *  statuses数组里面放的都是IWStatus模型
 */
@property (nonatomic, strong) NSArray *statuses;

@property (nonatomic, assign) long long previous_cursor;
@property (nonatomic, assign) long long next_cursor;

/**
 *  总数
 */
@property (nonatomic, assign) long long total_number;

@end
