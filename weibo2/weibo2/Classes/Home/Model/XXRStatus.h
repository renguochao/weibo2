//
//  XXRStatus.h
//  weibo2
//
//  Created by rgc on 15/10/1.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXRUser.h"

@interface XXRStatus : NSObject
/**
 *  微博内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  微博时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  微博ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博配图
 */
@property (nonatomic, strong) NSString *thumbnail_pic;
/**
 *  转发次数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  评论次数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  微博的表态数(被赞数)
 */
@property (nonatomic, assign) int attitudes_count;
/**
 *  微博作者
 */
@property (nonatomic, strong) XXRUser *user;
/**
 *  转发的微博
 */
@property (nonatomic, strong) XXRStatus *retweeted_status;

//+ (id)statusWithDict:(NSDictionary *)dict;
//
//- (id)initWithDict:(NSDictionary *)dict;

@end

/*

 {
     "created_at": "Tue May 31 17:46:55 +0800 2011",
     "id": 11488058246,
     "text": "求关注。"，
     "source": "<a href="http://weibo.com" rel="nofollow">新浪微博</a>",
     "favorited": false,
     "truncated": false,
     "in_reply_to_status_id": "",
     "in_reply_to_user_id": "",
     "in_reply_to_screen_name": "",
     "geo": null,
     "mid": "5612814510546515491",
     "reposts_count": 8,
     "comments_count": 9,
     "annotations": [],
     "user": {
         "id": 1404376560,
         "screen_name": "zaku",
         "name": "zaku",
         "province": "11",
         "city": "5",
         "location": "北京 朝阳区",
         "description": "人生五十年，乃如梦如幻；有生斯有死，壮士复何憾。",
         "url": "http://blog.sina.com.cn/zaku",
         "profile_image_url": "http://tp1.sinaimg.cn/1404376560/50/0/1",
         "domain": "zaku",
         "gender": "m",
         "followers_count": 1204,
         "friends_count": 447,
         "statuses_count": 2908,
         "favourites_count": 0,
         "created_at": "Fri Aug 28 00:00:00 +0800 2009",
         "following": false,
         "allow_all_act_msg": false,
         "remark": "",
         "geo_enabled": true,
         "verified": false,
         "allow_all_comment": true,
         "avatar_large": "http://tp1.sinaimg.cn/1404376560/180/0/1",
         "verified_reason": "",
         "follow_me": false,
         "online_status": 0,
         "bi_followers_count": 215
     }
 }

*/