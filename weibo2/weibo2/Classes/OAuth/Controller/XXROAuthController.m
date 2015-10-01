//
//  XXROAuthController.m
//  weibo2
//
//  Created by rgc on 15/9/30.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXROAuthController.h"
#import "XXRTabBarViewController.h"
#import "XXRNewfeatureViewController.h"

#import "XXRAccount.h"

#import <AFNetworking/AFNetworking.h>
#import "MBProgressHUD+MJ.h"
#import "Common.h"
#import "XXRWeiboTool.h"
#import "XXRAccountTool.h"

@interface XXROAuthController () <UIWebViewDelegate>

@end

@implementation XXROAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.添加Webview
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 2.加载授权页面
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1470846510&redirect_uri=https://www.baidu.com/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma mark - WebView Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showMessage:@"正在加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 隐藏加载框
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    // 隐藏加载框
    [MBProgressHUD hideHUD];
}

/**
 *  当webView发送一个请求之前都会调用这个方法，询问代理
 *
 *  @param request        <#request description#>
 *
 *  @return YES:可以加载页面 NO:不可以加载页面
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    // 1.请求的URL路径
    NSString *urlStr = request.URL.absoluteString;
    
    // 2.查找code=在urlStr中的范围
    NSRange range = [urlStr rangeOfString:@"code="];
    
    // 3.如果urlStr中包含了code=
    if (range.location != NSNotFound) {
        // 4.截取code=后面的请求标记
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        
        // 5.发送请求给新浪，根据code换取accessToken
        [self accessTokenWithCode:code];
    }
    return YES;
}

/**
 *  client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 必选	类型及范围	说明
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 *
 *  @param code <#code description#>
 */
- (void)accessTokenWithCode:(NSString *)code {
    
    // 1.创建请求管理类
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 2.设置参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"1470846510";
    params[@"client_secret"] = @"f8464bfebacaf842c7a25cf6a71b68bb";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"https://www.baidu.com/";
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        // 4.先将字典转为模型
        XXRAccount *account = [XXRAccount accountWithDict:responseObject];
        XXRLog(@"请求成功:%@", responseObject);
        
        // 5.存储模型信息:归档
        // 获取沙盒Document路径
        [XXRAccountTool saveAccount:account];
        
        // 6.登录成功，会有两种跳转可能(首页、新特性)
        [XXRWeiboTool chooseRootViewController];
        
        // 7.隐藏加载框
        [MBProgressHUD hideHUD];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        XXRLog(@"请求失败:%@", error);
        [MBProgressHUD hideHUD];
    }];
}

@end
