//
//  XXRNavigationController.m
//  weibo2
//
//  Created by rgc on 15/9/27.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRNavigationController.h"
#import "Common.h"

@interface XXRNavigationController ()

@end

@implementation XXRNavigationController

/**
 * 第一次使用这个类的时候会调用(1个类只会调用1次)
 */
+ (void)initialize {
    // 1.设置导航栏主题
    [self setNavBarTheme];
    
    // 2.设置导航栏按钮主题
    [self setBarButtonItemTheme];
}

+ (void)setBarButtonItemTheme {
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置背景
    if (!iOS7) {
        [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    }
    
    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = iOS7 ? [UIColor orangeColor] : [UIColor grayColor];
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    textAttrs[UITextAttributeFont] = iOS7 ? [UIFont systemFontOfSize:18] : [UIFont systemFontOfSize:12];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[UITextAttributeTextColor] = [UIColor grayColor];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}

+ (void)setNavBarTheme {
    // 取出appearance对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    // 设置背景
    //    [navBar setBackgroundImage:<#(nullable UIImage *)#> forBarMetrics:UIBarMetricsDefault];
    
    // 设置标题属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor blackColor];
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    textAttrs[UITextAttributeFont] = [UIFont boldSystemFontOfSize:19];
    [navBar setTitleTextAttributes:textAttrs];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
