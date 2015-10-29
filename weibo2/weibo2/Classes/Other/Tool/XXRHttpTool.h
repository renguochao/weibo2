//
//  XXRHttpTool.h
//  weibo2
//
//  Created by rgc on 15/10/18.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface XXRHttpTool : NSObject

/**
 *  发送post请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param sucess  请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))sucess failure:(void (^)(NSError *error))failure;

/**
 *  发送包含二进制文件的post请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param block   构造表单数据的回调
 *  @param sucess  请求成功后的回调
 *  @param failure 请求失败后的回调
 */
//+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>  formData))block success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

/**
 *  发送包含二进制文件的post请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param formData 文件参数
 *  @param sucess  请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

/**
 *  发送get请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param sucess  请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))sucess failure:(void (^)(NSError *error))failure;

@end

/**
 *  用于封装文件数据的模型
 */
@interface XXRFormData : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;
@end
