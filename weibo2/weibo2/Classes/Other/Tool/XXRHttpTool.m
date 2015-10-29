//
//  XXRHttpTool.m
//  weibo2
//
//  Created by rgc on 15/10/18.
//  Copyright © 2015年 rgc. All rights reserved.
//

#import "XXRHttpTool.h"

@implementation XXRHttpTool

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))sucess failure:(void (^)(NSError *error))failure {
    // 1.创建请求管理类
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 2.发送请求
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (sucess) {
            sucess(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

//+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>  formData))block success:(void (^)(id json))sucess failure:(void (^)(NSError *error))failure {
//    // 1.创建请求管理类
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    // 2.发送请求
//    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        if (block) {
//            block(formData);
//        }
//    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        if (sucess) {
//            sucess(responseObject);
//        }
//    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id json))success failure:(void (^)(NSError *error))failure {
    // 1.创建请求管理类
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 2.发送请求
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull totalFormData) {
        for (XXRFormData *formData in formDataArray) {
            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
        }
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure {
    // 1.创建请求管理类
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 2.发送请求
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end

/**
 *  用于封装文件数据的模型
 */
@implementation XXRFormData

@end
