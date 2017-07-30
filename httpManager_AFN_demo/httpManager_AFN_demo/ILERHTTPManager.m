//
//  ILERHTTPManager.m
//  httpManager_AFN_demo
//
//  Created by jianxin.li on 2016/10/18.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#import "ILERHTTPManager.h"

#define BaseURL @"http://sandbox.api.m.m6go.com/iosapi"

@interface ILERHTTPManager ()

@property (nonatomic, strong) ILERHTTPSessionManager *manager;

@end

@implementation ILERHTTPManager

+ (instancetype)manager {
    return [[[self class] alloc] init];
}

- (NSURLSessionDataTask *)requestWithType:(HttpRequestType)type URLString:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure progress:(void (^)(NSProgress *))progress {
    switch (type) {
            
        case HttpRequestTypeGet: {
            return [self.manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                progress(downloadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
            }];
        } break;
            
        case HttpRequestTypePost: {
            return [self.manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                progress(uploadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
            }];
        } break;
            
        default:
            break;
    }
    return nil;
}

- (void)uploadImageWithURLString:(NSString *)URLString parameters:(id)parameters imageArray:(NSArray<UIImage *> *)imageArray success:(void (^)(id))success failure:(void (^)(NSError *))failure progress:(void (^)(NSProgress *))progress {
    [self.manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSUInteger i = 0 ;
        for (UIImage *image in imageArray) {
            NSData * imgData = UIImageJPEGRepresentation(image, .5);
            [formData appendPartWithFileData:imgData name:[NSString stringWithFormat:@"picflie%ld",(long)i] fileName:@"image.png" mimeType:@"image/jpeg"];
            i++;
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (NSURLSessionDataTask *)GET:(NSString *)url parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    return [self.manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

- (NSURLSessionDataTask *)POST:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    return [self.manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

- (void)cancelAllOperations {
    [self.manager.operationQueue cancelAllOperations];
}

- (void)cancelAllRequest {
    [self.manager.operationQueue cancelAllOperations];
}

- (void)cancelHttpRequestWithRequestType:(NSString *)requestType requestUrlString:(NSString *)string {
    NSError * error;
    // 根据请求的类型 以及 请求的url创建一个NSMutableURLRequest---通过该url去匹配请求队列中是否有该url,如果有的话 那么就取消该请求
    NSString * urlToPeCanced = [[[self.manager.requestSerializer requestWithMethod:requestType URLString:string parameters:nil error:&error] URL] path];
    for (NSOperation * operation in self.manager.operationQueue.operations) {
        //如果是请求队列
        if ([operation isKindOfClass:[NSURLSessionTask class]]) {
            // 请求的类型匹配
            BOOL hasMatchRequestType = [requestType isEqualToString:[[(NSURLSessionTask *)operation currentRequest] HTTPMethod]];
            // 请求的url匹配
            BOOL hasMatchRequestUrlString = [urlToPeCanced isEqualToString:[[[(NSURLSessionTask *)operation currentRequest] URL] path]];
            // 两项都匹配的话  取消该请求
            if (hasMatchRequestType&&hasMatchRequestUrlString) {
                [operation cancel];
            }
        }
    }
}

#pragma mark - Private

- (ILERHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [[ILERHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURL]];
    }
    return _manager;
}


@end
