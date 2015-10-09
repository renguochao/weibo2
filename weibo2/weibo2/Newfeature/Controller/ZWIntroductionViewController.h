//
//  LGIntroductionViewController.h
//  ladygo
//
//  Created by square on 15/1/21.
//  Copyright (c) 2015年 ju.taobao.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidSelectedEnter)();

@interface ZWIntroductionViewController : UIViewController

@property (nonatomic, strong) UIScrollView *pagingScrollView;
@property (nonatomic, strong) UIButton *enterButton;
@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, copy) DidSelectedEnter didSelectedEnter;
@property (nonatomic, copy) DidSelectedEnter didSelectedRegist;
@property (nonatomic, copy) DidSelectedEnter didSelectedLogin;

/**
 @[@"image1", @"image2"]
 */
@property (nonatomic, strong) NSArray *backgroundImageNames;

/**
 @[@"coverImage1", @"coverImage2"]
 */
@property (nonatomic, strong) NSArray *coverImageNames;


- (id)initWithCoverImageNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames;


- (id)initWithCoverImageNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames button:(UIButton*)button;

@end
