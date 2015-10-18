//
//  XXRComposeViewController.m
//  weibo2
//
//  Created by rgc on 15/10/10.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRComposeViewController.h"
#import "XXRTextView.h"
#import "XXRComposeToolbar.h"
#import "XXRComposePhotosView.h"

#import "Common.h"
#import "XXRAccountTool.h"
#import <AFNetworking/AFNetworking.h>
#import "MBProgressHUD+MJ.h"

@interface XXRComposeViewController () <UITextViewDelegate, XXRComposeToolbarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, weak) XXRComposeToolbar *toolbar;
@property (nonatomic, weak) XXRComposePhotosView *photosView;

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
    
    // 添加toolbar
    [self setupToolbar];
    
    // 添加imageView
    [self setupPhotosView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // View一显示时就弹出键盘
    [self.textView becomeFirstResponder];
}

#pragma mark - 代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)composeToolbar:(XXRComposeToolbar *)composeToolbar didClickedButtonType:(XXRComposeToolbarButtonType)toolbarButtonType {
    switch (toolbarButtonType) {
        case XXRComposeToolbarButtonTypeCamera:
            [self openCamera];
            break;
        case XXRComposeToolbarButtonTypePicture:
            [self openPhotoLibrary];
            break;
        case XXRComposeToolbarButtonTypeMetion:
            
            break;
        case XXRComposeToolbarButtonTypeTrend:
            
            break;
        case XXRComposeToolbarButtonTypeEmotion:
            
            break;
            
        default:
            break;
    }
}

- (void)openCamera {
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)openPhotoLibrary {
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 1.销毁picker控制器
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 2.获取图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosView addImage:image];
    NSLog(@"%@", info);
}

/**
 *  添加imageView
 */
- (void)setupPhotosView {
    XXRComposePhotosView *photosView = [[XXRComposePhotosView alloc] init];
    CGFloat photosViewY = 80;
    CGFloat photosViewW = self.textView.frame.size.width;
    CGFloat photosViewH = self.textView.frame.size.height;
    photosView.frame = CGRectMake(0, photosViewY, photosViewW, photosViewH);
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

/**
 *  添加toolbar
 */
- (void)setupToolbar {
    XXRComposeToolbar *toolbar = [[XXRComposeToolbar alloc] init];
    CGFloat toolbarH = 44;
    CGFloat toolbarW = self.view.frame.size.width;
    CGFloat toolbarX = 0;
    CGFloat toolbarY = self.view.frame.size.height - toolbarH;
    toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    self.toolbar.delegate = self;
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
    // 设置textView可以垂直方向上拖拉
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 2.监听textView文字改变的通知
    // 右边对象发出的通知，我们就会调用Observer的方法
    [XXRNotificationCenter addObserver:self selector:@selector(textViewTextDidChanged:) name:UITextViewTextDidChangeNotification object:textView];
    
    // 3.监听键盘的通知
    [XXRNotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [XXRNotificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

/**
 *  键盘即将显示的时候调用
 */
- (void)keyboardWillShow:(NSNotification *)note {
//    XXRLog(@"%@", note);
    
    // 1.取出键盘的frame
    CGRect keyboardF = [note.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    // 2.取出动画持续时间
    CGFloat duration = [note.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardF.size.height);
    }];
}

/**
 *  键盘即将隐藏的时候调用
 */
- (void)keyboardWillHide:(NSNotification *)note {
    
    // 1.取出动画持续时间
    CGFloat duration = [note.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    
    // 2.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendWithImage)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.title = @"发微博";
}

- (void)sendWithImage {
    // 1.创建请求管理类
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 2.设置参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [XXRAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    // 3.发送请求
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 在发送请求之前调用这个block
        // 必须在这里说明要上传哪些文件
        NSArray *images = [self.photosView totalImages];
        for (UIImage *image in images) {
            NSData *data = UIImageJPEGRepresentation(image, 0.1);
            [formData appendPartWithFileData:data name:@"pic" fileName:@"" mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    
    // 4.关闭控制器
    [self cancel];
}

- (void)sendWithoutImage {
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
