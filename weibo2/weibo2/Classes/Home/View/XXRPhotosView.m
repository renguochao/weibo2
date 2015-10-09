//
//  XXRPhotosView.m
//  weibo2
//
//  Created by rgc on 15/10/8.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRPhotosView.h"
#import "XXRPhoto.h"
#import "XXRPhotoView.h"
#import "Common.h"
#import "DXAlertView.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

#define XXRPhotoMargin 5
#define XXRPhotoW (SCREENW - XXRPhotoMargin * 2 - XXRStatusCellBorder * 4) / 3
#define XXRPhotoH XXRPhotoW

@implementation XXRPhotosView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化9个子View
        for (int i = 0; i < 9; i ++) {
            XXRPhotoView *photoView = [[XXRPhotoView alloc] init];
            [photoView setUserInteractionEnabled:YES];
            [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)]];
            photoView.tag = i;
            [self addSubview:photoView];
        }
    }
    return self;
}

- (void)photoTap:(UITapGestureRecognizer *)recognizer {
//    DXAlertView *alertView = [[DXAlertView alloc] initWithTitle:@"哈哈" contentText:@"废话速度快回家繁华的时刻分开后" leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
//    [alertView show];
    
    int count = self.photos.count;
    
    // 1.封装图片数据
    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i ++) {
        MJPhoto *mjPhoto = [[MJPhoto alloc] init];
        
        // 来源自哪个ImageView
        mjPhoto.srcImageView = self.subviews[i];
        
        // 获取大图url
        XXRPhoto *xxrPhoto = self.photos[i];
        NSString *photoUrl = [xxrPhoto.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjPhoto.url = [NSURL URLWithString:photoUrl];
        
        [myphotos addObject:mjPhoto];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = recognizer.view.tag;
    browser.photos = myphotos;
    [browser show];
}

- (void)setPhotos:(NSArray *)photos {
    _photos = photos;
    
    for (int i = 0; i < self.subviews.count; i ++) {
        // 取出该位置对应的ImageView
        XXRPhotoView *photoView = [self.subviews objectAtIndex:i];
        
        // 判断该View是否需要显示
        if (i < photos.count) {
            // 显示图片
            photoView.hidden = NO;
            
            // 传递模型
            photoView.photo = photos[i];
            
            // 计算frame
            int maxColumns = (photos.count == 4) ? 2 : 3;
            int row = i / maxColumns;
            int col = i % maxColumns;
            
            CGFloat photoViewX = (XXRPhotoW + XXRPhotoMargin) * col;
            CGFloat photoViewY = (XXRPhotoW + XXRPhotoMargin) * row;
            photoView.frame = CGRectMake(photoViewX, photoViewY, XXRPhotoW, XXRPhotoH);
            
            // 设置图片模式
            // Aspect : 按照图片的原来宽高比进行缩
            // UIViewContentModeScaleAspectFit : 按照图片的原来宽高比进行缩放(一定要看到整张图片)
            // UIViewContentModeScaleAspectFill :  按照图片的原来宽高比进行缩放(只能图片最中间的内容)
            // UIViewContentModeScaleToFill : 直接拉伸图片至填充整个imageView
            photoView.contentMode = UIViewContentModeScaleAspectFill;
            photoView.clipsToBounds = YES;
        } else {
            // 隐藏图片
            photoView.hidden = YES;
        }
    }
}

+ (CGSize)photosViewSizeWithCount:(int)count {
    // 每行的列数
    int maxColumns = (count == 4) ? 2 : 3;
    
    // 总行数
    int rows = (count + maxColumns - 1) / maxColumns;
    // 高度
    CGFloat photosH = XXRPhotoH * rows + XXRPhotoMargin * (rows - 1);
    
    // 总列数
    int cols = (count >= maxColumns) ? maxColumns : count;
    // 宽度
    CGFloat photosW = XXRPhotoW * cols + XXRPhotoMargin * (cols - 1);
    
    return CGSizeMake(photosW, photosH);
}

@end
