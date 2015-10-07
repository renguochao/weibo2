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
#import "XXRStatusTopView.h"

@interface XXRStatusCell()
/** 顶部的view */
@property (nonatomic, weak) XXRStatusTopView *topView;

/** 微博的工具条 */
@property (nonatomic, weak) XXRStatusToolbar *statusToolbar;
@end

@implementation XXRStatusCell

#pragma mark - 初始化
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
        // 1.添加TopView
        [self setupTopView];
        
        // 2.添加微博工具条
        [self setupStatusToolBar];
        
    }
    return self;
}

/**
 *  添加TopView
 */
- (void)setupTopView {
    
    /** 0.设置cell选中时的背景 */
    self.selectedBackgroundView = [[UIView alloc] init];
    
    /** 1.顶部的view */
    XXRStatusTopView *topView = [[XXRStatusTopView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
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
    [self setupTopViewData];
    
    // 3.微博工具条
    [self setupStatusToolBarData];
}

#pragma mark - 设置数据
/**
 *  原创微博
 */
- (void)setupTopViewData {
    
    // 1.设置topView的frame
    self.topView.frame = self.statusFrame.topViewFrame;
    
    // 2.传递模型
    self.topView.statusFrame = self.statusFrame;
}

/**
 *  微博工具条
 */
- (void)setupStatusToolBarData {
    
    // 1.设置statusToolbar的frame
    self.statusToolbar.frame = self.statusFrame.statusToolbarFrame;
    
    // 2.传递模型
    self.statusToolbar.status = self.statusFrame.status;
    
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
