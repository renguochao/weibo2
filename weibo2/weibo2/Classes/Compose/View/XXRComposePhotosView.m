//
//  XXRComposePhotosView.m
//  weibo2
//
//  Created by rgc on 15/10/18.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRComposePhotosView.h"
#import "Common.h"

#define kXXRComposePhotosViewBorder 10
#define kXXRComposePhotosViewMargin 3

@implementation XXRComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    int count = self.subviews.count;
    
    CGFloat imageViewW = (SCREENW - kXXRComposePhotosViewBorder * 2 - kXXRComposePhotosViewMargin * 2) / 3;
    CGFloat imageViewH = imageViewW;
    int maxColumns = 3; // 一行最多显示4张图片
    
    for (int i = 0; i < count; i ++) {
        int row = i / maxColumns;
        int col = i % maxColumns;
        
        CGFloat imageViewX = kXXRComposePhotosViewBorder + (kXXRComposePhotosViewMargin + imageViewW) * col;
        CGFloat imageViewY = (kXXRComposePhotosViewMargin + imageViewW) * row;
        self.subviews[i].frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    }
    
}


/**
 *  添加一张新的突破
 */
- (void)addImage:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
}

/**
 *  返回内部所有图片
 */
- (NSArray *)totalImages {
    
    NSMutableArray *images = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        [images addObject:imageView.image];
    }
    
    return images;
}

@end
