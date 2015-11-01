//
//  XXRHomeViewController.m
//  weibo2
//
//  Created by rgc on 15/8/11.
//  Copyright (c) 2015年 rgc. All rights reserved.
//

#import "XXRHomeViewController.h"

#import "UIBarButtonItem+XXR.h"
#import "UIImage+XXR.h"
#import "XXRTitleButton.h"
#import "XXRAccount.h"
#import "XXRStatus.h"
#import "XXRStatusFrame.h"
#import "XXRStatusCell.h"
#import "XXRPhoto.h"
#import "XXRHomeStatusesParam.h"

#import "Common.h"
#import "XXRAccountTool.h"
#import "XXRStatusTool.h"
#import "XXRHttpTool.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>

#define kXXRTitleButtonDownTag 0
#define kXXRTitleButtonUpTag -1

@interface XXRHomeViewController ()
@property (nonatomic, weak) XXRTitleButton *titleButton;
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
    
    // 添加刷新控件
    [self setupRefreshView];
    
    // 设置导航栏
    [self setupNavigationBar];
    
    // 获取用户信息
    [self setupUserData];
}

- (void)setupRefreshView {
    // 1.下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.header.automaticallyChangeAlpha = YES;
    // 开始刷新
    [self.tableView.header beginRefreshing];
    
    // 2.上拉加载
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

/**
 *  加载最新微博数据
 */
- (void)loadNewData {
    // 刷新数据，向新浪请求加载最新数据
    // 1.封装请求参数
    XXRHomeStatusesParam *param = [[XXRHomeStatusesParam alloc] init];
    param.access_token = [XXRAccountTool account].access_token;
    param.count = @(5);
    if (self.statusFrames.count) {
        XXRStatusFrame *statusFrame = self.statusFrames[0];
        param.since_id = @([statusFrame.status.idstr longLongValue]);
    }
    // 2.发送请求
    [XXRStatusTool homeStatusWithParam:param success:^(XXRHomeStatusesResult *result) {
        // 取出所有的微博数据
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (XXRStatus *status in result.statuses) {
            XXRStatusFrame *statusFrame = [[XXRStatusFrame alloc] init];
            [statusFrame setStatus:status];
            [statusFrameArray addObject:statusFrame];
        }
        
        // 将新数据插在旧数据前面
        NSMutableArray *tmpArray = [NSMutableArray array];
        [tmpArray addObjectsFromArray:statusFrameArray];
        [tmpArray addObjectsFromArray:self.statusFrames];
        self.statusFrames = tmpArray;
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 显示最新微博的数量
        [self showNewStatusCount:statusFrameArray.count];
        
        // 结束刷新
        [self.tableView.header endRefreshing];
    } failure:^(NSError *error) {
        // 结束刷新
        [self.tableView.header endRefreshing];
    }];
    
}

/**
 *  加载更多微博
 */
- (void)loadMoreData {
    
    // 刷新数据，向新浪请求加载更多数据
    // 1.封装请求参数
    XXRHomeStatusesParam *param = [[XXRHomeStatusesParam alloc] init];
    param.access_token = [XXRAccountTool account].access_token;
    param.count = @(10);
    if (self.statusFrames.count) {
        XXRStatusFrame *statusFrame = [self.statusFrames lastObject];
        // 加载ID比max_id小的微博
        long long maxId = [statusFrame.status.idstr longLongValue] - 1;
        param.max_id = @(maxId);
    }
    
    // 2.发送请求
    [XXRStatusTool homeStatusWithParam:param success:^(XXRHomeStatusesResult *result) {
        // 取出所有的微博数据
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (XXRStatus *status in result.statuses) {
            XXRStatusFrame *statusFrame = [[XXRStatusFrame alloc] init];
            [statusFrame setStatus:status];
            [statusFrameArray addObject:statusFrame];
        }

        // 将旧数据插到最后面
        [self.statusFrames addObjectsFromArray:statusFrameArray];

        // 刷新表格
        [self.tableView reloadData];

        // 显示最新微博的数量
        [self showNewStatusCount:statusFrameArray.count];
        
        // 结束刷新
        [self.tableView.footer endRefreshing];
    } failure:^(NSError *error) {
        // 结束刷新
        [self.tableView.footer endRefreshing];
    }];
}

- (void)setupUserData {
    
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [XXRAccountTool account].access_token;
    params[@"uid"] = @([XXRAccountTool account].uid);
    
    // 2.发送请求
    [XXRHttpTool getWithURL:@"https://api.weibo.com/2/users/show.json" params:params success:^(id json) {
        // 字典转模型
        XXRUser *user = [XXRUser objectWithKeyValues:json];
        // 设置标题文字
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        // 保存昵称
        XXRAccount *account = [XXRAccountTool account];
        account.name = user.name;
        [XXRAccountTool saveAccount:account];
    } failure:^(NSError *error) {
        
    }];
    
}

/**
 *  显示最新微博的数量
 */
- (void)showNewStatusCount:(int)count {
    // 1.创建一个按钮
    UIButton *btn = [[UIButton alloc] init];
    
    // 2.将按钮添加在self.navigationController.navigationBar的下面
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    // 3.设置按钮
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    if (count) {
        NSString *title = [NSString stringWithFormat:@"共有%d条新的微博", count];
        [btn setTitle:title forState:UIControlStateNormal];
    } else {
        [btn setTitle:@"没有新的微博" forState:UIControlStateNormal];
    }
    
    // 4.这是按钮的初始frame
    CGFloat btnH = 30;
    CGFloat btnY = 64 - btnH;
    CGFloat btnX = 2;
    CGFloat btnW = self.view.frame.size.width - 2 * btnX;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    // 5.通过动画移动按钮(按钮向下移动 btnH + 1)
    [UIView animateWithDuration:0.7 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, btnH + 2);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.7 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
        }];
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
    
    // 位置和尺寸
    titleButton.frame = CGRectMake(0, 0, 0, 35);
    
    // 文字
    if ([XXRAccountTool account].name) {
        [titleButton setTitle:[XXRAccountTool account].name forState:UIControlStateNormal];
    } else {
        [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    }
    titleButton.tag = kXXRTitleButtonDownTag;
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;
    
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
