//
//  XLTool.m
//  GDD6.14
//
//  Created by GDD on 2017/10/16.
//  Copyright © 2017年 GDD. All rights reserved.
//

#import "XLTool.h"

@implementation XLTool

#pragma mark 缓存

/**
 清除缓存
 */
+ (void)clearCache{
    NSString *path = [self getCachesPath];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}

//获取缓存文件路径
+(NSString *)getCachesPath{
    // 获取Caches目录路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    
    return cachesDir;
}

/**
 返回缓存大小
 */
+ (NSString *) getCacheSize{
    
    NSString *folderPath = [self getCachesPath];
    NSFileManager* manager = [NSFileManager   defaultManager];
    
    if (![manager  fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString* fileName;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
        
    }
    return [self fileSizeWithInterge:folderSize];;
    
}

//计算出大小
+ (NSString *)fileSizeWithInterge:(NSInteger)size{
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}

//单个文件的大小
+ (long long) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil]  fileSize];
    }
    return 0;
}

#pragma mark 判断登录

/**
 判断是否登录
 */
+ (BOOL)isLogin{
    if ([self getToken].length == 0) {
        return NO;
    }
    return YES;
}

/**
 获取token
 */
+ (NSString *)getToken{
//    if (kAppDelegate.token == nil) {
//        return @"";
//    }
//    return kAppDelegate.token;
    return nil;
}

/**
 创建alert
 actionarray 选项数组
 block 选项对应的操作
 */
- (void)alertController:(id)target title:(NSString *)title message:(NSString *)message actionArray:(NSArray *)actionarray actionBlock:(void(^)(NSInteger actionIndex))block{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i<actionarray.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:actionarray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (block) {
                block(i);
            }
        }];
        [alertController addAction:action];
    }
    [target presentViewController:alertController animated:YES completion:nil];
}

/**
 是否打开消息权限
 */
+ (BOOL)isHaveNotifitationPower{
    BOOL isOpen = YES;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    NSLog(@"seeting %@",setting);
    if (setting.types == UIUserNotificationTypeNone) {
        isOpen = NO;
    }
#else
    UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    if (type == UIRemoteNotificationTypeNone) {
        isOpen = NO;
    }
#endif
    return isOpen;
}

@end
