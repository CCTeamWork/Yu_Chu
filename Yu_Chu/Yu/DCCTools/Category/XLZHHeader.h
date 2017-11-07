//
//  XLZHHeader.h
//  HXBaseProjectDemo
//
//  Created by duanchongchong on 2017/10/19.
//  Copyright © 2017年 段冲冲. All rights reserved.
//

#ifndef XLZHHeader_h
#define XLZHHeader_h

#import "AppDelegate.h"
//#import "AppConfig.h"
#import "NSString+Extension.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "SVProgressHUD.h"
#import "NSDictionary+ValueCheck.h"
#import "UIColor+Expend.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIView+Helpers.h"
#import "UIButton+vertical.h"
#import "DCCBaseNavgationView.h"
#import "RequestManager.h"

//定义颜色 XLZH
#define JQXXXLZHF4F4F4COLOR [UIColor colorWithHexString:@"#f4f4f4"]
#define JQXXXLZH333333COLOR [UIColor colorWithHexString:@"#333333"]
#define JQXXXLZH878787COLOR [UIColor colorWithHexString:@"#878787"]
#define JQXXXLZHD6A51FCOLOR [UIColor colorWithHexString:@"#d6a51f"]
#define JQXXXLZHDDDDDDCOLOR [UIColor colorWithHexString:@"#dddddd"]
#define JQXXXLZHFFFFFFCLOLR [UIColor colorWithHexString:@"#FFFFFF"]
#define JQXXXLZH242728CLOLR [UIColor colorWithHexString:@"#242728"]
#define JQXXXLZHF0F0F0CLOLR [UIColor colorWithHexString:@"#F0F0F0"]
#define JQXXXLZH191919CLOLR [UIColor colorWithHexString:@"#191919"]
#define JQXXXLZH787878CLOLR [UIColor colorWithHexString:@"#787878"]
#define JQXXXLZH030303COLOR [UIColor colorWithHexString:@"#030303"]
#define JQXXXLZHAEAEAECOLOR [UIColor colorWithHexString:@"#AEAEAE"]
#define JQXXXLZH78602ACOLOR [UIColor colorWithHexString:@"#78602A"]
#define JQXXXLZHD6A41DCLOLR [UIColor colorWithHexString:@"#D6A41D"]
#define JQXXXLZHECEEF3COLOR [UIColor colorWithHexString:@"#eceef3"]
#define JQXXXLZHB9C1D6COLOR [UIColor colorWithHexString:@"#B9C1D6"]
#define JQXXXLZHF3F3F3CLOLR [UIColor colorWithHexString:@"#F3F3F3"]
#define JQXXXLZH848484CLOLR [UIColor colorWithHexString:@"#848484"]
#define JQXXXLZH959FA3CLOLR [UIColor colorWithHexString:@"#959fa3"]
#define JQXXXLZH8E8E8ECLOLR [UIColor colorWithHexString:@"#8e8e8e"]
#define JQXXXLZHF73749CLOLR [UIColor colorWithHexString:@"#f73749"]
#define JQXXXLZHFF2D4BCLOLR [UIColor colorWithHexString:@"#ff2d4b"]
#define JQXXXLZH272727CLOLR [UIColor colorWithHexString:@"#272727"]
#define JQXXXLZHFAFAFACLOLR [UIColor colorWithHexString:@"#fafafa"]
#define JQXXXLZHF6F6F6CLOLR [UIColor colorWithHexString:@"#f6f6f6"]
#define JQXXXLZHB7B7B7CLOLR [UIColor colorWithHexString:@"#b7b7b7"]
#define JQXXXLZH000000CLOLR [UIColor colorWithHexString:@"#000000"]
#define JQXXXLZHD2D2D2CLOLR [UIColor colorWithHexString:@"#d2d2d2"]
#define JQXXXLZH7ECEF4CLOLR [UIColor colorWithHexString:@"#7ecef4"]
#define JQXXXLZHFFFADACLOLR [UIColor colorWithHexString:@"#fffada"]



#define PlaceHolderIMG      [UIImage imageNamed:@"placeHolder"]

#define BasePath                [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define AdvertisingPath         [BasePath stringByAppendingString:@"/advertisingHomePage.plist"]
#define SaveTokenPath           [BasePath stringByAppendingString:@"/userToken.plist"]

#define kiOSVersion             [[[UIDevice currentDevice] systemVersion] floatValue]
#define kAppDelegate            ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define KMainWindow             [UIApplication sharedApplication].keyWindow
//登录成功发出的通知名称
#define LOGINSUCCESS            @"LoginSuccess"

//返回安全的字符串
#define kSafeString(str)        str.length > 0 ? str : @""

//屏幕 rect
#define SCREEN_RECT             ([UIScreen mainScreen].bounds)

#define CONTENT_HEIGHT          (kScreenHeight - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)

#define kScreenSize             [[UIScreen mainScreen] bounds].size
#define kDeviceVersion          [[UIDevice currentDevice].systemVersion floatValue]

#define kScreenWidth            ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight           ([[UIScreen mainScreen] bounds].size.height)

#define kAppDelegate            ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define kAppWindow              (kAppDelegate.window)
#define kAppRootViewController  (kAppWindow.rootViewController)

#define UserDefaults            ([NSUserDefaults standardUserDefaults])
#define NotificationCenter      ([NSNotificationCenter defaultCenter])

#define IS_IPHONE_X             kScreenHeight == 812

#pragma mark - 👉🏻Size
//状态栏高度
#define STATUS_BAR_HEIGHT       IS_IPHONE_X?44:20
//NavBar高度
#define NAVIGATION_BAR_HEIGHT   44
//状态栏 ＋ 导航栏 高度
#define STATUS_AND_NAVIGATION_HEIGHT        ((STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT))
//状态栏 ＋ 导航栏 高度 + iPhoneX 底部34
#define DCC_STATUS_AND_NAVIGATION_HEIGHT    ((STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT)+(IS_IPHONE_X?34:0))
//TabBar + iPhoneX 底部34
#define DCC_TabBar_AND_X_HEIGHT    (50)+(IS_IPHONE_X?34:0))
//强引用
#define WeakSelf                    __weak typeof(self) weakSelf = self
//强引用
#define strongfy(type)              __strong typeof(type) type = weak##type;
#endif /* XLZHHeader_h */
