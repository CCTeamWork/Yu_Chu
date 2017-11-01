//
//  MSUAFNRequest.h
//  秀贝
//
//  Created by Zhuge_Su on 2017/6/7.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^resultObjectBlock)(id obj , NSError *error);

@interface MSUAFNRequest : NSObject

/// 回调
@property (nonatomic , strong)resultObjectBlock resultblock;

/* 单例方法 */
+ (instancetype)sharedInstance;

/* POST 请求方法 */
- (void)postRequestWithURL:(NSString *)url parameters:(id)paramObj withBlock:(resultObjectBlock)block;

/* POST 请求照片 */
- (void)postRequestUploadImageWithURL:(NSString *)url imaData:(NSData *)imaData videoData:(NSData *)videoData parameters:(id)paramObj withBlock:(resultObjectBlock)block;

/* POST请求 多张图片上传 */
- (void)postMoreUploadImageWithURL:(NSString *)url imaDataArr:(NSMutableArray *)imaDataArr parameters:(id)paramObj withBlock:(resultObjectBlock)block;

/* GET 请求方法 */
+ (void)getRequestWithURL:(NSString *)url parameters:(id)paramObj withBlock:(resultObjectBlock)block;

@end
