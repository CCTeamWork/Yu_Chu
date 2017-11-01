

#import <Foundation/Foundation.h>


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


@end
