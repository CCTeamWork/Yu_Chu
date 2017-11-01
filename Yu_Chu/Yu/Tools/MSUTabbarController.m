//
//  MSUTabbarController.m
//  秀贝
//
//  Created by Zhuge_Su on 2017/5/24.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import "MSUTabbarController.h"
#import "MSUHomePageController.h"
#import "MSUPersonCenterController.h"
#import "MSUShopCarController.h"
#import "MSUOrderController.h"

#import "MSUNaviBaseController.h"
#import "MSUPrefixHeader.pch"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height


@interface MSUTabbarController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation MSUTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 更改tabbar 选中字体颜色
    self.tabBar.tintColor = [UIColor orangeColor];

    // tabbar创建方法
    [self createSystemTabbar];
}

#pragma mark - 旋转相关 （tabbar控制器下的子控制器需要旋转需要重写此方法，且需要旋转哪个控制器就传入哪个）
- (BOOL)shouldAutorotate
{
    //在viewControllers中返回需要改变的NavigationController
    return [self.viewControllers[3] shouldAutorotate];
}


+ (void)load
{
    // 获取当前类的tabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    // 更改tabbar 选中字体颜色
    UITabBar *tabbar = [UITabBar appearanceWhenContainedIn:self, nil];
    tabbar.tintColor = HEXCOLOR(0xf7d721);
    tabbar.backgroundColor = [UIColor whiteColor];
    
    // 设置所有item的选中时颜色
    // 设置选中文字颜色
    // 创建字典去描述文本
    NSMutableDictionary *attSelect = [NSMutableDictionary dictionary];
    // 文本颜色 -> 描述富文本属性的key -> NSAttributedString.h
    attSelect[NSForegroundColorAttributeName] = HEXCOLOR(0xf7d721);
    [item setTitleTextAttributes:attSelect forState:UIControlStateSelected];
    
    // 通过normal状态设置字体大小
    // 字体大小 跟 normal
    NSMutableDictionary *attrNormal = [NSMutableDictionary dictionary];
    // 设置字体
    attrNormal[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [item setTitleTextAttributes:attrNormal forState:UIControlStateNormal];
    
    // 文字偏移量
    [item setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    // icon偏移量
    //    [item setImageInsets:UIEdgeInsetsMake(-2.5, 0, 2.5, 0)];
}

#pragma mark - tabbar 子控制器们
//自封装方法
-(UINavigationController*)createNavWithViewController:(UIViewController *)viewController WithTitle:(NSString*) title image:(UIImage*)image selectedImage:(UIImage *)selectedImage badgeValue:(NSString *)value
{
    MSUNaviBaseController *nav = [[MSUNaviBaseController alloc] initWithRootViewController:viewController];
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage];
    nav.navigationBar.hidden = YES;
    nav.tabBarItem.badgeValue = value;
    return nav;
}

//创建系统tabbar
- (void)createSystemTabbar{
    MSUHomePageController *home = [[MSUHomePageController alloc] init];
    MSUOrderController *video = [[MSUOrderController alloc] init];
    MSUShopCarController *shop = [[MSUShopCarController alloc] init];
    MSUPersonCenterController *center = [[MSUPersonCenterController alloc] init];
    
    // 图片数组
    NSArray *imageArr = @[@"home",@"market",@"video",@"myself"];
    NSArray *selectImaArr = @[@"homechoose",@"marketchoose",@"videochoose",@"myselfchoose"];
    
    //数组设置
    self.viewControllers = [NSArray arrayWithObjects:
                            [self createNavWithViewController:home WithTitle:@"首页" image:[UIImage imageNamed:imageArr[0]] selectedImage:[UIImage imageNamed:selectImaArr[0]] badgeValue:nil],
                            [self createNavWithViewController:video WithTitle:@"订单" image:[UIImage imageNamed:imageArr[1]] selectedImage:[UIImage imageNamed:selectImaArr[1]] badgeValue:nil],
                            [self createNavWithViewController:shop WithTitle:@"购物车" image:[UIImage imageNamed:imageArr[2]] selectedImage:[UIImage imageNamed:selectImaArr[2]] badgeValue:nil],
                           [self createNavWithViewController:center WithTitle:@"我的" image:[UIImage imageNamed:imageArr[3]] selectedImage:[UIImage imageNamed:selectImaArr[3]] badgeValue:nil],
                            nil];
    
}



@end
