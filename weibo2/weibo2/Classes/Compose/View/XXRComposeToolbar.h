//
//  XXRComposeToolbar.h
//  weibo2
//
//  Created by rgc on 15/10/12.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    XXRComposeToolbarButtonTypeCamera,
    XXRComposeToolbarButtonTypeEmotion,
    XXRComposeToolbarButtonTypeMetion,
    XXRComposeToolbarButtonTypePicture,
    XXRComposeToolbarButtonTypeTrend
} XXRComposeToolbarButtonType;

@class XXRComposeToolbar;
@protocol XXRComposeToolbarDelegate <NSObject>

@optional
- (void)composeToolbar:(XXRComposeToolbar *)composeToolbar didClickedButtonType:(XXRComposeToolbarButtonType) toolbarButtonType;

@end

@interface XXRComposeToolbar : UIView

@property (nonatomic, weak) id<XXRComposeToolbarDelegate> delegate;

@end
