//
//  XXRBaseParam.m
//  weibo2
//
//  Created by rgc on 15/11/1.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRBaseParam.h"
#import "XXRAccount.h"
#import "XXRAccountTool.h"

@implementation XXRBaseParam

- (id)init {
    if (self = [super init]) {
        self.access_token = [XXRAccountTool account].access_token;
    }
    
    return self;
}

//- (NSString *)access_token {
//    if (_access_token) {
//        _access_token = [[XXRAccountTool account].access_token copy];
//    }
//    return _access_token;
//}

+ (id)param {
    return [[self alloc] init];
}

@end
