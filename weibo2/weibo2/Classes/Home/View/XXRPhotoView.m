//
//  XXRPhotoView.m
//  weibo2
//
//  Created by rgc on 15/10/8.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRPhotoView.h"
#import "XXRPhoto.h"
#import "UIImageView+WebCache.h"

@interface XXRPhotoView()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation XXRPhotoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 添加gif小图片
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
        
    }
    return self;
}

- (void)setPhoto:(XXRPhoto *)photo {
    _photo = photo;
    
    // 1.控制gifView的可见性
    self.gifView.hidden = ![photo.thumbnail_pic hasSuffix:@"gif"];
    
    // 2.下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.gifView.layer.anchorPoint = CGPointMake(1, 1);
    self.gifView.layer.position = CGPointMake(self.frame.size.width, self.frame.size.height);
}

@end
