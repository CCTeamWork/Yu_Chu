//
//  MSUPaySuccessView.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/6.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfContentWidth self.contentView.frame.size.width
#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "MSUPaySuccessView.h"

#import "MSUPathTools.h"

@implementation MSUPaySuccessView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    UIImageView *imaView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 6, SelfWidth-12, 33)];
    imaView.image = [MSUPathTools showImageWithContentOfFileByName:@"img_tick"];
    [self addSubview:imaView];
    [imaView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(30);
        make.left.equalTo(self.left).offset(37);
        make.width.equalTo(55);
        make.height.equalTo(55);
    }];
    
    UILabel *sucLab = [[UILabel alloc] init];
    sucLab.text = @"支付成功";
    sucLab.font = [UIFont systemFontOfSize:17];
    sucLab.textColor = HEXCOLOR(0x272727);
    [self addSubview:sucLab];
    [sucLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imaView.top).offset(6);
        make.left.equalTo(imaView.right).offset(15);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(17);
    }];
    
    UILabel *detailLab = [[UILabel alloc] init];
    detailLab.text = @"24.00元";
    detailLab.font = [UIFont systemFontOfSize:20];
    detailLab.textColor = HEXCOLOR(0xff2d4b);
    [self addSubview:detailLab];
    [detailLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sucLab.bottom).offset(15);
        make.left.equalTo(imaView.right).offset(15);
        make.width.equalTo(SelfWidth-37-55-15-14);
        make.height.equalTo(20);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = HEXCOLOR(0xf2f2f2);
    [self addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imaView.bottom).offset(28);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(6);
    }];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = HEXCOLOR(0xffffff);
    [self addSubview:bgView];
    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(90);
    }];
    
    UILabel *payLab = [[UILabel alloc] init];
    payLab.text = @"付款信息";
    payLab.font = [UIFont systemFontOfSize:14];
    payLab.textColor = HEXCOLOR(0x272727);
    [self addSubview:payLab];
    [payLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sucLab.bottom).offset(15.5);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(60);
        make.height.equalTo(14);
    }];
    
    self.infoLab = [[UILabel alloc] init];
    _infoLab.text = @"建设银行..(66666)";
    _infoLab.font = [UIFont systemFontOfSize:14];
    _infoLab.textColor = HEXCOLOR(0x272727);
    [self addSubview:_infoLab];
    [_infoLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(payLab.centerY).offset(0);
        make.left.equalTo(payLab.right).offset(36);
        make.width.equalTo(SelfWidth-14-60-36-14);
        make.height.equalTo(14);
    }];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = HEXCOLOR(0xf2f2f2);
    [bgView addSubview:lineView1];
    [lineView1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payLab.bottom).offset(14.5);
        make.left.equalTo(self.left).offset(1);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(1);
    }];
    
    UILabel *boLab = [[UILabel alloc] init];
    boLab.text = @"积分奖励";
    boLab.font = [UIFont systemFontOfSize:14];
    boLab.textColor = HEXCOLOR(0x272727);
    [self addSubview:boLab];
    [boLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView1.bottom).offset(15.5);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(60);
        make.height.equalTo(14);
    }];
    
    self.fenLab = [[UILabel alloc] init];
    _fenLab.text = @"获得10积分，现有5159积分";
    _fenLab.font = [UIFont systemFontOfSize:14];
    _fenLab.textColor = HEXCOLOR(0x272727);
    [self addSubview:_fenLab];
    [_fenLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(boLab.centerY).offset(0);
        make.left.equalTo(boLab.right).offset(36);
        make.width.equalTo(SelfWidth-14-60-36-14);
        make.height.equalTo(14);
    }];
}

@end
