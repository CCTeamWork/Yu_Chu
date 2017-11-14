//
//  MSUThankCommentController.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/6.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUThankCommentController.h"

#import "MSUHomeNavView.h"
#import "MSUPrefixHeader.pch"

#import "MSUThankComView.h"

@interface MSUThankCommentController ()

@end

@implementation MSUThankCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = REDCOLOR;
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:7];
    [self.view addSubview:nav];
    [nav.backArrowBtn addTarget:self action:@selector(backArrowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 64, WIDTH, HEIGHT-64);
    bgView.backgroundColor = HEXCOLOR(0xf2f2f2);
    [self.view addSubview:bgView];
    
    MSUThankComView *thank = [[MSUThankComView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 168+119+40)];
    [self.view addSubview:thank];
    thank.backgroundColor = HEXCOLOR(0xffffff);
    thank.detailLab.text = self.str;
    
}


#pragma  - 点击
- (void)backArrowBtnClick:(UIButton *)sender{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
