//
//  XXRStatusFrame.h
//  weibo2
//
//  Created by rgc on 15/10/1.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Common.h"

/** 昵称字体 */
#define XXRStatusNameFont [UIFont systemFontOfSize:15]
/** 被转发微博昵称字体 */
#define XXRRetweetStatusNameFont XXRStatusNameFont

/** 时间字体 */
#define XXRStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源字体 */
#define XXRStatusSourceFont XXRStatusTimeFont

/** 正文字体 */
#define XXRStatusContentFont [UIFont systemFontOfSize:13]
/** 被转发微博正文字体 */
#define XXRRetweetStatusContentFont XXRStatusContentFont

@class XXRStatus;
@interface XXRStatusFrame : NSObject

+ (id)statusFrameWithStatus:(XXRStatus *)status;

@property (nonatomic, strong) XXRStatus *status;


/** 顶部的ViewFrame */
@property (nonatomic, assign, readonly) CGRect topViewFrame;
/** 头像 */
@property (nonatomic, assign, readonly) CGRect iconViewFrame;
/** 会员图标 */
@property (nonatomic, assign, readonly) CGRect vipViewFrame;
/** 配图 */
@property (nonatomic, assign, readonly) CGRect photosViewFrame;
/** 昵称 */
@property (nonatomic, assign, readonly) CGRect nameLabelFrame;
/** 来源 */
@property (nonatomic, assign, readonly) CGRect sourceLabelFrame;
/** 时间 */
@property (nonatomic, assign, readonly) CGRect timeLabelFrame;
/** 正文\内容 */
@property (nonatomic, assign, readonly) CGRect contentLabelFrame;

/** 被转发微博的ViewFrame(父控件) */
@property (nonatomic, assign, readonly) CGRect retweetViewFrame;
/** 被转发微博作者昵称 */
@property (nonatomic, assign, readonly) CGRect retweetNameLabelFrame;
/** 被转发微博正文\内容 */
@property (nonatomic, assign, readonly) CGRect retweetContentLabelFrame;
/** 被转发微博的配图 */
@property (nonatomic, assign, readonly) CGRect retweetPhotosViewFrame;

/** 微博的工具条 */
@property (nonatomic, assign, readonly) CGRect statusToolbarFrame;

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
@end
