//
//  AppDelegate.h
//  Yu
//
//  Created by 何龙飞 on 2017/10/31.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MSUTabbarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, copy) NSString *token;//token 为@""代表未登陆，不为空代表已经登陆

@property (nonatomic, strong) MSUTabbarController *mainTabBar;

@end

