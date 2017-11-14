//
//  AppDelegate.m
//  Yu
//
//  Created by 何龙飞 on 2017/10/31.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>
#import "MSUTabbarController.h"
#import "MSUPrefixHeader.pch"
#import "MSUPathTools.h"
#import "IQKeyboardManager.h"
#import <BaiduMapAPI/BMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "AFNetworking.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<UIScrollViewDelegate,BMKGeneralDelegate,JPUSHRegisterDelegate>
{
    BMKMapManager* mapManager;
    UIScrollView *_scrollView;
}

@end

@implementation AppDelegate

-(void)setupBaiduMap
{
    mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [mapManager start:@"wCld1dR52syI2TEobsjW75Xg4bNGqZ08" generalDelegate:nil];
    
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self loginToken];
    [self judgeNetIsChange];
    //设置极光推送
    [self setJPUSH:launchOptions];
    [AMapServices sharedServices].apiKey = @"3a4e6ecafefa66c22884cff96f992a799";
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = WHITECOLOR;
    [self.window makeKeyAndVisible];
    //注册键盘修改
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    //本地缓存的版本号  第一次启动的时候本地是没有缓存版本号的。
    NSString *versionCache = [[NSUserDefaults standardUserDefaults] objectForKey:@"VersionCache"];
    //当前应用版本号
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    //如果本地缓存的版本号和当前应用版本号不一样，则是第一次启动（更新版本也算第一次启动）
    if (version == nil || ![versionCache isEqualToString:version])
    {
        [self createRootWithDictionary:launchOptions application:(UIApplication *)application];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(WIDTH * 3, HEIGHT);
//        [self.window addSubview:_scrollView];
        [self.window bringSubviewToFront:_scrollView];
        //启动页的滑动页面
        NSArray *picArray = [[NSArray alloc] initWithObjects:@"yindaoye1", @"yindaoye2",@"yindaoye3",nil];
        
        for (int i = 0; i < picArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * i, 0, WIDTH, HEIGHT)];
            imageView.image = [MSUPathTools showImageWithContentOfFileByName:[picArray objectAtIndex:i]];
            [_scrollView addSubview:imageView];
        }
        
        //设置上下面这句话，将当前版本缓存到本地，下次对比一样，就不走启动视屏了。
        //也可以将这句话放在MSUMovieController.m的进入应用方法enterMainAction里面
        //为了让每次都可以看到启动视屏，这句话先注释掉
        version = [NSString stringWithFormat:@"%@",version];
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"VersionCache"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }else{
        //不是首次启动
        [self createRootWithDictionary:launchOptions application:(UIApplication *)application];
    }

    return YES;
}
-(void)setJPUSH:(NSDictionary *)dic{
    //Required
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:dic appKey:@"f7159e7b714b108ee02be546"
                          channel:@"App Store"
                 apsForProduction:0
            advertisingIdentifier:nil];
}

/* 设置根控制器 */
- (void)createRootWithDictionary:(NSDictionary *)launchOptions application:(UIApplication *)application{
    MSUTabbarController *tab = [[MSUTabbarController alloc] init];
    self.mainTabBar = tab;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tab];
    nav.navigationBar.hidden = YES;
    self.window.rootViewController = nav;
    
    /// 状态栏字体颜色
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    // 百度地图
    [self setupBaiduMap];
}
/**  设置token*/
- (void)loginToken{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"dccLoginToken"]) {
        self.token = [[NSUserDefaults standardUserDefaults] objectForKey:@"dccLoginToken"];
    }else{
        self.token = @"";
    }
}
- (void)judgeNetIsChange{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager ] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //区分Wi-Fi网络还是蜂窝
        switch (status) {
            case -1:
//                NSLog(@"未知网络");
                break;
            case 0:
//                NSLog(@"网络不可达");
                break;
            case 1:
//                NSLog(@"GPRS网络");
                break;
            case 2:
//                NSLog(@"wifi网络");
                break;
            default:
                break;
        }
        if(status ==AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi)
        {
            self.netStatus = YES;
        }else
        {
            self.netStatus = NO;
        }
    }];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    [BMKMapView willBackGround];

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [BMKMapView didForeGround];

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark AliPay
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSString  *resultString = resultDic[@"resultStatus"] ;
            if ([resultString isEqualToString:@"9000"]) {
                //支付成功,这里放你们想要的操作
                NSLog(@"成功了");
                [[NSNotificationCenter defaultCenter]postNotificationName:@"payResult" object:@"1"];
                [SVProgressHUD showSuccessWithStatus:@"支付成功"];
            }
            else{
                NSLog(@"失败了");
                [[NSNotificationCenter defaultCenter]postNotificationName:@"payResult" object:@"0"];
                [SVProgressHUD showErrorWithStatus:@"支付失败"];
            }
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSString  *resultString = resultDic[@"resultStatus"] ;
            if ([resultString isEqualToString:@"9000"]) {
                //支付成功,这里放你们想要的操作
                NSLog(@"成功了");
                [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"payResult" object:@"1"];
            }
            else{
                NSLog(@"失败了");
                [[NSNotificationCenter defaultCenter]postNotificationName:@"payResult" object:@"0"];
                [SVProgressHUD showErrorWithStatus:@"支付失败"];
            }
        }];
    }
    return YES;
}
#pragma mark🎱JPush

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"userTag"]) {
        NSString *userTag = [[NSUserDefaults standardUserDefaults]objectForKey:@"userTag"];
        NSSet *set = [[NSSet alloc] initWithObjects:userTag, nil];
        [JPUSHService setTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
            if (iResCode == 0) {
                NSLog(@"覆盖tag成功");
            }
        } seq:1];
    }
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}
#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support 前台
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionBadge); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    
}

// iOS 10 Support 后台
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // Required, iOS 7 Support 前后台
    [JPUSHService handleRemoteNotification:userInfo];
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        // 处于前台时 ，添加各种需求代码。。。。
        
        
    }else if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive){
        // app 处于后台 ，添加各种需求
        
    }
    completionHandler(UIBackgroundFetchResultNewData);
    
    
}
@end
