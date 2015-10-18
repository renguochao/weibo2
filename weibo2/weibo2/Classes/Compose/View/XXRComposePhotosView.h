//
//  XXRComposePhotosView.h
//  weibo2
//
//  Created by rgc on 15/10/18.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXRComposePhotosView : UIView

/**
 *  添加一张新的图片
 */
- (void)addImage:(UIImage *)image;

/**
 *  返回内部所有图片
 */
- (NSArray *)totalImages;

@end
