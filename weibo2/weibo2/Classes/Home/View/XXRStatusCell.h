//
//  XXRStatusCell.h
//  weibo2
//
//  Created by rgc on 15/10/1.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXRStatusFrame;
@interface XXRStatusCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) XXRStatusFrame *statusFrame;
@end
