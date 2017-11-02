//
//  MSUDetailBottomView.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/2.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#import "MSUPathTools.h"

#import "MSUDetailBottomView.h"

@implementation MSUDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor clearColor];
    bgView.clipsToBounds = YES;
    bgView.layer.cornerRadius = 59*0.5;
    bgView.layer.shouldRasterize = YES;
    bgView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [self addSubview:bgView];
    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(-5);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(59);
        make.height.equalTo(59);
    }];
    
    self.carBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _carBtn.layer.cornerRadius = 59*0.5;
    _carBtn.clipsToBounds = YES;
    _carBtn.layer.shouldRasterize = YES;
    _carBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [_carBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"tabbar_icon_shop_selected"] forState:UIControlStateNormal];
    [bgView addSubview:_carBtn];
    [_carBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.top).offset(0);
        make.left.equalTo(bgView.left).offset(0);
        make.width.equalTo(59);
        make.height.equalTo(59);
    }];
//    [_carBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.showLab = [[UILabel alloc] init];
    _showLab.text = @"未选购商品";
    _showLab.font = [UIFont systemFontOfSize:14];
    _showLab.textColor = HEXCOLOR(0xb7b7b7);
    [self addSubview:_showLab];
    [_showLab makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(0);
        make.left.equalTo(bgView.right).offset(8);
        make.width.equalTo(SelfWidth-59-14-110-14);
        make.height.equalTo(49);
    }];
    
    self.priceLab = [[UILabel alloc] init];
    _priceLab.text = [NSString stringWithFormat:@"¥%@",@"45"];
    _priceLab.font = [UIFont systemFontOfSize:16];
    _priceLab.textColor = HEXCOLOR(0xff2d4b);
    [self addSubview:_priceLab];
    [_priceLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10.5);
        make.left.equalTo(bgView.right).offset(8);
        make.width.equalTo(SelfWidth-59-14-110-14);
        make.height.equalTo(16);
    }];
    self.priceLab.hidden = YES;
    
    self.yunFLab = [[UILabel alloc] init];
    _yunFLab.text = [NSString stringWithFormat:@"配送费%@元",@"45"];
    _yunFLab.font = [UIFont systemFontOfSize:12];
    _yunFLab.textColor = HEXCOLOR(0x272727);
    [self addSubview:_yunFLab];
    [_yunFLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLab.bottom).offset(0);
        make.left.equalTo(bgView.right).offset(8);
        make.width.equalTo(SelfWidth-59-14-110-14);
        make.height.equalTo(12);
    }];
    self.yunFLab.hidden = YES;
    
    self.buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _buyBtn.backgroundColor = HEXCOLOR(0xff2d4b);
    [_buyBtn setTitle:@"立即下单" forState:UIControlStateNormal];
      [_buyBtn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
    _buyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_buyBtn];
    [_buyBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.right.equalTo(self.right).offset(0);
        make.width.equalTo(110);
        make.height.equalTo(49);
    }];
    _buyBtn.enabled = NO;
//    [_buyBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}


@end
