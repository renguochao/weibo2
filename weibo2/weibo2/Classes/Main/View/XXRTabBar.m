//
//  XXRTabBar.m
//  weibo2
//
//  Created by rgc on 15/8/11.
//  Copyright (c) 2015年 rgc. All rights reserved.
//

#import "XXRTabBar.h"
#import "XXRTabBarButton.h"

@interface XXRTabBar()

@property (nonatomic, weak) UIButton *selectedButton;
@property (nonatomic, weak) UIButton *plusButton;

@property (nonatomic, strong) NSMutableArray *tabBarButtons;
@end

@implementation XXRTabBar

- (NSMutableArray *)tabBarButtons {
    if (!_tabBarButtons) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 加号按钮
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_os7"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted_os7"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_os7"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted_os7"] forState:UIControlStateHighlighted];
        plusButton.bounds = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
        self.plusButton = plusButton;
        [self addSubview:plusButton];
    }
    return self;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item {
    // 1.创建按钮
    XXRTabBarButton *button = [[XXRTabBarButton alloc] init];
    [self addSubview:button];
    
    // 2.设置数据
    button.item = item;
    
    // 3.监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 4.默认选中第0个按钮
    if (self.subviews.count == 1) {
        button.selected = YES;
        self.selectedButton = button;
    }
    
    [self.tabBarButtons addObject:button];
}

- (void)buttonClick:(XXRTabBarButton *)button {
    
    // 1.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectButtonFrom:self.selectedButton.tag to:button.tag];
    }
    
    // 2.设置按钮状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 调整加号的位置
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
    
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    
    for (int index = 0; index < self.tabBarButtons.count; index ++) {
        // 1.取出按钮
        UIButton *button = self.tabBarButtons[index];
        
        // 2.设置按钮的frame
        CGFloat buttonX = index * buttonW;
        if (index > 1) {
            buttonX += buttonW;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 3.绑定tag
        button.tag = index;
    }
}
@end
