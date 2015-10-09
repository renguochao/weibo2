//
//  UIBarButtonItem+XXR.m
//  weibo2
//
//  Created by rgc on 15/9/29.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "UIBarButtonItem+XXR.h"

@implementation UIBarButtonItem (XXR)

/**
 *  快速创建一个显示图片的BarButtonItem
 *
 *  @param action  监听方法
 *
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    button.bounds = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
