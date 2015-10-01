//
//  XXRAccountTool.h
//  weibo2
//
//  Created by rgc on 15/9/30.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXRAccount.h"

@interface XXRAccountTool : NSObject

+ (void)saveAccount:(XXRAccount *)account;
+ (XXRAccount *)account;

@end
