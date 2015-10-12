//
//  XXRStatusTopView.m
//  weibo2
//
//  Created by rgc on 15/10/5.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRStatusTopView.h"
#import "UIImage+XXR.h"
#import "XXRStatusFrame.h"
#import "Common.h"
#import "UIImageView+WebCache.h"
#import "XXRUser.h"
#import "XXRStatus.h"
#import "XXRPhoto.h"
#import "XXRRetweetedStatusView.h"
#import "XXRPhotosView.h"

@interface XXRStatusTopView()

/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) XXRPhotosView *photosView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 正文\内容 */
@property (nonatomic, weak) UILabel *contentLabel;

/** 被转发微博的view*/
@property (nonatomic, weak) XXRRetweetedStatusView *retweetView;

@end

@implementation XXRStatusTopView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUserInteractionEnabled:YES];
        
        // 1.设置图片
        [self setImage:[UIImage resizedImageWithName:@"timeline_card_top_background_os7"]];
        [self setHighlightedImage:[UIImage resizedImageWithName:@"timeline_card_top_background_highlighted_os7"]];
        
        /** 2.头像 */
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        /** 3.会员图标 */
        UIImageView *vipView = [[UIImageView alloc] init];
        [self addSubview:vipView];
        self.vipView = vipView;
        
        /** 4.配图 */
        XXRPhotosView *photosView = [[XXRPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
        /** 5.昵称 */
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = XXRStatusNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        /** 6.来源 */
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.backgroundColor = [UIColor clearColor];
        sourceLabel.font = XXRStatusSourceFont;
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        /** 7.时间 */
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.font = XXRStatusTimeFont;
        timeLabel.textColor = XXRColor(240, 140, 19);
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        /** 8.正文\内容 */
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.numberOfLines = 0;
        contentLabel.font = XXRStatusContentFont;
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        /** 9.添加被转发微博的View */
        XXRRetweetedStatusView *retweetView = [[XXRRetweetedStatusView alloc] init];
        [self addSubview:retweetView];
        self.retweetView = retweetView;
    }
    return self;
}

- (void)setStatusFrame:(XXRStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    
    XXRStatus *status = statusFrame.status;
    XXRUser *user = status.user;
    
    // 2.头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
    self.iconView.frame = self.statusFrame.iconViewFrame;
    
    // 3.会员图标
    if (user.mbtype) {
        self.vipView.hidden = NO;
        self.vipView.frame = self.statusFrame.vipViewFrame;
        self.vipView.contentMode = UIViewContentModeCenter;
        NSString *mbIconName = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipView.image = [UIImage imageNamed:mbIconName];
        
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    // 4.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelFrame;
    
    // 7.时间
    self.timeLabel.text = status.created_at;
    CGFloat timeLabelX = self.nameLabel.frame.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.nameLabel.frame) + XXRStatusCellBorder * 0.5;
    CGSize timeLabelSize = [status.created_at sizeWithFont:XXRStatusTimeFont];
    self.timeLabel.frame = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    // 6.来源
    self.sourceLabel.text = status.source;
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame) + XXRStatusCellBorder;
    CGFloat sourceLabelY = self.statusFrame.timeLabelFrame.origin.y;
    CGSize sourceLabelSize = [status.source sizeWithFont:XXRStatusSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    
    // 7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelFrame;
    
    // 8.配图
    if (status.pic_urls.count) {
        self.photosView.hidden = NO;
        self.photosView.photos = status.pic_urls;
        self.photosView.frame = self.statusFrame.photosViewFrame;
    } else {
        self.photosView.hidden = YES;
    }
    
    // 9.被转发微博的View
    XXRStatus *retweetedStatus = self.statusFrame.status.retweeted_status;
    
    // 1.retweetedView
    if (retweetedStatus) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.statusFrame.retweetViewFrame;
        
        // 传递模型数据
        self.retweetView.statusFrame = self.statusFrame;
    } else {
        self.retweetView.hidden = YES;
    }
}

@end
