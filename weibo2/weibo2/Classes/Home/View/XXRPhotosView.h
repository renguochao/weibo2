//
//  XXRPhotosView.h
//  weibo2
//
//  Created by rgc on 15/10/8.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXRPhotosView : UIView

/** 需要展示的图片（里面存放XXRPhoto模型） */
@property (nonatomic, strong) NSArray *photos;

+ (CGSize)photosViewSizeWithCount:(int)count;

@end
