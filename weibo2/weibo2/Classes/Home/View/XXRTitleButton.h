//
//  XXRTitleButton.h
//  weibo2
//
//  Created by rgc on 15/9/30.
//  Copyright © 2015年 rgc. All rights reserved.
//  标题按钮

#import <UIKit/UIKit.h>

@interface XXRTitleButton : UIButton

+ (instancetype)titleButton;

- (void)setTitle:(NSString *)title forState:(UIControlState)state;

@end
