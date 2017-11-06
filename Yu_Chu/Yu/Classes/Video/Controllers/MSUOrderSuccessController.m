//
//  MSUOrderSuccessController.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/6.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUOrderSuccessController.h"

#import "MSUHomeNavView.h"
#import "MSUPrefixHeader.pch"

#import "MSUSuccessView.h"

@interface MSUOrderSuccessController ()

@end

@implementation MSUOrderSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = REDCOLOR;
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:8];
    [self.view addSubview:nav];
    [nav.backArrowBtn addTarget:self action:@selector(backArrowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 64, WIDTH, HEIGHT-64);
    bgView.backgroundColor = HEXCOLOR(0xf2f2f2);
    [self.view addSubview:bgView];
    
    MSUSuccessView *suuView = [[MSUSuccessView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 170)];
    suuView.backgroundColor = HEXCOLOR(0xffffff);
    [self.view addSubview:suuView];
    
}

#pragma - 点击事件
- (void)backArrowBtnClick:(UIButton *)sender{
    
}

@end
