//
//  XXRTabBarViewController.m
//  weibo2
//
//  Created by rgc on 15/8/11.
//  Copyright (c) 2015年 rgc. All rights reserved.
//

#import "XXRTabBarViewController.h"
#import "XXRHomeViewController.h"
#import "XXRDiscoverViewController.h"
#import "XXRMessageViewController.h"
#import "XXRMeViewController.h"

@interface XXRTabBarViewController ()

@end

@implementation XXRTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化所有的子控制器
    
    // 1.首页
    XXRHomeViewController *home = [[XXRHomeViewController alloc] init];
    home.view.backgroundColor = [UIColor redColor];
    home.title = @"首页"; // 设置title属性等于下方两个设置
//    home.tabBarItem.title = @"首页";
//    home.navigationItem.title = @"首页";
    home.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
    home.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]; //告诉iOS不要渲染图片
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:home];
    [self addChildViewController:homeNav];
    
    // 2.消息
    XXRMessageViewController *message = [[XXRMessageViewController alloc] init];
    message.view.backgroundColor = [UIColor blueColor];
    message.title = @"消息";
//    message.tabBarItem.title = @"消息";
    message.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center"];
    message.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_message_center_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *messageNav = [[UINavigationController alloc] initWithRootViewController:message];
    [self addChildViewController:messageNav];
    
    // 3.广场
    XXRDiscoverViewController *discover = [[XXRDiscoverViewController alloc] init];
    discover.view.backgroundColor = [UIColor blackColor];
    discover.title = @"广场";
//    discover.tabBarItem.title = @"广场";
    discover.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
    discover.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_discover_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *discoverNav = [[UINavigationController alloc] initWithRootViewController:discover];
    [self addChildViewController:discoverNav];
    
    // 4.我
    XXRMeViewController *me = [[XXRMeViewController alloc] init];
    me.view.backgroundColor = [UIColor grayColor];
    me.title = @"我";
//    me.tabBarItem.title = @"我";
    me.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile"];
    me.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_profile_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *meNav = [[UINavigationController alloc] initWithRootViewController:me];
    [self addChildViewController:meNav];
}



@end
