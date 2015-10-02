//
//  NSDate+XXR.h
//  weibo2
//
//  Created by rgc on 15/10/2.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XXR)

- (BOOL)isToday;

- (BOOL)isYestoday;

- (BOOL)isThisYear;

/**
 *  获得self与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

@end
