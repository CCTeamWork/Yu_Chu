//
//  MSUShopDetailController.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/2.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUShopDetailController.h"
#import "MSUOrderDetailController.h"

#import "MSUHomeNavView.h"
#import "MSUPrefixHeader.pch"
#import "MSUShadowView.h"

#import "MSUDetailTopView.h"
#import "MSUSeleTableView.h"
#import "MSUDetailBottomView.h"
#import "MSUDetailCommentView.h"
#import "MSUSellerView.h"
#import "MSUShopCarView.h"

#import "MSUDetailModel.h"
#import "MSUStringTools.h"

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

@property (nonatomic , strong) NSMutableArray *modelArr;

@property (nonatomic , strong) NSMutableArray *idArr;
@property (nonatomic , strong) NSMutableArray *numArr;

@property (nonatomic , assign) NSInteger price;

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
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"dccLoginToken"];
    if (!token) {
        token = @"";
    }
    [self loadRequestWithToken:token];
    [self commentRequestWithToken:token];
    
    self.navView  = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:4];
    [self.view addSubview:self.navView];
    _navView.backgroundColor = [UIColor clearColor];
    [_navView.backArrowBtn addTarget:self action:@selector(backArrowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.topView = [[MSUDetailTopView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, WIDTH*9/21)];
    _topView.backgroundColor = REDCOLOR;
    [self.view addSubview:_topView];
    [_topView.iconBtn sd_setImageWithURL:[NSURL URLWithString:self.iconStr] forState:UIControlStateNormal];
    _topView.nameLab.text = self.shopName;
    _topView.priceLab.text = [NSString stringWithFormat:@"起送 ¥%@   配送费 ¥%@",self.sendMoney,self.payMon];;
    _topView.saleLab.text = self.intro;
//    CGRect recta = [MSUStringTools danamicGetHeightFromText:_topView.saleLab.text WithWidth:WIDTH-14-28-45-8 font:12];
//    _topView.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
    [self createTableView];
    
    self.orderView.hidden = NO;
    self.commentView.hidden = YES;
    self.sellerView.hidden = YES;

    
    UIButton *btn = self.btnArr[0];
    btn.selected = YES;
}

- (void)loadRequestWithToken:(NSString *)token
{

    
    NSDictionary *dic = @{@"token":token,@"shopId":self.shopID};
    NSLog(@"--- dic %@",dic);
    [[MSUAFNRequest sharedInstance] postRequestWithURL:@"http://192.168.10.21:8201/member/shop/getDishClass" parameters:dic withBlock:^(id obj, NSError *error) {
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingMutableLeaves error:nil];
        if (!error) {
            NSLog(@"访问成功%@",jsonDict);
            if([jsonDict[@"code"] isEqualToString:@"200"]){
                
                MSUDetailModel *detailModel = [MSUDetailModel mj_objectWithKeyValues:jsonDict];
                self.orderView.detailModel = detailModel;
                
            } else{
              
            }
            
        }else{
            NSLog(@"访问报错%@",error);
        }
    }];
    
}

- (void)commentRequestWithToken:(NSString *)token{
    NSDictionary *dic = @{@"token":token,@"shopId":self.shopID,@"tag":@"",@"pageSize":@"",@"pageIndex":@""};
    [[MSUAFNRequest sharedInstance] postRequestWithURL:@"http://192.168.10.21:8201/member/shop/getShopComment" parameters:dic withBlock:^(id obj, NSError *error) {
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingMutableLeaves error:nil];
        if (!error) {
            NSLog(@"访问成功%@",jsonDict);
            if([jsonDict[@"code"] isEqualToString:@"200"]){
                
                MSUCommentModel *detailModel = [MSUCommentModel mj_objectWithKeyValues:jsonDict];
                self.commentView.commentModel = detailModel.data;
                
            } else{
                
            }
            
        }else{
            NSLog(@"访问报错%@",error);
        }
    }];

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

- (NSMutableArray *)modelArr{
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}

- (NSMutableArray *)idArr{
    if (!_idArr) {
        _idArr = [NSMutableArray array];
    }
    return _idArr;
}

- (NSMutableArray *)numArr{
    if (!_numArr) {
        _numArr = [NSMutableArray array];
    }
    return _numArr;
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
- (void)seleDelegateToCaculateWithGoodsID:(NSString *)goodId goodsNum:(NSString *)num model:(MSUMenuModel *)model isAdd:(NSInteger)signNum{

    if (signNum == 1) {
        if (self.idArr.count > 0) {
            for (NSString *idStr in self.idArr) {
                if ([idStr isEqualToString:goodId]) {
                    NSInteger index = [self.idArr indexOfObject:idStr];
                    [self.numArr replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%ld",[self.numArr[index] integerValue]+1]];
                } else{
                    [self.idArr addObject:goodId];
                    [self.numArr addObject:num];
                    [self.modelArr addObject:model];
                }
            }
        } else{
            [self.idArr addObject:goodId];
            [self.numArr addObject:num];
            [self.modelArr addObject:model];
        }
    } else{
        for (NSString *idStr in self.idArr) {
            if ([goodId isEqualToString:idStr]) {
                NSInteger index = [self.idArr indexOfObject:idStr];
                [self.numArr replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%ld",[self.numArr[index] integerValue]-1]];
                if ([self.numArr[index] isEqualToString:@"0"]) {
                    [self.idArr removeObjectAtIndex:index];
                    [self.numArr removeObjectAtIndex:index];
                    [self.modelArr removeObjectAtIndex:index];
                }

            }
            
        }
    }
    
    if (self.idArr.count > 0) {
        _bottomView.buyBtn.backgroundColor = HEXCOLOR(0xff2d4b);
        _bottomView.buyBtn.enabled = YES;
        _bottomView.carBtn.selected = YES;
        _bottomView.carNumLab.hidden = NO;
        _bottomView.showLab.hidden = YES;
        _bottomView.priceLab.hidden = NO;
        _bottomView.yunFLab.hidden = NO;
        _bottomView.yunFLab.text = [NSString stringWithFormat:@"配送费%@元",self.payMon];
    } else{
        _bottomView.buyBtn.backgroundColor = HEXCOLOR(0xcccccc);

        _bottomView.buyBtn.enabled = NO;
        _bottomView.carBtn.selected = NO;
        _bottomView.carNumLab.hidden = YES;
        _bottomView.showLab.hidden = NO;
        _bottomView.priceLab.hidden = YES;
        _bottomView.yunFLab.hidden = YES;
    }
    
    
    
    _bottomView.carNumLab.text = [NSString stringWithFormat:@"%ld",self.idArr.count];
    for (NSInteger i =0 ;i < self.idArr.count; i++) {
        NSInteger num = [self.numArr[i] integerValue];
        MSUMenuModel *model = self.modelArr[i];
        NSString *price = model.dishPrice;
        
        NSInteger totalPrice = num * [price integerValue];
        self.price = totalPrice + self.price;
    }
    
    _bottomView.priceLab.text = [NSString stringWithFormat:@"%ld",self.price];

}

- (void)seleRightDelegateToPush{
    self.hidesBottomBarWhenPushed = YES;
    MSUOrderDetailController *order = [[MSUOrderDetailController alloc] init];
    [self.navigationController pushViewController:order animated:YES];
}


@end
