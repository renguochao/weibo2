//
//  XXRStatusCell.m
//  weibo2
//
//  Created by rgc on 15/10/1.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRStatusCell.h"
#import "XXRStatus.h"
#import "XXRUser.h"
#import "XXRStatusFrame.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+XXR.h"
#import "Common.h"
#import "XXRStatusToolbar.h"
#import "XXRRetweetedStatusView.h"

@interface XXRStatusCell()
/** 顶部的view */
@property (nonatomic, weak) UIImageView *topView;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) UIImageView *photoView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 正文\内容 */
@property (nonatomic, weak) UILabel *contentLabel;

/** 被转发微博的view(父控件) */
@property (nonatomic, weak) XXRRetweetedStatusView *retweetView;

/** 微博的工具条 */
@property (nonatomic, weak) XXRStatusToolbar *statusToolbar;
@end

@implementation XXRStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    // 1.创建cell
    static NSString *ID = @"status";
    XXRStatusCell *cell = (XXRStatusCell *)[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XXRStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.添加原创微博内部的子控件
        [self setupOriginalSubviews];
        
        // 2.添加被转发微博内部的子控件
        [self setupRetweetSubviews];
        
        // 3.添加微博工具条
        [self setupStatusToolBar];
        
    }
    return self;
}

/**
 *  添加原创微博内部的子控件
 */
- (void)setupOriginalSubviews {
    
    /** 0.设置cell选中时的背景 */
    self.selectedBackgroundView = [[UIView alloc] init];
    
    /** 1.顶部的view */
    UIImageView *topView = [[UIImageView alloc] init];
    [topView setImage:[UIImage resizedImageWithName:@"timeline_card_top_background_os7"]];
    [topView setHighlightedImage:[UIImage resizedImageWithName:@"timeline_card_top_background_highlighted_os7"]];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    /** 2.头像 */
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.topView addSubview:iconView];
    self.iconView = iconView;
    
    /** 3.会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    [self.topView addSubview:vipView];
    self.vipView = vipView;
    
    /** 4.配图 */
    UIImageView *photoView = [[UIImageView alloc] init];
    [self.topView addSubview:photoView];
    self.photoView = photoView;
    
    /** 5.昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = XXRStatusNameFont;
    [self.topView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 6.来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.backgroundColor = [UIColor clearColor];
    sourceLabel.font = XXRStatusSourceFont;
    [self.topView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 7.时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.font = XXRStatusTimeFont;
    timeLabel.textColor = XXRColor(240, 140, 19);
    [self.topView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /** 8.正文\内容 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.numberOfLines = 0;
    contentLabel.font = XXRStatusContentFont;
    [self.topView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

/**
 *  添加被转发微博内部的子控件
 */
- (void)setupRetweetSubviews {
    
    /** 1.被转发微博的view(父控件) */
    XXRRetweetedStatusView *retweetView = [[XXRRetweetedStatusView alloc] init];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;
}

/**
 *  添加微博工具条
 */
- (void)setupStatusToolBar {
    /** 1.微博的工具条 */
    XXRStatusToolbar *statusToolbar = [[XXRStatusToolbar alloc] init];
    [self.contentView addSubview:statusToolbar];
    self.statusToolbar = statusToolbar;
    
}

- (void)setStatusFrame:(XXRStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    
    // 1.原创微博
    [self setupOriginalData];
    
    // 2.被转发微博
    [self setupRetweetData];
    
    // 3.微博工具条
    [self setupStatusToolBarData];
}

/**
 *  原创微博
 */
- (void)setupOriginalData {
    
    XXRStatus *status = self.statusFrame.status;
    XXRUser *user = status.user;
    
    // 1.topView
    self.topView.frame = self.statusFrame.topViewFrame;
    
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
    CGFloat sourceLabelX = CGRectGetMaxX(self.statusFrame.timeLabelFrame) + XXRStatusCellBorder;
    CGFloat sourceLabelY = self.statusFrame.timeLabelFrame.origin.y;
    CGSize sourceLabelSize = [status.source sizeWithFont:XXRStatusSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    
    // 7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelFrame;
    
    // 8.配图
    if (status.thumbnail_pic) {
        self.photoView.hidden = NO;
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
        self.photoView.frame = self.statusFrame.photoViewFrame;
    } else {
        self.photoView.hidden = YES;
    }
    
}

/**
 *  被转发微博
 */
- (void)setupRetweetData {
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

/**
 *  微博工具条
 */
- (void)setupStatusToolBarData {
    self.statusToolbar.frame = self.statusFrame.statusToolbarFrame;
    
    self.statusToolbar.status = self.statusFrame.status;
    
//    CGFloat statusToolbarW = self.statusToolbar.frame.size.width;
//    CGFloat statusToolbarH = self.statusToolbar.frame.size.height;
//    
//    CGFloat subViewW = statusToolbarW / 3;
//    CGFloat subViewH = statusToolbarH;
//    
//    NSArray *subViews = self.statusToolbar.subviews;
//    for (int index = 0; index < subViews.count; index ++) {
//        UIButton *button = subViews[index];
//        button.frame = CGRectMake(subViewW * index, 0, subViewW, subViewH);
//    }
}

/**
 *  拦截frame的设置
 *
 */
- (void)setFrame:(CGRect)frame {
    frame.origin.y += 5;
    frame.size.height -= 10;
    [super setFrame:frame];
}

@end
