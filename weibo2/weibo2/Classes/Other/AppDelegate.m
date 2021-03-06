//
//  AppDelegate.m
//  weibo2
//
//  Created by rgc on 15/8/11.
//  Copyright (c) 2015年 rgc. All rights reserved.
//

#import "AppDelegate.h"
#import "XXRTabBarViewController.h"
#import "XXROAuthController.h"
#import "XXRNewfeatureViewController.h"

#import "XXRAccount.h"
#import "XXRWeiboTool.h"
#import "XXRAccountTool.h"

#import <SDWebImage/SDWebImageManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];

    // 1.先判断有无存储账号信息
    XXRAccount *account = [XXRAccountTool account];
    
    if (account) { // 登录成功
        [XXRWeiboTool chooseRootViewController];
    } else {    // 之前没有登录成功
        self.window.rootViewController = [[XXROAuthController alloc] init];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

/**
 *  app进入后台会调用这个方法
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"进入后台运行----");
    // 在后台开启任务让程序持续保持运行状态（能保持运行的时间是不确定）
    [application beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"过期了----");
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    
    // 停止下载图片
    [[SDWebImageManager sharedManager] cancelAll];
    
    // 清除内存中的图片
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

@end
