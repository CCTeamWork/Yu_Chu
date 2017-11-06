//
//  MSUPaySuccessController.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/6.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUPaySuccessController.h"

#import "MSUPrefixHeader.pch"
#import "MSUHomeNavView.h"

#import "MSUPaySuccessView.h"

@interface MSUPaySuccessController ()

@end

@implementation MSUPaySuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = REDCOLOR;
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:9];
    [self.view addSubview:nav];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 64, WIDTH, HEIGHT-64);
    bgView.backgroundColor = HEXCOLOR(0xf2f2f2);
    [self.view addSubview:bgView];

    MSUPaySuccessView *pay = [[MSUPaySuccessView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 205)];
    [self.view addSubview:pay];
    pay.backgroundColor = HEXCOLOR(0xffffff);
}



@end
