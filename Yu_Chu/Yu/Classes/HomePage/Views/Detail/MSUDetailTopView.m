//
//  MSUDetailTopView.m
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

#import "MSUStringTools.h"

#import "MSUDetailTopView.h"

@implementation MSUDetailTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}



- (void)createView{
    self.iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _iconBtn.layer.cornerRadius = 45*0.5;
    _iconBtn.clipsToBounds = YES;
    _iconBtn.layer.shouldRasterize = YES;
    _iconBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _iconBtn.backgroundColor = [UIColor brownColor];
    [self addSubview:_iconBtn];
    [_iconBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(34+15);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(45);
        make.height.equalTo(45);
    }];
//    [_iconBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.nameLab = [[UILabel alloc] init];
    _nameLab.text = @"两岸御厨(文辉大桥店)";
    _nameLab.font = [UIFont systemFontOfSize:15];
    _nameLab.textColor = HEXCOLOR(0xffffff);
    [self addSubview:_nameLab];
    [_nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(34);
        make.left.equalTo(_iconBtn.right).offset(8);
        make.width.equalTo(SelfWidth-28-45-8);
        make.height.equalTo(15);
    }];
    
    self.priceLab = [[UILabel alloc] init];
    _priceLab.text = [NSString stringWithFormat:@"起送 ¥%@   配送费 ¥%@",@"0.01",@"0"];
    _priceLab.font = [UIFont systemFontOfSize:12];
    _priceLab.textColor = HEXCOLOR(0xffffff);
    [self addSubview:_priceLab];
    [_priceLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLab.bottom).offset(14);
        make.left.equalTo(_nameLab.left).offset(0);
        make.width.equalTo(SelfWidth-28-45-8);
        make.height.equalTo(12);
    }];
    
    self.saleLab = [[UILabel alloc] init];
    _saleLab.text = [NSString stringWithFormat:@"在线支付满%@减%@ 满%@减%@元 满%@减%@元 满%@元减%@元",@"26",@"8",@"52",@"18",@"78",@"24",@"104",@"32"];
    _saleLab.font = [UIFont systemFontOfSize:12];
    _saleLab.textColor = HEXCOLOR(0xffffff);
    _saleLab.numberOfLines = 0;
    CGRect recta = [MSUStringTools danamicGetHeightFromText:_saleLab.text WithWidth:SelfWidth-14-28-45-8 font:12];
    [self addSubview:_saleLab];
    [_saleLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLab.bottom).offset(0);
        make.left.equalTo(_nameLab.left).offset(0);
        make.width.equalTo(SelfWidth-14-28-45-8);
        make.height.equalTo(recta.size.height);
    }];
    
}

@end
