//
//  MSUOrderTopView.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/6.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUOrderTopView.h"

#import "MSUPathTools.h"
#import "MSUStringTools.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfContentWidth self.contentView.frame.size.width
#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation MSUOrderTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    self.goodPic = [[UIImageView alloc] init];
    _goodPic.backgroundColor = [UIColor brownColor];
    [self addSubview:_goodPic];
    [_goodPic makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(SelfWidth*9/16);
    }];
    
    self.nameLab = [[UILabel alloc] init];
    _nameLab.text = @"照片鸡腿饭";
    _nameLab.font = [UIFont systemFontOfSize:15];
    _nameLab.textColor = HEXCOLOR(0x272727);
    [self addSubview:_nameLab];
    [_nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodPic.bottom).offset(19);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(15);
    }];
    
    self.priceLab = [[UILabel alloc] init];
    _priceLab.text = @"¥34";
    _priceLab.font = [UIFont systemFontOfSize:15];
    _priceLab.textColor = HEXCOLOR(0xff2d4b);
    [self addSubview:_priceLab];
    [_priceLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLab.bottom).offset(23);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(50);
        make.height.equalTo(15);
    }];
    
    self.joinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _joinBtn.layer.cornerRadius = 39*0.5;
    _joinBtn.clipsToBounds = YES;
    _joinBtn.layer.shouldRasterize = YES;
    _joinBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _joinBtn.layer.borderWidth = 1;
    _joinBtn.layer.borderColor = HEXCOLOR(0xff2d4b).CGColor;
    [_joinBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
     [_joinBtn setTitleColor:HEXCOLOR(0xff2d4b) forState:UIControlStateNormal];
    _joinBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_joinBtn];
    [_joinBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodPic.bottom).offset(30);
        make.right.equalTo(self.right).offset(-14);
        make.width.equalTo(100);
        make.height.equalTo(39);
    }];
//    [_joinBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"shop_icon_plus"] forState:UIControlStateNormal];
    [self addSubview:_addBtn];
    [_addBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodPic.bottom).offset(30);
        make.right.equalTo(self.right).offset(-14);
        make.width.equalTo(22);
        make.height.equalTo(22);
    }];
    _addBtn.hidden = YES;
    
    self.numLab = [[UILabel alloc] init];
    _numLab.text = @"1";
    CGSize sizeA = [MSUStringTools danamicGetWidthFromText:self.numLab.text WithFont:15];
    _numLab.font = [UIFont systemFontOfSize:15];
    _numLab.textColor = HEXCOLOR(0xff2d4b);
    _numLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_numLab];
    [_numLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_addBtn.centerY).offset(0);
        make.right.equalTo(_addBtn.left).offset(-10);
        make.width.equalTo(sizeA.width+10);
        make.height.equalTo(15);
    }];
    _numLab.hidden = YES;
    
    self.deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"shop_icon_subtract"] forState:UIControlStateNormal];
    [self addSubview:_deleBtn];
    [_deleBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addBtn.top).offset(0);
        make.right.equalTo(_numLab.left).offset(-10);
        make.width.equalTo(22);
        make.height.equalTo(22);
    }];
    _deleBtn.hidden = YES;
    
}




@end
