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
#import "MSUShadowView.h"

#import "MSUDetailTopView.h"
#import "MSUSeleTableView.h"
#import "MSUDetailBottomView.h"
#import "MSUDetailCommentView.h"
#import "MSUSellerView.h"
#import "MSUShopCarView.h"

@interface MSUShopDetailController ()<MSUSeleTableViewDelegate>

@property (nonatomic , strong) MSUHomeNavView *navView;

@property (nonatomic , strong) MSUDetailTopView *topView;

@property (nonatomic , strong) MSUSeleTableView *orderView;

@property (nonatomic , strong) MSUDetailBottomView *bottomView;

@property (nonatomic , strong) MSUDetailCommentView *commentView;

@property (nonatomic , strong) MSUSellerView *sellerView;

@property (nonatomic , strong) MSUShadowView *shadowView;
@property (nonatomic , strong) MSUShopCarView *carView;

@property (nonatomic , strong) UIView *lineView;

@property (nonatomic , strong) NSMutableArray *btnArr;

@end

@implementation MSUShopDetailController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /// 状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


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
        _orderView.delegate = self;
        
        self.bottomView = [[MSUDetailBottomView alloc] initWithFrame:CGRectMake(0, HEIGHT-49, WIDTH, 49)];
        _bottomView.backgroundColor = HEXCOLOR(0xffffff);
        [self.view addSubview:_bottomView];
        [_bottomView.carBtn addTarget:self action:@selector(carBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderView;
}

- (MSUDetailCommentView *)commentView{
    if (!_commentView) {
        self.commentView = [[MSUDetailCommentView alloc] initWithFrame:CGRectMake(0, 64+WIDTH*9/21+40, WIDTH, HEIGHT-64-WIDTH*9/21-40)];
        [self.view addSubview:_commentView];
        _commentView.backgroundColor = HEXCOLOR(0xffffff);
    }
    return _commentView;
}

- (MSUSellerView *)sellerView{
    if (!_sellerView) {
        self.sellerView = [[MSUSellerView alloc] initWithFrame:CGRectMake(0, 64+WIDTH*9/21+40, WIDTH, HEIGHT-64-WIDTH*9/21-40)];
        [self.view addSubview:_sellerView];
        _sellerView.backgroundColor = HEXCOLOR(0xf4f4f4);
    }
    return _sellerView;
}

- (MSUShadowView *)shadowView{
    if (!_shadowView) {
        self.shadowView = [[MSUShadowView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.44];
        [self.view addSubview:_shadowView];
        _shadowView.hidden = YES;
    }
    return _shadowView;
}

- (MSUShopCarView *)carView{
    if (!_carView) {
        self.carView = [[MSUShopCarView alloc] init];
        _carView.frame = CGRectMake(0, HEIGHT-50-35, WIDTH, 50);
        [self.shadowView addSubview:_carView];
    }
    return _carView;
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
        self.commentView.hidden = YES;
        self.sellerView.hidden = YES;

    } else if (sender == _btnArr[1]){
        self.commentView.hidden = NO;
        self.orderView.hidden = YES;
        self.sellerView.hidden = YES;

    } else {
        self.sellerView.hidden = NO;
        self.orderView.hidden = YES;
        self.commentView.hidden = YES;
    }
}


- (void)carBtnClick:(UIButton *)sender{
    
}


#pragma mark - 代理
- (void)seleDelegateToCaculateWithGoodsPrice:(NSString *)price goodsNum:(NSInteger)num{
    _bottomView.buyBtn.backgroundColor = HEXCOLOR(0xff2d4b);
    _bottomView.buyBtn.enabled = YES;
    _bottomView.carBtn.selected = YES;
    _bottomView.carNumLab.hidden = NO;

}


@end
