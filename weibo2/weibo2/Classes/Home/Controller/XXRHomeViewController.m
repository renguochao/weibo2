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
#import <SDWebImage/UIImageView+WebCache.h>
#import "XXRStatus.h"

#define kXXRTitleButtonDownTag 0
#define kXXRTitleButtonUpTag -1

@interface XXRHomeViewController ()
@property (nonatomic, strong) NSArray *statuses;
@end

@implementation XXRHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNavigationBar];
    
    // 加载微博数据
    [self loadWeiboStatusData];
}

- (void)loadWeiboStatusData {
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [XXRAccountTool account].access_token;
    
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        // 取出所有的微博数据
        NSArray *dictArray = responseObject[@"statuses"];
        
        // 将字典数据转换成模型数据
        NSMutableArray *statusArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            // 创建模型
            XXRStatus *status = [XXRStatus statusWithDict:dict];
            
            // 添加模型
            [statusArray addObject:status];
        }
        self.statuses = statusArray;
        
        [self.tableView reloadData];
        XXRLog(@"----%@:", responseObject);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
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
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1.创建cell
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 2.设置cell的数据
    // 微博内容
    XXRStatus *status = self.statuses[indexPath.row];
    cell.textLabel.text = status.text;
    
    // 微博作者
    XXRUser *user = status.user;
    cell.detailTextLabel.text = user.name;
    
    // 作者头像
    NSString *iconUrl = user.profile_image_url;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[UIImage imageNamed:@"find_people"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
//    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:iconUrl]];
//    cell.imageView.image = [UIImage imageWithData:imageData];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor blackColor];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
