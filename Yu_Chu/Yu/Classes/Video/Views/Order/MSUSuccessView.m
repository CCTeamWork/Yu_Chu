//
//  MSUSuccessView.m
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

#import "MSUSuccessView.h"

#import "MSUPathTools.h"

@implementation MSUSuccessView

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
    sucLab.text = @"下单成功~";
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
    detailLab.text = @"你所购买的商品将在40分钟之内送达";
    detailLab.font = [UIFont systemFontOfSize:12];
    detailLab.textColor = HEXCOLOR(0xb7b7b7);
    [self addSubview:detailLab];
    [detailLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sucLab.bottom).offset(13);
        make.left.equalTo(imaView.right).offset(15);
        make.width.equalTo(SelfWidth-37-55-15-14);
        make.height.equalTo(12);
    }];

    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.backgroundColor = HEXCOLOR(0xff2d4b);
    _leftBtn.layer.cornerRadius = 2.5;
    _leftBtn.clipsToBounds = YES;
    _leftBtn.layer.shouldRasterize = YES;
    _leftBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [_leftBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    [_leftBtn setTitleColor:HEXCOLOR(0xff2d4b) forState:UIControlStateNormal];
    _leftBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_leftBtn];
    [_leftBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imaView.bottom).offset(20);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(SelfWidth*0.5-14-18);
        make.height.equalTo(40);
    }];
//    [_leftBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
  
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.backgroundColor = HEXCOLOR(0xff2d4b);
    _rightBtn.layer.cornerRadius = 2.5;
    _rightBtn.clipsToBounds = YES;
    _rightBtn.layer.shouldRasterize = YES;
    _rightBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [_rightBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:HEXCOLOR(0xff2d4b) forState:UIControlStateNormal];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_rightBtn];
    [_rightBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imaView.bottom).offset(20);
        make.left.equalTo(_leftBtn.right).offset(18);
        make.width.equalTo(SelfWidth*0.5-14-18);
        make.height.equalTo(40);
    }];
}


@end
