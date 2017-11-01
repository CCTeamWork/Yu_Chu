//
//  MSUAFNRequest.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/6/7.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUAFNRequest.h"
#import <AFNetworking.h>

@implementation MSUAFNRequest

#pragma mark - 单例
/* 单例 */
+ (instancetype)sharedInstance{
    static MSUAFNRequest *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

#pragma mark - 请求相关
/* POST请求 */
- (void)postRequestWithURL:(NSString *)url parameters:(id)paramObj withBlock:(resultObjectBlock)block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    /// 请求超时时间
    manager.requestSerializer.timeoutInterval = 20.0;
    /// 缓存策略
    manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    /// 支持类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    /// 是否允许访问证书过期的地址
    manager.securityPolicy.allowInvalidCertificates = YES;
    /// 转码编码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [manager POST:url parameters:paramObj progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil,error);
    }];
}

/* POST请求 视频 和 图片上传 */
- (void)postRequestUploadImageWithURL:(NSString *)url imaData:(NSData *)imaData videoData:(NSData *)videoData parameters:(id)paramObj withBlock:(resultObjectBlock)block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    /// 请求超时时间
    manager.requestSerializer.timeoutInterval = 20.0;
    /// 缓存策略
    manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    /// 支持类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    /// 是否允许访问证书过期的地址
    manager.securityPolicy.allowInvalidCertificates = YES;
    /// 转码编码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [manager POST:url parameters:paramObj constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imaData name:@"image" fileName:@"image.png" mimeType:@"image/png"];
        [formData appendPartWithFileData:videoData name:@"video" fileName:@"videoName.mp4" mimeType:@"video/mpeg"];

    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil,error);
    }];
}

/* POST请求 多张图片上传 */
- (void)postMoreUploadImageWithURL:(NSString *)url imaDataArr:(NSMutableArray *)imaDataArr parameters:(id)paramObj withBlock:(resultObjectBlock)block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    /// 请求超时时间
    manager.requestSerializer.timeoutInterval = 20.0;
    /// 缓存策略
    manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    /// 支持类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    /// 是否允许访问证书过期的地址
    manager.securityPolicy.allowInvalidCertificates = YES;
    /// 转码编码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [manager POST:url parameters:paramObj constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSInteger i = 0; i < imaDataArr.count; i++) {
            NSData *imaData = imaDataArr[i];
            [formData appendPartWithFileData:imaData name:[NSString stringWithFormat:@"image%ld",i] fileName:@"image.png" mimeType:@"image/png"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil,error);
        
    }];
}

/* GET请求 */
+ (void)getRequestWithURL:(NSString *)url parameters:(id)paramObj withBlock:(resultObjectBlock)block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    /// 请求超时时间
    manager.requestSerializer.timeoutInterval = 20.0;
    /// 缓存策略
    manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    /// 支持类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    /// 是否允许访问证书过期的地址
    manager.securityPolicy.allowInvalidCertificates = YES;
    /// 转码编码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [manager GET:url parameters:paramObj progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil,error);
    }];
    
}


@end
