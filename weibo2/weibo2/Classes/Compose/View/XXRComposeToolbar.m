//
//  XXRComposeToolbar.m
//  weibo2
//
//  Created by rgc on 15/10/12.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRComposeToolbar.h"

@implementation XXRComposeToolbar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 1.设置toolbar背景图
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background_os7"]];
        
        // 2.添加五个按钮
        [self addButtonWithIcon:@"compose_camerabutton_background_os7" highIcon:@"compose_camerabutton_background_highlighted_os7" tag:XXRComposeToolbarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture_os7" highIcon:@"compose_toolbar_picture_highlighted_os7" tag:XXRComposeToolbarButtonTypePicture];
        [self addButtonWithIcon:@"compose_mentionbutton_background_os7" highIcon:@"compose_mentionbutton_background_highlighted_os7" tag:XXRComposeToolbarButtonTypeMetion];
        [self addButtonWithIcon:@"compose_trendbutton_background_os7" highIcon:@"compose_trendbutton_background_highlighted_os7" tag:XXRComposeToolbarButtonTypeTrend];
        [self addButtonWithIcon:@"compose_emoticonbutton_background_os7" highIcon:@"compose_emoticonbutton_background_highlighted_os7" tag:XXRComposeToolbarButtonTypeEmotion];
        
    }
    return self;
}

- (void)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(int)tag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [self addSubview:btn];
}

- (void)buttonClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickedButtonType:)]) {
        [self.delegate composeToolbar:self didClickedButtonType:button.tag];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    int count = self.subviews.count;
    CGFloat btnW = self.frame.size.width / count;
    CGFloat btnH = self.frame.size.height;
    
    for (int i = 0; i < self.subviews.count; i ++) {
        UIButton *btn = self.subviews[i];
        
        CGFloat btnX = btnW * i;
        CGFloat btnY = 0;
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}


@end
