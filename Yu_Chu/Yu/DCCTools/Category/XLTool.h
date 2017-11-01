//
//  XLTool.h
//  GDD6.14
//
//  Created by GDD on 2017/10/16.
//  Copyright © 2017年 GDD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XLTool : NSObject

/**
 清除缓存
 */
+ (void)clearCache;
/**
 返回缓存大小
 */
+ (NSString *) getCacheSize;

/**
 判断是否登录
 */
+ (BOOL)isLogin;

/**
 获取token
 */
+ (NSString *)getToken;

/**
 创建alert
 @param actionarray 选项数组
 @param block 选项对应的操作
 */
- (void)alertController:(id)target title:(NSString *)title message:(NSString *)message actionArray:(NSArray *)actionarray actionBlock:(void(^)(NSInteger actionIndex))block;

/**
 是否打开消息权限
 */
+ (BOOL)isHaveNotifitationPower;

@end
