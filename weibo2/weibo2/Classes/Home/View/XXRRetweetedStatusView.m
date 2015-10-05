//
//  XXRRetweetedStatusView.m
//  weibo2
//
//  Created by rgc on 15/10/4.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRRetweetedStatusView.h"
#import "UIImage+XXR.h"
#import "XXRStatusFrame.h"
#import "XXRStatus.h"
#import "XXRUser.h"
#import "UIImageView+WebCache.h"

@interface XXRRetweetedStatusView()

/** 被转发微博作者昵称 */
@property (nonatomic, weak) UILabel *retweetNameLabel;
/** 被转发微博正文\内容 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 被转发微博的配图 */
@property (nonatomic, weak) UIImageView *retweetPhotoView;

@end

@implementation XXRRetweetedStatusView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.image = [UIImage resizedImageWithName:@"timeline_retweet_background_os7" left:0.9 top:0.5];
        
        /** 2.被转发微博作者昵称 */
        UILabel *retweetNameLabel = [[UILabel alloc] init];
        retweetNameLabel.font = XXRStatusNameFont;
        retweetNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:retweetNameLabel];
        self.retweetNameLabel = retweetNameLabel;
        
        /** 3.被转发微博正文\内容 */
        UILabel *retweetContentLabel = [[UILabel alloc] init];
        retweetContentLabel.font = XXRStatusContentFont;
        retweetContentLabel.backgroundColor = [UIColor clearColor];
        retweetContentLabel.numberOfLines = 0;
        [self addSubview:retweetContentLabel];
        self.retweetContentLabel = retweetContentLabel;
        
        /** 4.被转发微博的配图 */
        UIImageView *retweetPhotoView = [[UIImageView alloc] init];
        [self addSubview:retweetPhotoView];
        self.retweetPhotoView = retweetPhotoView;

    }
    return self;
}

- (void)setStatusFrame:(XXRStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    
    XXRStatus *retweetedStatus = statusFrame.status.retweeted_status;
    XXRUser *retweetedUser = retweetedStatus.user;
    
    // 2.被转发微博作者昵称
    self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@", retweetedUser.name];
    self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelFrame;
    
    // 3.被转发微博正文
    self.retweetContentLabel.text = retweetedStatus.text;
    self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelFrame;
    
    // 4.被转发微博配图
    if (retweetedStatus.thumbnail_pic) {
        self.retweetPhotoView.hidden = NO;
        [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retweetedStatus.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
        self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewFrame;
    } else {
        self.retweetPhotoView.hidden = YES;
    }
}

@end
