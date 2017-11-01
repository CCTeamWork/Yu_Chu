//
//  MSUOrderController.m
//  Yu
//
//  Created by 何龙飞 on 2017/10/31.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUOrderController.h"

#import "MSUPrefixHeader.pch"
#import "MSUHomeNavView.h"

@interface MSUOrderController ()<UIScrollViewDelegate>

@property (nonatomic , strong) UIScrollView *scrollView;

@property (nonatomic , strong) UIView *lineView ;

@end

@implementation MSUOrderController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0 green:0 blue:55/255.0 alpha:1];
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:2];
    [self.view addSubview:nav];
    
    
    [self createTopView];
}


- (void)createTopView{
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 60, WIDTH, HEIGHT-60);
    bgView.backgroundColor = HEXCOLOR(0xffffff);
    [self.view addSubview:bgView];
    
    NSArray *titArr  = @[@"全部订单",@"待评价"];
    for (NSInteger i = 0; i < 2; i++) {
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.frame = CGRectMake(WIDTH*0.25-30+WIDTH*0.5*i, 13, 60, 14);
        [menuBtn setTitle:titArr[i] forState:UIControlStateNormal];
        [menuBtn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
        [menuBtn setTitleColor:REDCOLOR forState:UIControlStateSelected];
        menuBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        menuBtn.tag = 1542 + i;
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:menuBtn];
    }
    
    self.lineView = [[UIView alloc] init];
    _lineView.frame = CGRectMake(WIDTH*0.25-30, 37, 60, 3);
    _lineView.backgroundColor = REDCOLOR;
    [bgView addSubview:_lineView];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT)];
    _scrollView.backgroundColor  = HEXCOLOR(0xf2f2f2);
    _scrollView.scrollEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [bgView addSubview:_scrollView];
    
}

#pragma mark - 点击事件
- (void)menuBtnClick:(UIButton *)sender{
    
    [UIView animateWithDuration:0.25 animations:^{
        NSInteger a = sender.tag - 1542;
        _lineView.frame = CGRectMake(WIDTH*0.25-30 + a*WIDTH*0.5, 37, 60, 3);
    }];
    
    if (sender.tag == 1542) {
        
    } else{
    
    }
}


@end
