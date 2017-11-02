//
//  MSUShopDetailController.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/2.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUShopDetailController.h"

#import "MSUHomeNavView.h"
#import "MSUPrefixHeader.pch"

#import "MSUDetailTopView.h"
#import "MSUSeleTableView.h"
#import "MSUDetailBottomView.h"

@interface MSUShopDetailController ()

@property (nonatomic , strong) MSUHomeNavView *navView;

@property (nonatomic , strong) MSUDetailTopView *topView;

@property (nonatomic , strong) MSUSeleTableView *orderView;

@property (nonatomic , strong) MSUDetailBottomView *bottomView;

@property (nonatomic , strong) UIView *lineView;

@property (nonatomic , strong) NSMutableArray *btnArr;

@end

@implementation MSUShopDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = REDCOLOR;
    
    self.navView  = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:4];
    [self.view addSubview:self.navView];
    _navView.backgroundColor = [UIColor clearColor];
    [_navView.backArrowBtn addTarget:self action:@selector(backArrowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.topView = [[MSUDetailTopView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, WIDTH*9/21)];
    _topView.backgroundColor = REDCOLOR;
    [self.view addSubview:_topView];
    
    [self createTableView];
    
    self.orderView.hidden = NO;
    
    self.bottomView = [[MSUDetailBottomView alloc] initWithFrame:CGRectMake(0, HEIGHT-49, WIDTH, 49)];
    _bottomView.backgroundColor = HEXCOLOR(0xffffff);
    [self.view addSubview:_bottomView];
    
    UIButton *btn = self.btnArr[0];
    btn.selected = YES;
}

- (void)createTableView{
    NSArray *arr = @[@"点菜",@"评价",@"商家"];
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.backgroundColor = HEXCOLOR(0xffffff);
        [menuBtn setTitle:arr[i] forState:UIControlStateNormal];
        [menuBtn setTitleColor:HEXCOLOR(0xb7b7b7) forState:UIControlStateNormal];
        [menuBtn setTitleColor:HEXCOLOR(0xff2d4b) forState:UIControlStateSelected];
        menuBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        menuBtn.tag = 1739+i;
        [self.view addSubview:menuBtn];
        [menuBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.top).offset(WIDTH*9/21+64);
            make.left.equalTo(self.view.left).offset(WIDTH/3*i);
            make.width.equalTo(WIDTH/3);
            make.height.equalTo(39);
        }];
        [self.btnArr addObject:menuBtn];
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, WIDTH*9/21+64+39, WIDTH, 1);
    lineView.backgroundColor = HEXCOLOR(0xfafafa);
    [self.view addSubview:lineView];
    
    self.lineView = [[UIView alloc] init];
    _lineView.frame = CGRectMake(WIDTH/3*0.5-15, WIDTH*9/21+64+37, 30, 3);
    _lineView.backgroundColor = HEXCOLOR(0xff2d4b);
    [self.view addSubview:_lineView];
}

#pragma mark - 初始化
- (MSUSeleTableView *)orderView{
    if (!_orderView) {
        self.orderView = [[MSUSeleTableView alloc] initWithFrame:CGRectMake(0, 64+WIDTH*9/21+40, WIDTH, HEIGHT-64-WIDTH*9/21-40-49)];
        _orderView.backgroundColor = HEXCOLOR(0xffffff);
        [self.view addSubview:_orderView];
    }
    return _orderView;
}

- (NSMutableArray *)btnArr{
    if (!_btnArr) {
        self.btnArr = [NSMutableArray array];
    }
    return _btnArr;
}

#pragma mark - 点击
- (void)backArrowBtnClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)menuBtnClick:(UIButton *)sender{
    [UIView animateWithDuration:0.25 animations:^{
        _lineView.frame = CGRectMake(WIDTH/3*0.5-15 +WIDTH/3*(sender.tag-1739), WIDTH*9/21+64+37, 30, 3);
    }];
    for (UIButton *btn in self.btnArr) {
        btn.selected = NO;
    }
    sender.selected = YES;
    
    if (sender == _btnArr[0]) {
        self.orderView.hidden = NO;

    } else if (sender == _btnArr[1]){
    
    } else {
    
    }
}




@end
