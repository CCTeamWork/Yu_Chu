//
//  MSUShopCarController.m
//  Yu
//
//  Created by 何龙飞 on 2017/10/31.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUShopCarController.h"

#import "MSUPrefixHeader.pch"
#import "MSUHomeNavView.h"

@interface MSUShopCarController ()

@end

@implementation MSUShopCarController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0 green:0 blue:55/255.0 alpha:1];
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:3];
    [self.view addSubview:nav];
    
    [self createTopView];

    
}


- (void)createTopView{
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 60, WIDTH, HEIGHT-60);
    bgView.backgroundColor = HEXCOLOR(0xffffff);
    [self.view addSubview:bgView];
    
}


@end
