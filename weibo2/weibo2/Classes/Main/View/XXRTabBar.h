//
//  XXRTabBar.h
//  weibo2
//
//  Created by rgc on 15/8/11.
//  Copyright (c) 2015年 rgc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXRTabBar;
@protocol XXRTabBarDelegate <NSObject>

@optional
- (void)tabBar:(XXRTabBar *)tabBar didSelectButtonFrom:(int)from to:(int)to;

@end

@interface XXRTabBar : UIView
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic, weak) id<XXRTabBarDelegate> delegate;
@end
