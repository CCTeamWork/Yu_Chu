//
//  MSUHomePageController.m
//  Yu
//
//  Created by 何龙飞 on 2017/10/31.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUHomePageController.h"
#import "MSUSeleAddressController.h"


#import "MSUPrefixHeader.pch"
#import "MSUHomeNavView.h"

@interface MSUHomePageController ()

@end

@implementation MSUHomePageController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /// 状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = HEXCOLOR(0xffffff);
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:0];
    [self.view addSubview:nav];
    [nav.LocationBtn addTarget:self action:@selector(locationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)locationBtnClick:(UIButton *)sender{
    self.hidesBottomBarWhenPushed = YES;
    MSUSeleAddressController *sele = [[MSUSeleAddressController alloc] init];
    [self.navigationController pushViewController:sele animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


@end
