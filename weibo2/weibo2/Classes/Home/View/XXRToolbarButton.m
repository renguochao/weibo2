//
//  XXRToolbarButton.m
//  weibo2
//
//  Created by rgc on 15/10/2.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRToolbarButton.h"

#define XXRStatusToolbarFont [UIFont systemFontOfSize:12]

@implementation XXRToolbarButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        // 取消按钮点击之后调整图片
        self.adjustsImageWhenHighlighted = NO;
        
        self.titleLabel.font = XXRStatusToolbarFont;
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted_os7"] forState:UIControlStateHighlighted];
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    }
    return self;
}

@end
