//
//  NSDate+XXR.m
//  weibo2
//
//  Created by rgc on 15/10/2.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "NSDate+XXR.h"

@implementation NSDate (XXR)

/**
 *  是否今天
 */
- (BOOL)isToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    // 1.获取当前时间的年月日
    NSDateComponents *nowComps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获取self的年月日
    NSDateComponents *selfComps = [calendar components:unit fromDate:self];
    
    return (selfComps.year == nowComps.year) &&
           (selfComps.month == nowComps.month) &&
           (selfComps.day == nowComps.day);
}

/**
 *  是否昨天
 */
- (BOOL)isYestoday {
    return NO;
}

/**
 *  是否今年
 */
- (BOOL)isThisYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    // 1.获取当前时间的年月日
    NSDateComponents *nowComps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获取self的年月日
    NSDateComponents *selfComps = [calendar components:unit fromDate:self];
    
    return (selfComps.year == nowComps.year);
}

/**
 *  获得self与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

@end
