//
//  AppDelegate.m
//  Yu
//
//  Created by 何龙飞 on 2017/10/31.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "AppDelegate.h"

#import "MSUTabbarController.h"
#import "MSUPrefixHeader.pch"
#import "MSUPathTools.h"
#import "IQKeyboardManager.h"
#import <BaiduMapAPI/BMapKit.h>


@interface AppDelegate ()<UIScrollViewDelegate,BMKGeneralDelegate>
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
        [self.window addSubview:_scrollView];
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

/* 设置根控制器 */
- (void)createRootWithDictionary:(NSDictionary *)launchOptions application:(UIApplication *)application{
    MSUTabbarController *tab = [[MSUTabbarController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tab];
    nav.navigationBar.hidden = YES;
    self.window.rootViewController = nav;
    
    /// 状态栏字体颜色
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    // 百度地图
    [self setupBaiduMap];
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


@end
