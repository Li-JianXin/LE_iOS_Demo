//
//  ILERHTTPManager.h
//  httpManager_AFN_demo
//
//  Created by jianxin.li on 2016/10/18.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILERHTTPSessionManager.h"

/**请求类型*/
typedef NS_ENUM(NSUInteger, HttpRequestType) {
    HttpRequestTypeGet,
    HttpRequestTypePost
};


@interface ILERHTTPManager : NSObject

+ (instancetype)manager;

/**
 *  网络请求的实例方法
 *
 *  @param type             get / post
 *  @param URLString        请求的地址
 *  @param parameters       请求的参数
 *  @param success          请求成功的回调
 *  @param failure          请求失败的回调
 *  @param progress         进度
 */
- (NSURLSessionDataTask *)requestWithType:(HttpRequestType)type URLString:(NSString *)URLString
                               parameters:(id)parameters
                                  success:(void (^)(id responseObject))success
                                  failure:(void (^)(NSError * error))failure
                                 progress:(void (^)(NSProgress *downloadProgress))progress;

/**
 *  上传图片
 *
 *  @param URLString   上传图片地址
 *  @param parameters  参数
 *  @parm imageArray   上传的图片数组(按需求进行压缩)
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 *  @param progress    上传进度
 *
 */
- (void)uploadImageWithURLString:(NSString *)URLString
                      parameters:(id)parameters
                      imageArray:(NSArray <UIImage *> *)imageArray
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError * error))failure
                        progress:(void (^)(NSProgress *downloadProgress))progress;


/** 对NSURLSessionDataTask有需求使用以下两个方法 */
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask * task,id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

- (NSURLSessionDataTask *)POST:(NSString *)url
                        params:(NSDictionary *)params
                       success:(void (^)(NSURLSessionDataTask * task,id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

/**
 *  取消所有的网络请求
 */
- (void)cancelAllRequest;

/**
 *  取消指定的url请求
 *
 *  @param requestType 该请求的请求类型
 *  @param string      该请求的url
 */
- (void)cancelHttpRequestWithRequestType:(NSString *)requestType requestUrlString:(NSString *)string;


@end
