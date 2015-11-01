//
//  XXRHomeStatusesResult.m
//  weibo2
//
//  Created by rgc on 15/10/29.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRHomeStatusesResult.h"
#import <MJExtension/MJExtension.h>

@implementation XXRHomeStatusesResult

+ (NSDictionary *)objectClassInArray {
    return @{
             @"statuses" : @"XXRStatus"
             };
}

@end
