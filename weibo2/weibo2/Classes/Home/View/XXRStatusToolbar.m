//
//  XXRStatusToolbar.m
//  weibo2
//
//  Created by rgc on 15/10/2.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRStatusToolbar.h"
#import "UIImage+XXR.h"
#import "XXRToolbarButton.h"

@interface XXRStatusToolbar()

@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *dividers;

@property (nonatomic, weak) UIButton *repostButton;
@property (nonatomic, weak) UIButton *commentButton;
@property (nonatomic, weak) UIButton *attitudeButton;

@end

@implementation XXRStatusToolbar

- (NSMutableArray *)btns {
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers {
    if (_dividers == nil) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 图片默认不能接收点击时间
        self.userInteractionEnabled = YES;
        
        [self setImage:[UIImage resizedImageWithName:@"timeline_card_bottom_background_os7"]];
        [self setHighlightedImage:[UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted_os7"]];
        
        /** 2.转发 */
        XXRToolbarButton *repostButton = [[XXRToolbarButton alloc] init];
        [repostButton setImage:[UIImage imageNamed:@"timeline_icon_retweet_os7"] forState:UIControlStateNormal];
        [repostButton setTitle:@"转发" forState:UIControlStateNormal];
        [self.btns addObject:repostButton];
        [self addSubview:repostButton];
        self.repostButton = repostButton;
        
        /** 3.评论 */
        XXRToolbarButton *commentButton = [[XXRToolbarButton alloc] init];
        [commentButton setImage:[UIImage imageNamed:@"timeline_icon_comment_os7"] forState:UIControlStateNormal];
        [commentButton setTitle:@"评论" forState:UIControlStateNormal];
        [self.btns addObject:commentButton];
        [self addSubview:commentButton];
        self.commentButton = commentButton;
        
        /** 4.点赞 */
        XXRToolbarButton *attitudeButton = [[XXRToolbarButton alloc] init];
        [attitudeButton setImage:[UIImage imageNamed:@"timeline_icon_unlike_os7"] forState:UIControlStateNormal];
        [attitudeButton setTitle:@"3" forState:UIControlStateNormal];
        [self.btns addObject:attitudeButton];
        [self addSubview:attitudeButton];
        self.attitudeButton = attitudeButton;
        
        /** 添加分割线 */
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

- (void)setupDivider {
    UIImageView *divider = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line_os7"]];
    [self.dividers addObject:divider];
    [self addSubview:divider];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat toolbarW = self.frame.size.width;
    CGFloat toolbarH = self.frame.size.height;
    
    CGFloat dividerW = 2;
    
    CGFloat buttonW = toolbarW / 3 - dividerW * self.dividers.count;
    CGFloat buttonH = toolbarH;
    
    for (int i = 0; i < self.btns.count; i ++) {
        UIButton *btn = self.btns[i];
        CGFloat btnX = (buttonW + dividerW) * i;
        CGFloat btnY = 0;
        
        btn.frame = CGRectMake(btnX, btnY, buttonW, buttonH);
    }

    for (int i = 0; i < self.dividers.count; i ++) {
        UIImageView *divider = self.dividers[i];
        
        UIButton *btn = self.btns[i];
        CGFloat dividerX = CGRectGetMaxX(btn.frame);
        CGFloat dividerY = 0;
        CGFloat dividerH = buttonH;
        divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    }
}


@end
