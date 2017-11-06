//
//  MSUOrderTopTableCell.m
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

#import "MSUOrderTopTableCell.h"

@implementation MSUOrderTopTableCell

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
    _nameLab.text = @"两岸擦费 >";
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
    _statusLab.text = @"骑手正在赶往商家";
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
    _timeLab.text = @"22小时27分钟前";
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
        make.top.equalTo(_detailLab.top).offset(0);
        make.right.equalTo(self.right).offset(-14);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(14);
    }];
    

}


@end
