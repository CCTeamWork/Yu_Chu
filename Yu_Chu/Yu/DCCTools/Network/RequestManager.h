

#import <Foundation/Foundation.h>
#import "XLZHHeader.h"


typedef void (^JinQiangXinxiRequestCompletionn)(BOOL succeed, id responseData, NSError* error);

@interface RequestManager : NSObject

@property (nonatomic, retain) NSMutableArray* taskArray;

//初始化方式
+ (instancetype)sharedInstance;

//AFN-get
- (void)getRequestWithUrl:(NSString *)url params:(id)params WhenComplete:(JinQiangXinxiRequestCompletionn)completion;

//AFN-post
- (void)AFNPostRequestWithUrl:(NSString *)url params:(id)params WhenComplete:(JinQiangXinxiRequestCompletionn)completion;

/** 文件上传 */
- (void)POSTLoadRequestWithUrl:(NSString *)url params:(id)params withDataArray:(NSArray <NSData *>*)dataArray WhenComplete:(JinQiangXinxiRequestCompletionn)completion;

//添加收货地址
- (void)uploadLocationAddressToSVR:(NSMutableDictionary *)params WhenComplete:(JinQiangXinxiRequestCompletionn)completion;

//删除收货地址
- (void)removeLocationAddressToSVR:(NSMutableDictionary *)params WhenComplete:(JinQiangXinxiRequestCompletionn)completion;

//获取收货列表
- (void)getConfirmLocationListWith:(NSMutableDictionary *)params WhenComplete:(JinQiangXinxiRequestCompletionn)completion;

//获取验证码
- (void)getVerificationWith:(NSMutableDictionary *)params WhenComplete:(JinQiangXinxiRequestCompletionn)completion;

//登陆 获取token
- (void)loginAndGetToken:(NSMutableDictionary *)params WhenComplete:(JinQiangXinxiRequestCompletionn)completion;

//获取用户信息
- (void)getUserInfomation:(NSMutableDictionary *)params WhenComplete:(JinQiangXinxiRequestCompletionn)completion;

//获取购物车信息
- (void)getSHopCarInfomation:(NSMutableDictionary *)params WhenComplete:(JinQiangXinxiRequestCompletionn)completion;

@end
