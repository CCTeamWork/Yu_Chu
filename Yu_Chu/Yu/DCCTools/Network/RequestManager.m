

#import "RequestManager.h"
#import <AFNetworking/AFNetworking.h>
#import <objc/runtime.h>
#import "AFNetworkActivityIndicatorManager.h"

//#define baseUrl  @"http://118.190.84.191/"
//#define BaseUrl   @"http://192.168.10.69:8199/"

@interface RequestManager ()

@property (nonatomic) AFHTTPSessionManager *sessionManager;

@end

static NSString *const JinQiangXinxiErrorDomain = @"JinQiangXinxiErrorDomain";

@implementation RequestManager
static id instance;

#pragma mark - 配置请求底层参数

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        // 设置请求格式
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        // 设置返回格式
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //设置超时
        [_sessionManager.requestSerializer setTimeoutInterval:10];
    
        _sessionManager.responseSerializer.acceptableContentTypes = [_sessionManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        
        // 检测网络连接的单例,网络变化时的回调方法
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            if(status  == AFNetworkReachabilityStatusNotReachable){
                
                //[SVProgressHUD showErrorWithStatus:@"请检查网络链接"];
                
                [self cancelALLRequest];
                [self cancelAllOperations];
            }
        }];
    }
    return _sessionManager;
}
- (void)cancelAllOperations
{
    [self.sessionManager.operationQueue cancelAllOperations];
}
- (void)cancelALLRequest{
    for (NSURLSessionDataTask* task in self.taskArray) {
        
        [task cancel];
    }
}
#pragma mark 解析服务器返回值
-(void)parserSuccessRequest:(NSURLSessionDataTask * _Nonnull)task responseObject:(id  _Nullable) responseObject WhenComplete:(JinQiangXinxiRequestCompletionn)completion{
    NSError *error = nil;
    id valueData = [self apiResponseParse:responseObject error:&error];
    if (nil == error) {
        //NSLog(@"===Request succeed===");
    }
    else {
        NSLog(@"===Request faild:E%ld===", error.code);
        if (error.code == 10001) {
            //[SVProgressHUD dismiss];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TokenChange" object:nil];
            return;
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (nil != completion) {
            completion(nil == error, valueData, error);
        }
    });
}

-(void)parserFailureRequest:(NSURLSessionDataTask * _Nonnull)task responseObject:(NSError*  _Nonnull)error WhenComplete:(JinQiangXinxiRequestCompletionn)completion{
    if (nil != error) {
        NSLog(@"===Request faild:%ld:%@===", error.code, error.localizedDescription);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if (nil != completion) {
            completion(false, nil, [self JinQiangXinxiErrorFromRC:1]);
        }
    });
}
//解析数据返回代码
- (id)apiResponseParse:(id)responseObject error:(NSError **)error
{
    id valueData = nil;
    id responseDic = nil;
    @try {
        NSError *error;
        
        responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
    } @catch (NSException *exception) {
        [self cancelALLRequest];
        
        return nil;
    }
    
//    NSInteger rcCode = [[responseDic valueWithNilForKey:@"code"] integerValue];
//    valueData = responseDic;
//    if (200 != rcCode) {
////        *error = [self JinQiangXinxiErrorFromRC:rcCode];
//        *error = [NSError errorWithDomain:JinQiangXinxiErrorDomain code:rcCode userInfo:@{NSLocalizedDescriptionKey:[responseDic valueWithNilForKey:@"message"]}];
//        objc_setAssociatedObject(*error, NSLocalizedDescriptionKey, valueData, OBJC_ASSOCIATION_COPY_NONATOMIC);
//        
//        valueData = nil;
//    }
    if ([valueData isKindOfClass:[NSNull class]]) {
        valueData = nil;
    }
    return valueData;
}

#pragma mark - 各种请求
- (NSDictionary*)getObjectData:(id)obj {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    
    for(int i = 0;i < propsCount; i++) {
        
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil) {
            
            value = [NSNull null];
        } else {
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }
    
    return dic;
}

- (id)getObjectInternal:(id)obj {
    
    if([obj isKindOfClass:[NSString class]]
       ||
       [obj isKindOfClass:[NSNumber class]]
       ||
       [obj isKindOfClass:[NSNull class]]) {
        
        return obj;
        
    }
    if([obj isKindOfClass:[NSArray class]]) {
        
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        
        for(int i = 0; i < objarr.count; i++) {
            
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    if([obj isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        
        for(NSString *key in objdic.allKeys) {
            
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
    
}
//GET 3279974400 7742697214
- (void)getRequestWithUrl:(NSString *)url params:(id)params WhenComplete:(JinQiangXinxiRequestCompletionn)completion {    
    [self.sessionManager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self parserSuccessRequest:task responseObject:responseObject WhenComplete:completion];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self parserFailureRequest:task responseObject:error WhenComplete:completion];
    }];
}

- (void)AFNPostRequestWithUrl:(NSString *)url params:(id)params WhenComplete:(JinQiangXinxiRequestCompletionn)completion{
        [self.sessionManager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self parserSuccessRequest:task responseObject:responseObject WhenComplete:completion];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self parserFailureRequest:task responseObject:error WhenComplete:completion];
        }];
}


- (NSError *)JinQiangXinxiErrorFromRC:(NSInteger)rcCode
{
    /*
     300001   db异常
     3000002  系统异常
     3000003  请求结果为空
     */
    NSString *errorInfo = @"";
    switch (rcCode) {
        case 1:
            errorInfo = @"请求失败，请重新请求";
            break;
        default:
            break;
    }
    return [NSError errorWithDomain:JinQiangXinxiErrorDomain code:rcCode userInfo:@{NSLocalizedDescriptionKey:errorInfo}];
}

- (void)POSTLoadRequestWithUrl:(NSString *)url params:(id)params withDataArray:(NSArray <NSData *>*)dataArray WhenComplete:(JinQiangXinxiRequestCompletionn)completion{
    
    [self.sessionManager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSInteger i = 0 ; i < dataArray.count; i++) {
            NSData *data = dataArray[i];
            //使用日期生成图片名称
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            
            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            
            NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
            
            [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"photos[%li]",i] fileName:[NSString stringWithFormat:@"%@image%li.png",fileName,i] mimeType:@"image/png"];
        }   

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        NSLog(@"上传进度%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self parserSuccessRequest:task responseObject:responseObject WhenComplete:completion];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self parserFailureRequest:task responseObject:error WhenComplete:completion];
    }];
}

@end
