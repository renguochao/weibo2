//
//  XXRWeiboTool.m
//  weibo2
//
//  Created by rgc on 15/9/30.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRWeiboTool.h"
#import "XXRTabBarViewController.h"
#import "XXRNewfeatureViewController.h"

@implementation XXRWeiboTool

+ (void)chooseRootViewController {
    NSString *key = @"CFBundleVersion";
    
    // 取出沙盒中存储的上次使用软件的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        // 显示状态栏
        [UIApplication sharedApplication].statusBarHidden = NO;
        [UIApplication sharedApplication].keyWindow.rootViewController = [[XXRTabBarViewController alloc] init];
    } else {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[XXRNewfeatureViewController alloc] init];
        // 存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
}

@end
