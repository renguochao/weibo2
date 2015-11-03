//
//  XXRAccountTool.h
//  weibo2
//
//  Created by rgc on 15/9/30.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXRAccount.h"
#import "XXRAuthParam.h"
#import "XXRAuthResult.h"

@interface XXRAccountTool : NSObject

+ (void)saveAccount:(XXRAccount *)account;
+ (XXRAccount *)account;


+ (void)authWithParam:(XXRAuthParam *)param success:(void (^)(XXRAuthResult *result))success failure:(void (^)(NSError *error))failure;
@end
