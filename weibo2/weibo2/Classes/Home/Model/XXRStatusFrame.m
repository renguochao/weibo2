//
//  XXRStatusFrame.m
//  weibo2
//
//  Created by rgc on 15/10/1.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRStatusFrame.h"
#import "XXRStatus.h"

@implementation XXRStatusFrame

+ (id)statusFrameWithStatus:(XXRStatus *)status {
    return [[self alloc] initWithStatus:status];
}

- (id)initWithStatus:(XXRStatus *)status {
    self = [super init];
    if (self) {
        [self setStatus:status];
    }
    return self;
}

/**
 *  根据微博数据，计算所有子控件的Frame
 *
 */
- (void)setStatus:(XXRStatus *)status {
    _status = status;
    
    // cell的宽度
    CGFloat cellW = [[UIScreen mainScreen] bounds].size.width;
    
    // 1.topView
    CGFloat topViewW = cellW;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    CGFloat topViewH = 0;
    
    // 2.头像
    CGFloat iconViewHW = 35;
    CGFloat iconViewX = XXRStatusCellBorder;
    CGFloat iconViewY = XXRStatusCellBorder;
    _iconViewFrame = CGRectMake(iconViewX, iconViewY, iconViewHW, iconViewHW);
    
    // 3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewFrame) + XXRStatusCellBorder;
    CGFloat nameLabelY = iconViewY;
    CGSize nameLabelSize = [status.user.name sizeWithFont:XXRStatusNameFont];
    _nameLabelFrame = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    // 4.会员图标
    if (status.user.mbtype) {
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelFrame) + XXRStatusCellBorder;
        CGFloat vipViewY = iconViewY;
        _vipViewFrame = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    // 5.时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelFrame) + XXRStatusCellBorder * 0.5;
    CGSize timeLabelSize = [status.created_at sizeWithFont:XXRStatusTimeFont];
    _timeLabelFrame = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    // 6.来源
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelFrame) + XXRStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:XXRStatusSourceFont];
    _sourceLabelFrame = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};

    // 7.正文\内容
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_iconViewFrame), CGRectGetMaxY(_timeLabelFrame)) + XXRStatusCellBorder;
    CGFloat contentLabelMaxW = topViewW - XXRStatusCellBorder * 2;
    CGSize contentLabelSize = [status.text sizeWithFont:XXRStatusContentFont constrainedToSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];
    _contentLabelFrame = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    topViewH = CGRectGetMaxY(_contentLabelFrame) + XXRStatusCellBorder;
    
    // 8.配图
    if (status.thumbnail_pic) {
        CGFloat photoViewHW = 70 ;
        CGFloat photoViewX = contentLabelX;
        CGFloat photoViewY = CGRectGetMaxY(_contentLabelFrame) + XXRStatusCellBorder;
        _photoViewFrame = CGRectMake(photoViewX, photoViewY, photoViewHW, photoViewHW);
        topViewH += photoViewHW + XXRStatusCellBorder;
    }
    
    // 9.被转发微博
    if (status.retweeted_status) {
        CGFloat retweetViewW = contentLabelMaxW;
        CGFloat retweetViewX = contentLabelX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelFrame) + XXRStatusCellBorder * 0.5;
        CGFloat retweetViewH = 0;
        
        // 10.被转发微博昵称
        CGFloat retweetNameLabelX = XXRStatusCellBorder;
        CGFloat retweetNameLabelY = XXRStatusCellBorder;
        NSString *name = [NSString stringWithFormat:@"@%@", status.retweeted_status.user.name];
        CGSize retweetNameLabelSize = [name sizeWithFont:XXRRetweetStatusNameFont];
        _retweetNameLabelFrame = (CGRect){{retweetNameLabelX, retweetNameLabelY}, retweetNameLabelSize};
        
        // 11.被转发微博正文
        CGFloat retweetContentLabelX = XXRStatusCellBorder;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelFrame) + XXRStatusCellBorder;
        CGFloat retweetContentLabelMaxW = retweetViewW - XXRStatusCellBorder * 2;
        CGSize retweetContentLabelSize = [status.retweeted_status.text sizeWithFont:XXRRetweetStatusContentFont constrainedToSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT)];
        _retweetContentLabelFrame = (CGRect){{retweetContentLabelX, retweetContentLabelY}, retweetContentLabelSize};
        retweetViewH = CGRectGetMaxY(_retweetContentLabelFrame) + XXRStatusCellBorder;
        
        // 12.被转发微博配图
        if (status.retweeted_status.thumbnail_pic) {
            CGFloat retweetPhotoViewHW = 70 ;
            CGFloat retweetPhotoViewX = retweetContentLabelX;
            CGFloat retweetPhotoViewY = CGRectGetMaxY(_retweetContentLabelFrame) + XXRStatusCellBorder;
            _retweetPhotoViewFrame = CGRectMake(retweetPhotoViewX, retweetPhotoViewY, retweetPhotoViewHW, retweetPhotoViewHW);
            retweetViewH += retweetPhotoViewHW + XXRStatusCellBorder;
        }
        _retweetViewFrame = (CGRect){{retweetViewX, retweetViewY}, {retweetViewW, retweetViewH}};
        topViewH += retweetViewH;
    }
    // 计算topView的高度
    _topViewFrame = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    // 13.微博工具条
    CGFloat statusToolBarX = 0;
    CGFloat statusToolBarY = CGRectGetMaxY(_topViewFrame);
    CGFloat statusToolBarW = topViewW;
    CGFloat statusToolBarH = 35;
    _statusToolbarFrame = CGRectMake(statusToolBarX, statusToolBarY, statusToolBarW, statusToolBarH);
    
    // cell的高度
    _cellHeight = CGRectGetMaxY(_statusToolbarFrame) + 10;
}

@end
