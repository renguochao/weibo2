//
//  XXRTabBar.m
//  weibo2
//
//  Created by rgc on 15/8/11.
//  Copyright (c) 2015年 rgc. All rights reserved.
//

#import "XXRTabBar.h"

@implementation XXRTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item {
    // 1.创建按钮
    UIButton *button = [[UIButton alloc] init];
    [self addSubview:button];
    
    // 2.设置数据
    [button setTitle:item.title forState:UIControlStateNormal];
    [button setImage:item.image forState:UIControlStateNormal];
    [button setImage:item.selectedImage forState:UIControlStateSelected];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    
    for (int index = 0; index < self.subviews.count; index ++) {
        // 1.取出按钮
        UIButton *button = self.subviews[index];
        
        // 2.设置按钮的frame
        CGFloat buttonX = index * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}
@end
