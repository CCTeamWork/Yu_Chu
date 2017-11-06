//
//  MSUOrderCanelView.m
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

#import "MSUOrderCanelView.h"

#import "MSUPathTools.h"

@implementation MSUOrderCanelView

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
    sucLab.text = @"正在等待商家取消订单";
    sucLab.font = [UIFont systemFontOfSize:17];
    sucLab.textColor = HEXCOLOR(0x272727);
    [self addSubview:sucLab];
    [sucLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imaView.centerY).offset(0);
        make.left.equalTo(imaView.right).offset(15);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(17);
    }];

    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.backgroundColor = HEXCOLOR(0xff2d4b);
    _backBtn.layer.cornerRadius = 2.5;
    _backBtn.clipsToBounds = YES;
    _backBtn.layer.shouldRasterize = YES;
    _backBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [_backBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    [_backBtn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
    _backBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_backBtn];
    [_backBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sucLab.bottom).offset(40);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(SelfWidth-28);
        make.height.equalTo(40);
    }];

    
}


@end
