//
//  XXRStatusCacheTool.m
//  weibo2
//
//  Created by rgc on 15/11/2.
//  Copyright © 2015年 rgc. All rights reserved.
//  管理微博缓存数据

#import "XXRStatusCacheTool.h"
#import <FMDB/FMDB.h>
#import "XXRAccountTool.h"

@implementation XXRStatusCacheTool

static FMDatabaseQueue *_queue;

+ (void)initialize {
    // 0.获得沙盒中的数据库文件名
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
    
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 2.建表
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement, access_token text, idstr text, status blob);"];
    }];
}


+ (void)addStatuses:(NSArray *)dictArray {
    for (NSDictionary *dict in dictArray) {
        [self addStatus:dict];
    }
}

+ (void)addStatus:(NSDictionary *)dict {
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.获得需要存储的数据
        NSString *access_token = [XXRAccountTool account].access_token;
        NSString *idstr = dict[@"idstr"];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
        
        // 2.存储数据
        [db executeUpdate:@"insert into t_status (access_token, idstr, status) values(?, ?, ?)", access_token, idstr, data];
    }];
}

+ (NSArray *)statusesWithParam:(XXRHomeStatusesParam *)param {
    // 1.定义数组
    __block NSMutableArray *dictArray = nil;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        dictArray = [NSMutableArray array];
        
        // accessToken
        NSString *accessToken = [XXRAccountTool account].access_token;
        
        FMResultSet *rs = nil;
        if (param.since_id) { // 如果有since_id
            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr > ? order by idstr desc limit 0,?;", accessToken, param.since_id, param.count];
        } else if (param.max_id) {  // 如果有max_id
            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr <= ? order by idstr desc limit 0,?;", accessToken, param.max_id, param.count];
        } else { // 如果没有since_id和max_id
            rs = [db executeQuery:@"select * from t_status where access_token = ? order by idstr desc limit 0,?;", accessToken, param.count];
        }
        
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"status"];
            NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [dictArray addObject:dict];
        }
    }];
    
    // 3.返回数据
    return dictArray;
}



@end
