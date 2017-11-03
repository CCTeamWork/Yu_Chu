//
//  MSURightTableCell.m
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
#import "MSUStringTools.h"

#import "MSURightTableCell.h"

@implementation MSURightTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContentView];
    }
    return self;
}

- (void)createContentView{
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, 0, SelfWidth-74, 1);
    lineView.backgroundColor = HEXCOLOR(0xf0f0f0);
    [self addSubview:lineView];
    
    self.shopImaView = [[UIImageView alloc] init];
//    _shopImaView.image = [MSUPathTools showImageWithContentOfFileByName:@""];
    _shopImaView.backgroundColor = [UIColor brownColor];
    [self addSubview:_shopImaView];
    [_shopImaView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(14);
        make.left.equalTo(self.left).offset(8);
        make.width.equalTo(72);
        make.height.equalTo(72);
    }];
    
    self.nameLab = [[UILabel alloc] init];
    _nameLab.text = @"招牌鸡腿饭";
    _nameLab.font = [UIFont systemFontOfSize:14];
    _nameLab.textColor = HEXCOLOR(0x272727);
    [self addSubview:_nameLab];
    [_nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shopImaView.top).offset(0);
        make.left.equalTo(_shopImaView.right).offset(6);
        make.width.equalTo(SelfWidth-74-8-72-6-28);
        make.height.equalTo(14);
    }];
    
    self.introLab = [[UILabel alloc] init];
    _introLab.text = @"招牌鸡腿饭招牌鸡腿饭招牌鸡腿饭招牌鸡腿饭招牌鸡腿饭招牌鸡腿饭招牌鸡腿饭";
    _introLab.font = [UIFont systemFontOfSize:12];
    _introLab.textColor = HEXCOLOR(0x787878);
    _introLab.numberOfLines = 0;
    [self addSubview:_introLab];
    [_introLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLab.bottom).offset(10);
        make.left.equalTo(_shopImaView.right).offset(6);
        make.width.equalTo(SelfWidth-74-8-72-6-14);
        make.height.equalTo(30);
    }];
    
    self.priceLab = [[UILabel alloc] init];
    _priceLab.text = [NSString stringWithFormat:@"¥%@",@"345"];
    _priceLab.font = [UIFont systemFontOfSize:15];
    _priceLab.textColor = HEXCOLOR(0xff2d4b);
    _priceLab.numberOfLines = 0;
    [self addSubview:_priceLab];
    [_priceLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_introLab.bottom).offset(15);
        make.left.equalTo(_shopImaView.right).offset(6);
        make.width.equalTo(100);
        make.height.equalTo(15);
    }];
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"shop_icon_plus"] forState:UIControlStateNormal];
    [self.contentView addSubview:_addBtn];
    [_addBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_priceLab.centerY).offset(0);
        make.right.equalTo(self.contentView.right).offset(-14);
        make.width.equalTo(22);
        make.height.equalTo(22);
    }];
    [_addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
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
        make.width.equalTo(sizeA.width);
        make.height.equalTo(15);
    }];
    _numLab.hidden = YES;
    
    self.deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"shop_icon_subtract"] forState:UIControlStateNormal];
    [self.contentView addSubview:_deleBtn];
    [_deleBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addBtn.top).offset(0);
        make.right.equalTo(_numLab.left).offset(-10);
        make.width.equalTo(22);
        make.height.equalTo(22);
    }];
    [_deleBtn addTarget:self action:@selector(deleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _deleBtn.hidden = YES;
    

    
}

- (void)addBtnClick:(UIButton *)sender{
    if (self.addClickBlock) {
        self.addClickBlock(sender);
    }
}

- (void)deleBtnClick:(UIButton *)sender{
    if (self.deleClickBlock) {
        self.deleClickBlock(sender);
    }
}

@end
