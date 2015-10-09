//
//  Common.h
//  weibo2
//
//  Created by rgc on 15/8/11.
//  Copyright (c) 2015年 rgc. All rights reserved.
//

#ifndef weibo2_Common_h
#define weibo2_Common_h

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

/** cell边框宽度 */
#define XXRStatusCellBorder 10

/** 屏幕宽度、高度*/
#define SCREENW [[UIScreen mainScreen] bounds].size.width
#define SCREENH [[UIScreen mainScreen] bounds].size.width

#endif

