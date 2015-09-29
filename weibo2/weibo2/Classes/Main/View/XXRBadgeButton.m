//
//  XXRBadgeButton.m
//  weibo2
//
//  Created by rgc on 15/9/23.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRBadgeButton.h"
#import "UIImage+XXR.h"

@implementation XXRBadgeButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        [self setBackgroundImage:[UIImage resizedImageWithName:@"main_badge_os7"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue {
    // TODO copy
    _badgeValue = [badgeValue copy];
    
    if (self.badgeValue) {
        self.hidden = NO;
        
        // 设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        // 设置frame
        CGRect frame = self.frame;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length > 1) {
            CGSize badgeTextSize = [badgeValue sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
            badgeW = badgeTextSize.width + 10;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
    } else {
        self.hidden = YES;
    }
}

@end
