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
#import "XXRStatus.h"

#define XXRStatusToolbarFont [UIFont systemFontOfSize:12]

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
        UIButton *repostButton = [self setupBtnWithTitle:@"转发" image:@"timeline_icon_retweet_os7"];
        self.repostButton = repostButton;
        
        /** 3.评论 */
        UIButton *commentButton = [self setupBtnWithTitle:@"评论" image:@"timeline_icon_comment_os7"];
        self.commentButton = commentButton;
        
        /** 4.点赞 */
        UIButton *attitudeButton = [self setupBtnWithTitle:@"赞" image:@"timeline_icon_unlike_os7"];
        self.attitudeButton = attitudeButton;
        
        /** 添加分割线 */
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

- (UIButton *)setupBtnWithTitle:(NSString *)title image:(NSString *)image {
    UIButton *btn = [[UIButton alloc] init];
    // 取消按钮点击之后调整图片
    btn.adjustsImageWhenHighlighted = NO;
    
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = XXRStatusToolbarFont;
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted_os7"] forState:UIControlStateHighlighted];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self addSubview:btn];
    
    // 添加到按钮数组
    [self.btns addObject:btn];
    
    return btn;
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

- (void)setStatus:(XXRStatus *)status {
    _status = status;
    
    // 1.设置转发数
    [self setupBtn:self.repostButton originalTitle:@"转发" count:status.reposts_count];
    
    // 2.设置评论数
    [self setupBtn:self.commentButton originalTitle:@"评论" count:status.comments_count];
    
    // 2.设置点赞数
    [self setupBtn:self.attitudeButton originalTitle:@"赞" count:status.attitudes_count];
}

/**
 *  设置按钮显示的标题
 *
 *  @param btn           需要设置的按钮
 *  @param originalTitle 原始标题
 *  @param count         显示的个数
 */
- (void)setupBtn:(UIButton *)btn originalTitle:(NSString *)originalTitle count:(int)count {
    if (count) {
        NSString *title = nil;
        /**
         * 数目 < 10000的 直接显示
         * 数目 > 10000的 显示多少万
         *      整万(10012, 20010): 1万，2万
         *      其他(14363): 1.4万
         */
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%d", count];
        } else {
            double countDouble = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万", countDouble];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        
        [btn setTitle:title forState:UIControlStateNormal];
        
    } else {
        [btn setTitle:originalTitle forState:UIControlStateNormal];
    }
}

@end
