//
//  XXRUserUnreadCountResult.m
//  weibo2
//
//  Created by rgc on 15/11/1.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRUserUnreadCountResult.h"

@implementation XXRUserUnreadCountResult

- (int)messageCount {
    return self.cmt + self.mention_cmt + self.mention_status + self.dm;
}

- (int)count {
    return self.messageCount + self.status + self.follower;
}

@end
