//
//  MSUOrderBottomTableCell.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/6.
//  Copyright © 2017年 何龙飞. All rights reserved.
//


//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#import "XLZHHeader.h"

#define SelfContentWidth self.contentView.frame.size.width
#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#import "MSUOrderBottomTableCell.h"

@implementation MSUOrderBottomTableCell

-(void)setValueToAllSubviews:(DCCOrderModel *)model{
    [self.iconBtn.imageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    self.nameLab.text = [NSString stringWithFormat:@"%@ >",model.shopName];
    _statusLab.text = @"订单已完成";
//    NSInteger timeInterVal = model.crea
    _timeLab.text = @"22小时27分钟前";

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContentView];
    }
    return self;
}

- (void)createContentView{
    self.iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _iconBtn.backgroundColor = [UIColor brownColor];
    _iconBtn.layer.cornerRadius = 25;
    _iconBtn.clipsToBounds = YES;
    _iconBtn.layer.shouldRasterize = YES;
    _iconBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    //    [_iconBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@""] forState:UIControlStateNormal];
    [self.contentView addSubview:_iconBtn];
    [_iconBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.top).offset(15);
        make.left.equalTo(self.contentView.left).offset(14);
        make.width.equalTo(50);
        make.height.equalTo(50);
    }];
    //    [_iconBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.nameLab = [[UILabel alloc] init];
    _nameLab.font = [UIFont systemFontOfSize:15];
    _nameLab.textColor = HEXCOLOR(0x272727);
    [self addSubview:_nameLab];
    [_nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconBtn.top).offset(0);
        make.left.equalTo(_iconBtn.right).offset(10);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(15);
    }];
    
    self.statusLab = [[UILabel alloc] init];
    _statusLab.textAlignment = NSTextAlignmentRight;
    _statusLab.font = [UIFont systemFontOfSize:12];
    _statusLab.textColor = HEXCOLOR(0xb7b7b7);
    [self addSubview:_statusLab];
    [_statusLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(15);
        make.right.equalTo(self.right).offset(-14);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(12);
    }];
    
    self.timeLab = [[UILabel alloc] init];
    _timeLab.font = [UIFont systemFontOfSize:12];
    _timeLab.textColor = HEXCOLOR(0xb7b7b7);
    [self addSubview:_timeLab];
    [_timeLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLab.bottom).offset(15);
        make.left.equalTo(_iconBtn.right).offset(10);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(12);
    }];
    
    self.detailLab = [[UILabel alloc] init];
    _detailLab.text = @"联合会hihi合理hi";
    _detailLab.font = [UIFont systemFontOfSize:12];
    _detailLab.textColor = HEXCOLOR(0x272727);
    [self addSubview:_detailLab];
    [_detailLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLab.bottom).offset(25);
        make.left.equalTo(_iconBtn.right).offset(10);
        make.width.equalTo(SelfWidth-14-50-10-14);
        make.height.equalTo(12);
    }];

    
    self.priceLab = [[UILabel alloc] init];
    _priceLab.text = @"¥22.90";
    _priceLab.textAlignment = NSTextAlignmentRight;
    _priceLab.font = [UIFont systemFontOfSize:14];
    _priceLab.textColor = HEXCOLOR(0xff2d4b);
    [self addSubview:_priceLab];
    [_priceLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_statusLab.bottom).offset(51);
        make.right.equalTo(self.right).offset(-14);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(14);
    }];
    
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentBtn.backgroundColor = HEXCOLOR(0xff2d4b);
    _commentBtn.layer.cornerRadius = 3;
    _commentBtn.clipsToBounds = YES;
    _commentBtn.layer.shouldRasterize = YES;
    _commentBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [_commentBtn setTitle:@"评价" forState:UIControlStateNormal];
    [_commentBtn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
    _commentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_commentBtn];
    [_commentBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLab.bottom).offset(30);
        make.right.equalTo(self.contentView.right).offset(-14);
        make.width.equalTo(75);
        make.height.equalTo(29);
    }];
    [_commentBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.againBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _againBtn.backgroundColor = HEXCOLOR(0xffffff);
    _againBtn.layer.cornerRadius = 3;
    _againBtn.clipsToBounds = YES;
    _againBtn.layer.shouldRasterize = YES;
    _againBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _againBtn.layer.borderColor = HEXCOLOR(0xff2d4b).CGColor;
    _againBtn.layer.borderWidth = 1;
    [_againBtn setTitle:@"再来一单" forState:UIControlStateNormal];
    [_againBtn setTitleColor:HEXCOLOR(0xff2d4b) forState:UIControlStateNormal];
    _againBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_againBtn];
    [_againBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLab.bottom).offset(30);
        make.right.equalTo(self.contentView.right).offset(-14-75-25);
        make.width.equalTo(103);
        make.height.equalTo(29);
    }];
    //    [_iconBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = HEXCOLOR(0xf2f2f2);
    [self addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.bottom).offset(-1);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(1);
    }];
}

- (void)commentBtnClick:(UIButton *)sender{
    if (self.commentBlickBlock) {
        self.commentBlickBlock(sender);
    }
}

@end
