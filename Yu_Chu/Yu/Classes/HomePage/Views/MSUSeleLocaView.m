//
//  MSUSeleLocaView.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/1.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUSeleLocaView.h"

#import "MSUPathTools.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#define SelfContentWidth self.contentView.frame.size.width
#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation MSUSeleLocaView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    UILabel *attentionLab = [[UILabel alloc] init];
    attentionLab.text = @"当前位置";
    attentionLab.font = [UIFont systemFontOfSize:12];
    attentionLab.textColor = HEXCOLOR(0xb7b7b7);
    [self addSubview:attentionLab];
    [attentionLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(70);
        make.height.equalTo(12);
    }];
    
    self.locaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _locaBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_locaBtn setTitle:@"重新定位" forState:UIControlStateNormal];
    [_locaBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 4, 0, 0)];
    [_locaBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"address_icon_refresh"] forState:UIControlStateNormal];
    _locaBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4);
    [_locaBtn setTitleColor:HEXCOLOR(0xff2d4b) forState:UIControlStateNormal];
    [self addSubview:_locaBtn];
    [_locaBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.right.equalTo(self.right).offset(-22);
        make.width.equalTo(75);
        make.height.equalTo(12);
    }];
//    [_locaBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.addreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addreBtn setTitle:@"定位中" forState:UIControlStateNormal];
    [_addreBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [_addreBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"address_icon_location"] forState:UIControlStateNormal];
    _addreBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    [_addreBtn setTitleColor:HEXCOLOR(0xff2d4b) forState:UIControlStateNormal];
    _addreBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_addreBtn];
//    [self.addreBtn makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.top).offset(34);
//        make.left.equalTo(self.left).offset(14);
//        make.width.equalTo(0);
//        make.height.equalTo(20);
//    }];
    
//    [_addreBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = HEXCOLOR(0xf4f4f4);
    [self addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addreBtn.bottom).offset(16);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(1);
    }];
    
    UILabel *addLab = [[UILabel alloc] init];
    addLab.text = @"我的收获地址";
    addLab.font = [UIFont systemFontOfSize:12];
    addLab.textColor = HEXCOLOR(0xb7b7b7);
    [self addSubview:addLab];
    [addLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(30);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(100);
        make.height.equalTo(12);
    }];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = HEXCOLOR(0xf4f4f4);
    [self addSubview:lineView1];
    [lineView1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addLab.bottom).offset(14);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(1);
    }];
    
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editBtn setTitle:@"编写地址" forState:UIControlStateNormal];
    [_editBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 4, 0, 0)];
    [_editBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"address_icon_edit"] forState:UIControlStateNormal];
    _editBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4);
    [_editBtn setTitleColor:HEXCOLOR(0xff2d4b) forState:UIControlStateNormal];
    _editBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_editBtn];
    [_editBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addLab.top).offset(0);
        make.right.equalTo(self.right).offset(-22);
        make.width.equalTo(75);
        make.height.equalTo(12);
    }];

    
}


@end
