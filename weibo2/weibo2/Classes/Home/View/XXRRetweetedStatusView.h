//
//  XXRRetweetedStatusView.h
//  weibo2
//
//  Created by rgc on 15/10/4.
//  Copyright © 2015年 rgc. All rights reserved.
//  Cell内部 被转发微博自定义View

#import <UIKit/UIKit.h>
@class XXRStatusFrame;
@interface XXRRetweetedStatusView : UIImageView
@property (nonatomic, strong) XXRStatusFrame *statusFrame;
@end
