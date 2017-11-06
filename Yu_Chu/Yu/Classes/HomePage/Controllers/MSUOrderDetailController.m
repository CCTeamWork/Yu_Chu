//
//  MSUOrderDetailController.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/6.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUOrderDetailController.h"

#import "MSUPrefixHeader.pch"
#import "MSUHomeNavView.h"
#import "MSUStringTools.h"

#import "MSUOrderTopView.h"
#import "MSUOrderBottomView.h"
#import "MSUDetailBottomView.h"

@interface MSUOrderDetailController ()

@property (nonatomic , strong) MSUDetailBottomView *boDetailView;

@end

@implementation MSUOrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = HEXCOLOR(0xf2f2f2);
    
    MSUOrderTopView *topView = [[MSUOrderTopView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH*9/16+92)];
    topView.backgroundColor = WHITECOLOR;
    [self.view addSubview:topView];
    [topView.joinBtn addTarget:self action:@selector(joinBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:5];
    [self.view addSubview:nav];
    nav.backgroundColor = [UIColor clearColor];
    [nav.backArrowBtn addTarget:self action:@selector(backArrowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    MSUOrderBottomView *bottomView = [[MSUOrderBottomView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame)+10, WIDTH, HEIGHT-(WIDTH*9/16+92+49))];
    [self.view addSubview:bottomView];
    bottomView.backgroundColor = HEXCOLOR(0xffffff);
    
    bottomView.introLab.text = @"手枪鸡腿手枪鸡腿手枪鸡腿手枪鸡腿手枪鸡腿手枪鸡腿手枪鸡腿手枪鸡腿手枪鸡腿";
    CGRect rectA = [MSUStringTools danamicGetHeightFromText:bottomView.introLab.text WithWidth:WIDTH-28 font:14];
    bottomView.introLab.frame = CGRectMake(14, 43, WIDTH-28, rectA.size.height);
    
    bottomView.mainLab.text = [NSString stringWithFormat:@"主菜：%@,配菜：%@，主食：%@",@"手枪鸡腿",@"每天变化",@"米饭"];
    CGRect rectB = [MSUStringTools danamicGetHeightFromText:bottomView.introLab.text WithWidth:WIDTH-28 font:14];
    bottomView.mainLab.frame = CGRectMake(14, 43+rectA.size.height+43, WIDTH-28, rectB.size.height);
    
    self.boDetailView = [[MSUDetailBottomView alloc] initWithFrame:CGRectMake(0, HEIGHT-49, WIDTH, 49)];
    _boDetailView.backgroundColor = HEXCOLOR(0xffffff);
    [self.view addSubview:_boDetailView];
//    [_boDetailView.carBtn addTarget:self action:@selector(carBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backArrowBtnClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)joinBtnClick:(UIButton *)sender{
    _boDetailView.buyBtn.backgroundColor = HEXCOLOR(0xff2d4b);
    _boDetailView.buyBtn.enabled = YES;
    _boDetailView.carBtn.selected = YES;
    _boDetailView.carNumLab.hidden = NO;
}

@end
