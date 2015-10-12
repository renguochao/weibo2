//
//  Common.h
//  weibo2
//
//  Created by rgc on 15/8/11.
//  Copyright (c) 2015年 rgc. All rights reserved.
//

#ifndef weibo2_Common_h
#define weibo2_Common_h

// 0.账号相关
#define XXRAppKey @"1470846510"
#define XXRAppSecret @"f8464bfebacaf842c7a25cf6a71b68bb"
#define XXRRedirectURI @"https://www.baidu.com/"

// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 2.获得RGB颜色
#define XXRColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 3.自定义Log
#ifdef DEBUG
#define XXRLog(...) NSLog(__VA_ARGS__)
#else
#define XXRLog(...)
#endif

// 4.微博cell上面的属性
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

/** cell边框宽度 */
#define XXRStatusCellBorder 10

/** 屏幕宽度、高度*/
#define SCREENW [[UIScreen mainScreen] bounds].size.width
#define SCREENH [[UIScreen mainScreen] bounds].size.width

// 5.微博配图
#define XXRPhotoMargin 5
#define XXRPhotoW (SCREENW - XXRPhotoMargin * 2 - XXRStatusCellBorder * 4) / 3
#define XXRPhotoH XXRPhotoW

#define XXRNotificationCenter [NSNotificationCenter defaultCenter]

#endif

