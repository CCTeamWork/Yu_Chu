//
//  MSUOrderDetailController.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/6.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUOrderDetailController.h"
#import "DCCConfirmOrderViewController.h"

#import "MSUPrefixHeader.pch"
#import "MSUHomeNavView.h"
#import "MSUStringTools.h"

#import "MSUOrderTopView.h"
#import "MSUOrderBottomView.h"
#import "MSUDetailBottomView.h"

#import "MSUShopCarView.h"
#import "MSUShadowView.h"


@interface MSUOrderDetailController ()

@property (nonatomic , strong) MSUDetailBottomView *boDetailView;
@property (nonatomic , strong) MSUOrderTopView *topView;

@property (nonatomic , strong) NSMutableArray *modelArr;
@property (nonatomic , strong) MSUShadowView *shadowView;
@property (nonatomic , strong) MSUShopCarView *carView;

@property (nonatomic , assign) NSInteger price;

@end

@implementation MSUOrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = HEXCOLOR(0xf2f2f2);
    
    self.topView = [[MSUOrderTopView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH*9/16+92)];
    _topView.backgroundColor = WHITECOLOR;
    [self.view addSubview:_topView];
    [_topView.joinBtn addTarget:self action:@selector(joinBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_topView.goodPic sd_setImageWithURL:[NSURL URLWithString:self.menuModel.coverImage]];
    _topView.nameLab.text = self.menuModel.dishName;
    _topView.priceLab.text = self.menuModel.dishPrice;
    [_topView.deleBtn addTarget:self action:@selector(deleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_topView.addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:5];
    [self.view addSubview:nav];
    nav.backgroundColor = [UIColor clearColor];
    [nav.backArrowBtn addTarget:self action:@selector(backArrowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    MSUOrderBottomView *bottomView = [[MSUOrderBottomView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame)+10, WIDTH, HEIGHT-(WIDTH*9/16+92+49))];
    [self.view addSubview:bottomView];
    bottomView.backgroundColor = HEXCOLOR(0xffffff);
    
    bottomView.introLab.text = self.menuModel.dishDisc;
    CGRect rectA = [MSUStringTools danamicGetHeightFromText:bottomView.introLab.text WithWidth:WIDTH-28 font:14];
    bottomView.introLab.frame = CGRectMake(14, 43, WIDTH-28, rectA.size.height);
    
    bottomView.mainLab.text = [NSString stringWithFormat:@"主菜：%@,配菜：%@，主食：%@",self.menuModel.mainDishName,self.menuModel.sideDishName,self.menuModel.stapleFood];
    CGRect rectB = [MSUStringTools danamicGetHeightFromText:bottomView.introLab.text WithWidth:WIDTH-28 font:14];
    bottomView.mainLab.frame = CGRectMake(14, 43+rectA.size.height+43, WIDTH-28, rectB.size.height);
    
    self.boDetailView = [[MSUDetailBottomView alloc] initWithFrame:CGRectMake(0, HEIGHT-49, WIDTH, 49)];
    _boDetailView.backgroundColor = HEXCOLOR(0xffffff);
    [self.view addSubview:_boDetailView];
//    [_boDetailView.carBtn addTarget:self action:@selector(carBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_boDetailView.carBtn addTarget:self action:@selector(carBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_boDetailView.buyBtn addTarget:self action:@selector(buyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}



- (void)loadRequest
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"dccLoginToken"];
    if (!token) {
        token = @"";
    }
    
    NSDictionary *dic = @{@"token":token,@"shopId":self.menuModel.shopId,@"dishId":self.menuModel.seller_id,@"count":@"1"};
    NSLog(@"--- dic %@",dic);
    [[MSUAFNRequest sharedInstance] postRequestWithURL:@"http://192.168.10.21:8202/member/shop/getShopCar" parameters:dic withBlock:^(id obj, NSError *error) {
        if (obj) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingMutableLeaves error:nil];
            if (!error) {
                NSLog(@"访问成功%@",jsonDict);
                if([jsonDict[@"code"] isEqualToString:@"200"]){
                    
                } else{
           
                }
                
            }else{
                NSLog(@"访问报错%@",error);
            }
            
        } else{
            [MSUHUD showFileWithString:@"服务器请求为空"];
        }
        
    }];
}

#pragma mark - 点击事件
- (void)backArrowBtnClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)joinBtnClick:(UIButton *)sender{
    _boDetailView.buyBtn.backgroundColor = HEXCOLOR(0xff2d4b);
    _boDetailView.buyBtn.enabled = YES;
    _boDetailView.carBtn.selected = YES;
    _boDetailView.carNumLab.hidden = NO;
    _boDetailView.showLab.hidden = YES;
    _boDetailView.priceLab.hidden = NO;
    _boDetailView.yunFLab.hidden = NO;
    _boDetailView.yunFLab.text = [NSString stringWithFormat:@"配送费%@元",self.payMon];
    [UIView animateWithDuration:0.25 animations:^{
        _topView.addBtn.hidden = NO;
        _topView.deleBtn.hidden = NO;
        _topView.numLab.hidden = NO;
        _topView.joinBtn.hidden = YES;
        _boDetailView.priceLab.text = [NSString stringWithFormat:@"¥%@",self.menuModel.dishPrice];

    }];
}

- (void)addBtnClick:(UIButton *)sender{
    _topView.numLab.text = [NSString stringWithFormat:@"%ld",[_topView.numLab.text integerValue]+1];

    self.price = [self.topView.numLab.text integerValue]*[self.menuModel.dishPrice integerValue];
    _boDetailView.priceLab.text = [NSString stringWithFormat:@"%ld",self.price];

}

- (void)deleBtnClick:(UIButton *)sender{
    _topView.numLab.text = [NSString stringWithFormat:@"%ld",[_topView.numLab.text integerValue]-1];
    if ([_topView.numLab.text isEqualToString:@"0"]) {
        [UIView animateWithDuration:0.25 animations:^{
            _topView.numLab.hidden = YES;
            _topView.deleBtn.hidden = YES;
            _topView.addBtn.hidden = YES;
            _topView.joinBtn.hidden = NO;
        }];
    }
    
    self.price = [self.topView.numLab.text integerValue]*[self.menuModel.dishPrice integerValue];
    _boDetailView.priceLab.text = [NSString stringWithFormat:@"%ld",self.price];

}

- (void)carBtnClick:(UIButton *)sender{
    self.shadowView.hidden = NO;
    self.carView.hidden = NO;
    [self.view bringSubviewToFront:self.boDetailView];
    _carView.backgroundColor = HEXCOLOR(0xffffff);

}

- (void)buyBtnClick:(UIButton *)sender{
    self.hidesBottomBarWhenPushed =YES;
    DCCConfirmOrderViewController *com = [[DCCConfirmOrderViewController alloc] init];
    com.shopId = self.menuModel.shopId;
    com.shopName = self.menuModel.dishName;
    [self.navigationController pushViewController:com animated:YES];
}


- (NSMutableArray *)modelArr{
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
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
        _carView.frame = CGRectMake(0,HEIGHT-(50+35+20), WIDTH, 50+35+20);
        //        _carView.frame = CGRectMake(0, HEIGHT-50*_modelArr.count-35-20, WIDTH, 50*_modelArr.count+20);
        [self.shadowView addSubview:_carView];
    }
    return _carView;
}

@end
