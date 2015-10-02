//
//  XXRUser.h
//  weibo2
//
//  Created by rgc on 15/10/1.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXRUser : NSObject
/**
 *  用户id
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  用户名字
 */
@property (nonatomic, copy) NSString *name;
/**
 *  用户头像
 */
@property (nonatomic, copy) NSString *profile_image_url;
/**
 *  会员等级
 */
@property (nonatomic, assign) int mbrank;
/**
 *  会员类型
 */
@property (nonatomic, assign) int mbtype;

//+ (id)userWithDict:(NSDictionary *)dict;
//
//- (id)initWithDict:(NSDictionary *)dict;

@end

/*
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

*/