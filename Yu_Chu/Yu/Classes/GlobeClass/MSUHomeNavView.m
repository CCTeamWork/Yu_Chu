//
//  MSUHomeNavView.m
//  Yu
//
//  Created by 何龙飞 on 2017/10/31.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUHomeNavView.h"
#import "MSUPrefixHeader.pch"
#import "MSUPathTools.h"

@implementation MSUHomeNavView

- (instancetype)initWithFrame:(CGRect)frame showNavWithNumber:(NSInteger)number
{
    if (self = [super initWithFrame:frame]) {
        
        switch (number) {
            case 0:
            {
                /// 首页导航栏
                [self createHomePageNavView];
            }
                break;
            case 1:
            {
                /// 首页导航栏
                [self createNearbyWithTittle:@"选择收货地址" imageName:@"back" title:nil];
            }
                break;
            case 2:
            {
                /// 首页导航栏
                [self createDanamicWithTittle:@"动态" imaName:nil];
            }
                break;
            case 3:
            {
                /// 首页导航栏
                [self createDanamicWithTittle:@"购物车" imaName:nil];
            }
                break;
            case 4:
            {
                /// 首页导航栏
                [self createNearbyWithTittle:nil imageName:@"back" title:nil];
            }
                break;
            case 5:
            {
                /// 首页导航栏
                [self createNearbyWithTittle:nil imageName:@"nav_icon_back" title:nil];
            }
                break;
            case 6:
            {
                /// 首页导航栏
                [self createNearbyWithTittle:@"评价" imageName:@"back" title:nil];
            }
                break;
            case 7:
            {
                /// 首页导航栏
                [self createNearbyWithTittle:@"感谢评价" imageName:@"back" title:nil];
            }
                break;
                
            case 8:
            {
                /// 首页导航栏
                [self createNearbyWithTittle:@"下单成功" imageName:@"nav_close" title:nil];
            }
                break;
            case 9:
            {
                /// 首页导航栏
                [self createDanamicWithTittle:@"支付成功" imaName:@"完成"];
            }
                break;
            case 10:
            {
                /// 首页导航栏
                [self createNearbyWithTittle:@"确认订单" imageName:@"back" title:nil];
            }
                break;
            case 11:
            {
                /// 首页导航栏
                [self createNearbyWithTittle:@"订单取消" imageName:@"nav_close" title:nil];
            }
                break;
            case 12:
            {
                /// 首页导航栏
                [self createaaaWithTittle:@"nav_close" imaName:@"nav_phone"];
            }
                break;
            default:
                break;
                
        }
    }
    return self;
}


- (void)createHomePageNavView{
    NSString *city;
    //取出存值，判断是否第一次进入 如果第一次进入 city默认为上海 ；如果不是第一次进入 city为上次定位位置
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"city"]) {
        city = [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
    }else{
        city = @"上海";
    }
    self.LocationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _LocationBtn.backgroundColor = [UIColor redColor];
    [_LocationBtn setTitle:city forState:UIControlStateNormal];
    _LocationBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    _LocationBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_LocationBtn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
    [_LocationBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"state-location"] forState:UIControlStateNormal];
    _LocationBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [self addSubview:_LocationBtn];
//    [_LocationBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_LocationBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(15);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(80);
        make.height.equalTo(20);
    }];
    
    UILabel *attentionLab = [[UILabel alloc] init];
    attentionLab.text = @"两岸御厨";
    attentionLab.font = [UIFont systemFontOfSize:16];
    attentionLab.textAlignment = NSTextAlignmentCenter;
    attentionLab.textColor = HEXCOLOR(0xffffff);
    [self addSubview:attentionLab];
    [attentionLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(15);
        make.left.equalTo(self.left).offset([UIScreen mainScreen].bounds.size.width * 0.5 - 100);
        make.width.equalTo(200);
        make.height.equalTo(20);
    }];
    
//    UIImageView *imaView = [[UIImageView alloc] init];
//    imaView.backgroundColor = [UIColor redColor];
//    imaView.image = [MSUPathTools showImageWithContentOfFileByName:@""];
//    [self addSubview:imaView];
//    [imaView makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.top).offset(5);
//        make.left.equalTo(self.left).offset(WIDTH *0.5 - 50);
//        make.width.equalTo(100);
//        make.height.equalTo(30);
//    }];
}

- (void)createNearbyWithTittle:(NSString *)tittle imageName:(NSString *)name title:(NSString *)rightTitle{
    // 左箭头
    self.backArrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _backArrowBtn.backgroundColor = [UIColor blueColor];
    [_backArrowBtn setImage:[MSUPathTools showImageWithContentOfFileByName:name] forState:UIControlStateNormal];
    [self addSubview:_backArrowBtn];
    [_backArrowBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(8);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(24);
        make.height.equalTo(24);
    }];
    
    // 附近动态
    self.titeleLab = [[UILabel alloc] init];
    _titeleLab.text = tittle;
    _titeleLab.textAlignment = NSTextAlignmentCenter;
    _titeleLab.font = [UIFont systemFontOfSize:18];
    [_titeleLab setTextColor:HEXCOLOR(0xffffff)];
    [self addSubview:_titeleLab];
    [_titeleLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(WIDTH * 0.5 - 75);
        make.width.equalTo(150);
        make.height.equalTo(40);
    }];
    
//    if (name) {
//        // 地图按钮
//        self.positionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_positionBtn setImage:[MSUPathTools showImageWithContentOfFileByName:name] forState:UIControlStateNormal];
//        [_positionBtn setTitle:rightTitle forState:UIControlStateNormal];
//        [_positionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _positionBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        [self addSubview:_positionBtn];
//        [_positionBtn makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.top).offset(9.5);
//            make.right.equalTo(self.right).offset(-19);
//            make.width.equalTo(30);
//            make.height.equalTo(21);
//        }];
//    }
}


- (void)createDanamicWithTittle:(NSString *)tittle imaName:(NSString *)imaName{
    UILabel *titeleLab = [[UILabel alloc] init];
    titeleLab.text = tittle;
    titeleLab.textAlignment = NSTextAlignmentCenter;
    titeleLab.font = [UIFont systemFontOfSize:18];
    [titeleLab setTextColor:HEXCOLOR(0xffffff)];
    [self addSubview:titeleLab];
    [titeleLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(WIDTH * 0.5 - 40);
        make.width.equalTo(80);
        make.height.equalTo(40);
    }];
    // 搜索按钮
    self.homeSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_homeSearchBtn setImage:[MSUPathTools showImageWithContentOfFileByName:imaName] forState:UIControlStateNormal];
    [_homeSearchBtn setTitle:imaName forState:UIControlStateNormal];
    [_homeSearchBtn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
    _homeSearchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_homeSearchBtn];
    [_homeSearchBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.right.equalTo(self.right).offset(-19);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
}

- (void)createaaaWithTittle:(NSString *)tittle imaName:(NSString *)imaName{
    // 左箭头
    self.backArrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _backArrowBtn.backgroundColor = [UIColor blueColor];
    [_backArrowBtn setImage:[MSUPathTools showImageWithContentOfFileByName:tittle] forState:UIControlStateNormal];
    [self addSubview:_backArrowBtn];
    [_backArrowBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(8);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(24);
        make.height.equalTo(24);
    }];
    // 搜索按钮
    self.homeSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_homeSearchBtn setImage:[MSUPathTools showImageWithContentOfFileByName:imaName] forState:UIControlStateNormal];
    [self addSubview:_homeSearchBtn];
    [_homeSearchBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.right.equalTo(self.right).offset(-19);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
}

@end
