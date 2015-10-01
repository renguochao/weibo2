//
//  XXRSearchBar.m
//  weibo2
//
//  Created by rgc on 15/9/29.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRSearchBar.h"
#import "UIImage+XXR.h"

@interface XXRSearchBar()

@property (nonatomic, weak) UIImageView *iconView;

@end

@implementation XXRSearchBar

+ (id)searchBar {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 背景
        self.background = [UIImage resizedImageWithName:@"searchbar_textfield_background_os7"];
        
        // 左边的放大镜图标
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        iconView.frame = CGRectMake(0, 0, 30, 30);
        iconView.contentMode = UIViewContentModeCenter;
        self.iconView = iconView;
        self.leftView = iconView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        // 字体
        self.font = [UIFont systemFontOfSize:13];
        
        // 右边清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        // 设置提醒文字
        NSMutableDictionary *attr = [NSMutableDictionary dictionary];
        attr[NSForegroundColorAttributeName] = [UIColor grayColor];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:attr];
        
        // 设置键盘右
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
}

@end
