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
    [self setupAllChildViewControllers];
}

- (void)setupAllChildViewControllers {
    // 1.首页
    XXRHomeViewController *home = [[XXRHomeViewController alloc] init];
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    // 2.消息
    XXRMessageViewController *message = [[XXRMessageViewController alloc] init];
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    // 3.广场
    XXRDiscoverViewController *discover = [[XXRDiscoverViewController alloc] init];
    [self setupChildViewController:discover title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    // 4.我
    XXRMeViewController *me = [[XXRMeViewController alloc] init];
    [self setupChildViewController:me title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标名
 *  @param selectedImageName 选中图标名
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    // 1.设置控制器的属性
    childVc.title = title;
    //    home.tabBarItem.title = @"首页";
    //    home.navigationItem.title = @"首页";
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName ] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 2.包装导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}


@end
