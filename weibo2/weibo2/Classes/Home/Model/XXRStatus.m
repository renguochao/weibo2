//
//  XXRStatus.m
//  weibo2
//
//  Created by rgc on 15/10/1.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRStatus.h"
#import "NSDate+XXR.h"
#import "XXRPhoto.h"
#import "MJExtension.h"

@implementation XXRStatus

- (NSString *)created_at {
    // 1.获得微博发送时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    // 设置时区，保证格式化字符串有效
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *createdDate = [fmt dateFromString:_created_at];
    
    // 2.判断微博发送时间和现在时间差距
    if ([createdDate isToday]) {
        NSDateComponents *comps = [createdDate deltaWithNow];
        if (comps.hour >= 1) {
            return [NSString stringWithFormat:@"%ld小时前", (long)comps.hour];
        } else if (comps.minute >= 1) {
            return [NSString stringWithFormat:@"%ld分钟前", (long)comps.minute];
        } else {
            return @"刚刚";
        }
        
    } else if ([createdDate isYestoday]) {
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    } else if ([createdDate isThisYear]) {
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
    
}

/**
 *  来源只需计算一次，在字典转模型的时候设置一次即可
 */
- (void)setSource:(NSString *)source {
    //<a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
    NSUInteger loc = [source rangeOfString:@">"].location + 1;
    NSUInteger len = [source rangeOfString:@"</"].location - loc;
    NSString *newString = [source substringWithRange:NSMakeRange(loc, len)];
    _source = [NSString stringWithFormat:@"来自 %@", newString];
}


//+ (id)statusWithDict:(NSDictionary *)dict {
//    return [[self alloc] initWithDict:dict];
//}
//
//- (id)initWithDict:(NSDictionary *)dict {
//    self = [super init];
//    if (self) {
//        self.text = dict[@"text"];
//        self.source = dict[@"source"];
//        self.idstr = dict[@"id"];
//        self.reposts_count = [dict[@"source"] intValue];
//        self.comments_count = [dict[@"comments_count"] intValue];
//        self.user = [XXRUser userWithDict:dict[@"user"]];
//    }
//    return self;
//}

@end
