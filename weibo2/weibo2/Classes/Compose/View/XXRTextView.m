//
//  XXRTextView.m
//  weibo2
//
//  Created by rgc on 15/10/10.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRTextView.h"
#import "Common.h"

@interface XXRTextView()
@property (nonatomic, weak) UILabel *placeholderLabel;
@end

@implementation XXRTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 1.添加提示文字
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.textColor = [UIColor lightGrayColor];
        placeholderLabel.hidden = YES;
        self.placeholderLabel = placeholderLabel;
        [self addSubview:placeholderLabel];
        
        // 2.监听textView文字改变的通知
        [XXRNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder {
    // why
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    if (placeholder.length) {   // 显示
        self.placeholderLabel.hidden = NO;
        
        // 计算frame
        CGFloat placeholderX = 5;
        CGFloat placeholderY = 7;
        CGFloat maxW = self.frame.size.width - 2 * placeholderX;
        CGFloat maxH = self.frame.size.height - 2 * placeholderY;
        CGSize placeholderSize = [placeholder sizeWithFont:self.placeholderLabel.font constrainedToSize:CGSizeMake(maxW, maxH)];
        self.placeholderLabel.frame = CGRectMake(placeholderX, placeholderY, placeholderSize.width, placeholderSize.height);
        
    } else {
        self.placeholderLabel.hidden = YES;
    }
}

- (void)textDidChange {
    self.placeholderLabel.hidden = (self.text.length != 0);
}

- (void)dealloc {
    [XXRNotificationCenter removeObserver:self];
}

@end
