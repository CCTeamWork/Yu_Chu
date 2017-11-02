//
//  MSUHomeTableCell.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/2.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUHomeTableCell.h"
#import "MSUPathTools.h"

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@implementation MSUHomeTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContentView];
    }
    return self;
}

- (void)createContentView{
    self.titLabel = [[UILabel alloc] init];
    _titLabel.text = @"今日推荐";
    _titLabel.font = [UIFont systemFontOfSize:20];
    _titLabel.textColor = HEXCOLOR(0x272727);
    [self addSubview:_titLabel];
    [_titLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(28);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(100);
        make.height.equalTo(20);
    }];
    
    self.subLabel = [[UILabel alloc] init];
    _subLabel.text = @"两岸御厨~吃遍大江南北，美味精挑细选";
    _subLabel.font = [UIFont systemFontOfSize:12];
    _subLabel.textColor = HEXCOLOR(0xb7b7b7);
    [self addSubview:_subLabel];
    [_subLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titLabel.bottom).offset(10);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(SelfWidth-28);
        make.height.equalTo(12);
    }];
    
    self.imaView = [[UIImageView alloc] init];
//    _imaView .image = [MSUPathTools showImageWithContentOfFileByName:@""];
    _imaView.backgroundColor = [UIColor brownColor];
    [self addSubview:_imaView];
    [_imaView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_subLabel.bottom).offset(20);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(SelfWidth-28);
        make.height.equalTo(SelfWidth*9/16);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"海鲜面";
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textColor = HEXCOLOR(0x272727);
    [self addSubview:_nameLabel];
    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imaView.bottom).offset(12);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(100);
        make.height.equalTo(14);
    }];
    
    self.priceLabel = [[UILabel alloc] init];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",@"26"];
    _priceLabel.font = [UIFont systemFontOfSize:15];
    _priceLabel.textColor = HEXCOLOR(0xff2d4b);
    [self addSubview:_priceLabel];
    [_priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.bottom).offset(6);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(100);
        make.height.equalTo(15);
    }];
    
    self.shopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shopBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"tabbar_icon_shopping_selected"] forState:UIControlStateNormal];
    [self.contentView addSubview:_shopBtn];
    [_shopBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLabel.centerY).offset(0);
        make.right.equalTo(self.right).offset(-14);
        make.width.equalTo(16);
        make.height.equalTo(16);
    }];
//    [_shopBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    

    
    
    
}

@end
