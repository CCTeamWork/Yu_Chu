//
//  MSUOrderCancelController.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/6.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUOrderCancelController.h"

#import "MSUHomeNavView.h"
#import "MSUPrefixHeader.pch"

#import "MSUOrderCanelView.h"

@interface MSUOrderCancelController ()

@end

@implementation MSUOrderCancelController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = REDCOLOR;
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:11];
    [self.view addSubview:nav];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 64, WIDTH, HEIGHT-64);
    bgView.backgroundColor = HEXCOLOR(0xf2f2f2);
    [self.view addSubview:bgView];
    
    MSUOrderCanelView *cancelView = [[MSUOrderCanelView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 118)];
    [self.view addSubview:cancelView];
    [cancelView.backBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    
    
    
}

- (void)cancelBtnClick:(UIButton *)sender{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}


@end
