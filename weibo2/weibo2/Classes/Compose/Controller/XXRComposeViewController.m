//
//  XXRComposeViewController.m
//  weibo2
//
//  Created by rgc on 15/10/10.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRComposeViewController.h"
#import "XXRTextView.h"
#import "Common.h"
#import "XXRAccountTool.h"
#import <AFNetworking/AFNetworking.h>
#import "MBProgressHUD+MJ.h"

@interface XXRComposeViewController ()

@property (nonatomic, weak) UITextView *textView;

@end

@implementation XXRComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏属性
    [self setupNavBar];
    
    // 添加TextView
    [self setupTextView];
    
    /**
     *  UITextField：不能换行
     *  UITextView： 没有提示文字
     */
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // View一显示时就弹出键盘
    [self.textView becomeFirstResponder];
}

/**
 *  添加TextView
 */
- (void)setupTextView {
    // 1.添加textView
    XXRTextView *textView = [[XXRTextView alloc] init];
    textView.font = [UIFont systemFontOfSize:15];
    textView.frame = self.view.bounds;  // UITextView（UIScrollView）在上方会有额外64的滚动区域
    textView.placeholder = @"分享新鲜事...";
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 2.监听textView文字改变的通知
    // 右边对象发出的通知，我们就会调用Observer的方法
    [XXRNotificationCenter addObserver:self selector:@selector(textViewTextDidChanged:) name:UITextViewTextDidChangeNotification object:textView];
}

/**
 *  监听文字改变
 */
- (void)textViewTextDidChanged:(NSNotification *)notification {
//    XXRLog(@"textView.text:%@", self.textView.text);
    self.navigationItem.rightBarButtonItem.enabled = (self.textView.text.length != 0);
}

/**
 *  设置导航栏属性
 */
- (void)setupNavBar {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.title = @"发微博";
}

- (void)send {
    // 1.创建请求管理类
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 2.设置参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [XXRAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        XXRLog(@"请求成功:%@", responseObject);
        
        [MBProgressHUD showSuccess:@"发送成功"];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        XXRLog(@"请求失败:%@", error);
        
        [MBProgressHUD showError:@"发送失败"];
    }];
    
    // 4.关闭控制器
    [self cancel];
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc {
    [XXRNotificationCenter removeObserver:self];
}


@end
