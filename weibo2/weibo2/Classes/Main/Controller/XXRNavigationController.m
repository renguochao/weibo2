//
//  XXRNavigationController.m
//  weibo2
//
//  Created by rgc on 15/9/27.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRNavigationController.h"

@interface XXRNavigationController ()

@end

@implementation XXRNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
