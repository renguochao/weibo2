//
//  XXRHomeViewController.m
//  weibo2
//
//  Created by rgc on 15/8/11.
//  Copyright (c) 2015年 rgc. All rights reserved.
//

#import "XXRHomeViewController.h"

#import "Common.h"
#import "UIBarButtonItem+XXR.h"
#import "UIImage+XXR.h"
#import "XXRTitleButton.h"
#import "AFNetworking.h"
#import "XXRAccountTool.h"
#import "XXRAccount.h"
#import "XXRStatus.h"
#import "XXRStatusFrame.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJExtension/MJExtension.h>
#import "XXRStatusCell.h"
#import "XXRPhoto.h"

#define kXXRTitleButtonDownTag 0
#define kXXRTitleButtonUpTag -1

@interface XXRHomeViewController ()
@property (nonatomic, strong) NSMutableArray *statusFrames;
@end

@implementation XXRHomeViewController

- (NSMutableArray *)statusFrames {
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNavigationBar];
    
    // 添加刷新控件
    [self setupRefreshControl];
    
}

- (void)setupRefreshControl {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshControlStateChanged:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    // 自动进入刷新状态(不会触发监听方法)
    [refreshControl beginRefreshing];
    
    // 更改refreshControl的状态
    [self refreshControlStateChanged:refreshControl];
}

- (void)refreshControlStateChanged:(UIRefreshControl *)refreshControl {
    
    XXRLog(@"------refreshControlStateChanged------");
    // 刷新数据，向新浪请求更新数据
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [XXRAccountTool account].access_token;
    params[@"count"] = @5;
    if (self.statusFrames.count) {
        XXRStatusFrame *statusFrame = self.statusFrames[0];
        // 加载ID比since_id大的微博
        params[@"since_id"] = statusFrame.status.idstr;
    }
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        // 取出所有的微博数据
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        // 将字典数组转换成模型数组
        [XXRStatus setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"pic_urls" : [XXRPhoto class]
                     };
        }];
        NSArray *statusArray = [XXRStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        for (XXRStatus *status in statusArray) {
            XXRStatusFrame *statusFrame = [[XXRStatusFrame alloc] init];
            [statusFrame setStatus:status];
            [statusFrameArray addObject:statusFrame];
        }
        
        // 将新数据插在旧数据前面
        NSMutableArray *tmpArray = [NSMutableArray array];
        [tmpArray addObjectsFromArray:statusFrameArray];
        [tmpArray addObjectsFromArray:self.statusFrames];
        
        self.statusFrames = tmpArray;
        
        [self.tableView reloadData];
//        for (NSDictionary *dict in responseObject[@"statuses"]) {
//            XXRLog(@"%@", dict);
//        }
        // 让刷新控件停止显示刷新状态
        [refreshControl endRefreshing];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        // 让刷新控件停止显示刷新状态
        [refreshControl endRefreshing];
    }];
}

- (void)setupNavigationBar {
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch_os7" highIcon:@"navigationbar_friendsearch_highlighted_os7" target:self action:@selector(findFriend)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop_os7" highIcon:@"navigationbar_pop_highlighted_os7" target:self action:@selector(pop)];
    
    // 中间按钮
    XXRTitleButton *titleButton = [[XXRTitleButton alloc] init];
    
    // 图标
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down_os7"] forState:UIControlStateNormal];
    
    // 文字
    [titleButton setTitle:@"拉风的小囊" forState:UIControlStateNormal];
    titleButton.frame = CGRectMake(0, 0, 130, 35);
    titleButton.tag = kXXRTitleButtonDownTag;
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    
    self.tableView.backgroundColor = XXRColor(226, 226, 226);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置tableview有额外的滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, XXRStatusCellBorder, 0);
}

- (void)titleClick:(XXRTitleButton *)titleButton {
    if (titleButton.tag == kXXRTitleButtonUpTag) {
        [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down_os7"] forState:UIControlStateNormal];
        titleButton.tag = kXXRTitleButtonDownTag;
    } else {
        [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up_os7"] forState:UIControlStateNormal];
        titleButton.tag = kXXRTitleButtonUpTag;
    }
}

- (void)pop {
    XXRLog(@"pop");
}

- (void)findFriend {
    XXRLog(@"findFriend");
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1.创建cell
    XXRStatusCell *cell = [XXRStatusCell cellWithTableView:tableView];
        
    // 2.设置StatusFrame
    [cell setStatusFrame:[self.statusFrames objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XXRStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UIViewController *vc = [[UIViewController alloc] init];
//    vc.view.backgroundColor = [UIColor blackColor];
//    [self.navigationController pushViewController:vc animated:YES];
//}

@end
