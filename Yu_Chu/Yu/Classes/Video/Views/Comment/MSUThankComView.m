//
//  MSUThankComView.m
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

#import "MSUThankComView.h"
#import "MSUPathTools.h"

@implementation MSUThankComView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    UIImageView *imaView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 6, SelfWidth-12, 33)];
    imaView.image = [MSUPathTools showImageWithContentOfFileByName:@"img_smilingface"];
    [self addSubview:imaView];
    [imaView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(30);
        make.left.equalTo(self.left).offset(37);
        make.width.equalTo(55);
        make.height.equalTo(55);
    }];
    
    UILabel *sucLab = [[UILabel alloc] init];
    sucLab.text = @"评价成功~";
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
    detailLab.text = @"你的评价将会是其他用户选购前重要的参考";
    detailLab.font = [UIFont systemFontOfSize:12];
    detailLab.textColor = HEXCOLOR(0xb7b7b7);
    [self addSubview:detailLab];
    [detailLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sucLab.bottom).offset(13);
        make.left.equalTo(imaView.right).offset(15);
        make.width.equalTo(SelfWidth-37-55-15-14);
        make.height.equalTo(12);
    }];
    
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = HEXCOLOR(0xffffff);
    bgView.layer.shadowColor = HEXCOLOR(0xc2c2c2).CGColor;
    bgView.layer.shadowOpacity = 0.6;
    bgView.layer.shadowPath = (__bridge CGPathRef _Nullable)([MSUPathTools drawShadowAroundControls:bgView shadowHeight:10]);
    [self addSubview:bgView];
    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imaView.bottom).offset(23);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(SelfWidth-28);
        make.height.equalTo(119);
    }];
    
    self.iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _iconBtn.backgroundColor = [UIColor brownColor];
    _iconBtn.layer.cornerRadius = 25*0.5;
    _iconBtn.clipsToBounds = YES;
    _iconBtn.layer.shouldRasterize = YES;
    _iconBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [_iconBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"shop_img_head"] forState:UIControlStateNormal];
    [bgView addSubview:_iconBtn];
    [_iconBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.top).offset(14);
        make.left.equalTo(bgView.left).offset(14);
        make.width.equalTo(25);
        make.height.equalTo(25);
    }];
    //    [_iconBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.nameLab = [[UILabel alloc] init];
    _nameLab.text = @"两岸擦费 >";
    _nameLab.font = [UIFont systemFontOfSize:14];
    _nameLab.textColor = HEXCOLOR(0x272727);
    [bgView addSubview:_nameLab];
    [_nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_iconBtn.centerY).offset(0);
        make.left.equalTo(_iconBtn.right).offset(10);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(14);
    }];

    self.timeLab = [[UILabel alloc] init];
    _timeLab.text = @"22小时27分钟前";
    _timeLab.font = [UIFont systemFontOfSize:12];
    _timeLab.textColor = HEXCOLOR(0xb7b7b7);
    [bgView addSubview:_timeLab];
    [_timeLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLab.bottom).offset(12);
        make.left.equalTo(_iconBtn.right).offset(10);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(12);
    }];
    
    self.detailLab = [[UILabel alloc] init];
    _detailLab.text = @"联合会hihi合理hi";
    _detailLab.font = [UIFont systemFontOfSize:12];
    _detailLab.textColor = HEXCOLOR(0x272727);
    [bgView addSubview:_detailLab];
    [_detailLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLab.bottom).offset(23);
        make.left.equalTo(_iconBtn.right).offset(10);
        make.width.equalTo(SelfWidth-14-35-10-14);
        make.height.equalTo(12);
    }];

    self.priceLab = [[UILabel alloc] init];
    _priceLab.text = @"¥22.90";
    _priceLab.textAlignment = NSTextAlignmentRight;
    _priceLab.font = [UIFont systemFontOfSize:14];
    _priceLab.textColor = HEXCOLOR(0xff2d4b);
    [bgView addSubview:_priceLab];
    [_priceLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLab.top).offset(0);
        make.right.equalTo(self.right).offset(-14);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(14);
    }];
    
    
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.backgroundColor = HEXCOLOR(0xff2d4b);
    _moreBtn.layer.cornerRadius = 2.5;
    _moreBtn.clipsToBounds = YES;
    _moreBtn.layer.shouldRasterize = YES;
    _moreBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [_moreBtn setTitle:@"评价更多订单" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_moreBtn];
    [_moreBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.bottom).offset(30);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(SelfWidth-28);
        make.height.equalTo(40);
    }];

    
}


@end
