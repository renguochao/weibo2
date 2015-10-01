//
//  XXRStatus.m
//  weibo2
//
//  Created by rgc on 15/10/1.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRStatus.h"

@implementation XXRStatus

+ (id)statusWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.text = dict[@"text"];
        self.source = dict[@"source"];
        self.idStr = dict[@"id"];
        self.reposts_count = [dict[@"source"] intValue];
        self.comments_count = [dict[@"comments_count"] intValue];
        self.user = [XXRUser userWithDict:dict[@"user"]];
    }
    return self;
}

@end
