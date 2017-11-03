//
//  MSUCarTableCell.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/3.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#import "MSUStringTools.h"
#import "MSUPathTools.h"

#define SelfContentWidth self.contentView.frame.size.width
#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#import "MSUCarTableCell.h"

@implementation MSUCarTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContentView];
    }
    return self;
}

- (void)createContentView{
    self.nameLab = [[UILabel alloc] init];
    _nameLab.text = @"海鲜面面面面";
    _nameLab.font = [UIFont systemFontOfSize:14];
    _nameLab.textColor = HEXCOLOR(0x272727);
    [self addSubview:_nameLab];
    [_nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(15);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(14);
    }];
    
    self.introLab = [[UILabel alloc] init];
    _introLab.text = @"好吃么好吃么";
    _introLab.font = [UIFont systemFontOfSize:10];
    _introLab.textColor = HEXCOLOR(0xb7b7b7);
    [self addSubview:_introLab];
    [_introLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLab.bottom).offset(7);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(10);
    }];
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.layer.cornerRadius = 11;
    _addBtn.clipsToBounds = YES;
    _addBtn.layer.shouldRasterize = YES;
    _addBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [_addBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"shop_icon_plus"] forState:UIControlStateNormal];
    [self.contentView addSubview:_addBtn];
    [_addBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.top).offset(19);
        make.right.equalTo(self.contentView.right).offset(-14);
        make.width.equalTo(22);
        make.height.equalTo(22);
    }];
//    [_addBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.numLab = [[UILabel alloc] init];
    _numLab.text = @"1";
    CGSize sizeA = [MSUStringTools danamicGetWidthFromText:_numLab.text WithFont:15];
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
    
    self.deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleBtn.layer.cornerRadius = 11;
    _deleBtn.clipsToBounds = YES;
    _deleBtn.layer.shouldRasterize = YES;
    _deleBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [_deleBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"shop_icon_subtract"] forState:UIControlStateNormal];
    [self.contentView addSubview:_deleBtn];
    [_deleBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.top).offset(19);
        make.right.equalTo(_numLab.left).offset(-10);
        make.width.equalTo(22);
        make.height.equalTo(22);
    }];
    //    [_addBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];


    self.priceLab = [[UILabel alloc] init];
    _priceLab.text = [NSString stringWithFormat:@"¥%@",@"34"];
    _priceLab.font = [UIFont systemFontOfSize:15];
    _priceLab.textAlignment = NSTextAlignmentCenter;
    _priceLab.textColor = HEXCOLOR(0xff2d4b);
    [self addSubview:_priceLab];
    [_priceLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(22.5);
        make.right.equalTo(_deleBtn.left).offset(-14);
        make.width.equalTo(50);
        make.height.equalTo(15);
    }];
}


@end
