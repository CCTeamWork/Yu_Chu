//
//  MSUComView.m
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

#import "MSUComView.h"

#import "MSUPathTools.h"

@implementation MSUComView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    self.iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _iconBtn.backgroundColor = [UIColor brownColor];
    _iconBtn.layer.cornerRadius = 35*0.5;
    _iconBtn.clipsToBounds = YES;
    _iconBtn.layer.shouldRasterize = YES;
    _iconBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    //    [_iconBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@""] forState:UIControlStateNormal];
    [self addSubview:_iconBtn];
    [_iconBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(15);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(35);
        make.height.equalTo(35);
    }];
    //    [_iconBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.nameLab = [[UILabel alloc] init];
    _nameLab.text = @"两岸擦费 >";
    _nameLab.font = [UIFont systemFontOfSize:15];
    _nameLab.textColor = HEXCOLOR(0x272727);
    [self addSubview:_nameLab];
    [_nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_iconBtn.centerY).offset(0);
        make.left.equalTo(_iconBtn.right).offset(10);
        make.width.equalTo(SelfWidth-14-35-10-14);
        make.height.equalTo(15);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = HEXCOLOR(0xf0f0f0);
    [self addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconBtn.bottom).offset(14);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(SelfWidth-28);
        make.height.equalTo(1);
    }];
    
    UILabel *comLab = [[UILabel alloc] init];
    comLab.text = @"美食评价";
    comLab.font = [UIFont systemFontOfSize:14];
    comLab.textColor = HEXCOLOR(0xb7b7b7);
    [self addSubview:comLab];
    [comLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(30);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(60);
        make.height.equalTo(14);
    }];
    
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView *imaView = [[UIImageView alloc] init];
        imaView.contentMode = UIViewContentModeScaleToFill;
        imaView.image = [MSUPathTools showImageWithContentOfFileByName:@"comment_icon_greystar"];
        imaView.highlightedImage = [MSUPathTools showImageWithContentOfFileByName:@"comment_icon_redstar"];
        [self addSubview:imaView];
        [imaView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(comLab.top).offset(0);
            make.left.equalTo(self.left).offset(SelfWidth-150-28+32*i);
            make.width.equalTo(22);
            make.height.equalTo(22);
        }];
        [self.starArr addObject:imaView];
        
        //        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        btn.imageView.contentMode = UIViewContentModeScaleToFill;
        //        [btn setImage:[MSUPathTools showImageWithContentOfFileByName:@"comment_icon_greystar"] forState:UIControlStateNormal];
        //        [btn setImage:[MSUPathTools showImageWithContentOfFileByName:@"comment_icon_redstar"] forState:UIControlStateSelected];
        //        [bgView addSubview:btn];
        //        [btn makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(self.top).offset(31.5);
        //            make.left.equalTo(self.left).offset(SelfWidth-150-28+32*i);
        //            make.width.equalTo(22);
        //            make.height.equalTo(22);
        //        }];
        //        [self.starArr addObject:btn];
    }
    
    self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn1.layer.cornerRadius = 2.5;
    _btn1.clipsToBounds = YES;
    _btn1.layer.shouldRasterize = YES;
    _btn1.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _btn1.layer.borderColor = HEXCOLOR(0xb7b7b7).CGColor;
    _btn1.layer.borderWidth = 1;
    [_btn1 setTitle:@"包装精美" forState:UIControlStateNormal];
    [_btn1 setTitleColor:HEXCOLOR(0xb7b7b7) forState:UIControlStateNormal];
    _btn1.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_btn1];
    [_btn1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(comLab.bottom).offset(32);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(68);
        make.height.equalTo(29);
    }];
    
    self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn2.layer.cornerRadius = 2.5;
    _btn2.clipsToBounds = YES;
    _btn2.layer.shouldRasterize = YES;
    _btn2.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _btn2.layer.borderColor = HEXCOLOR(0xb7b7b7).CGColor;
    _btn2.layer.borderWidth = 1;
    [_btn2 setTitle:@"食材新鲜" forState:UIControlStateNormal];
    [_btn2 setTitleColor:HEXCOLOR(0xb7b7b7) forState:UIControlStateNormal];
    _btn2.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_btn2];
    [_btn2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btn1.top).offset(0);
        make.left.equalTo(_btn1.right).offset(20);
        make.width.equalTo(68);
        make.height.equalTo(29);
    }];
    
    self.btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn3.layer.cornerRadius = 2.5;
    _btn3.clipsToBounds = YES;
    _btn3.layer.shouldRasterize = YES;
    _btn3.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _btn3.layer.borderColor = HEXCOLOR(0xb7b7b7).CGColor;
    _btn3.layer.borderWidth = 1;
    [_btn3 setTitle:@"分量足" forState:UIControlStateNormal];
    [_btn3 setTitleColor:HEXCOLOR(0xb7b7b7) forState:UIControlStateNormal];
    _btn3.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_btn3];
    [_btn3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btn1.top).offset(0);
        make.left.equalTo(_btn2.right).offset(20);
        make.width.equalTo(54);
        make.height.equalTo(29);
    }];
    
    self.textView = [[UITextView alloc] init];
    _textView.backgroundColor = HEXCOLOR(0xf2f2f2);
    [self addSubview:_textView];
    [_textView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btn3.bottom).offset(60);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(SelfWidth-28);
        make.height.equalTo(115);
    }];
    
    self.placeLab = [[UILabel alloc] init];
    _placeLab.text = @"你的评价将匿名发送给商家";
    _placeLab.textColor = HEXCOLOR(0xb7b7b7);
    _placeLab.font = [UIFont systemFontOfSize:14];
    [_textView addSubview:_placeLab];
    [_placeLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textView.top).offset(8);
        make.left.equalTo(_textView.left).offset(10);
        make.width.equalTo(SelfWidth-28);
        make.height.equalTo(14);
    }];
    
    self.pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _pushBtn.backgroundColor = HEXCOLOR(0xff2d4b);
    _pushBtn.layer.cornerRadius = 2.5;
    _pushBtn.clipsToBounds = YES;
    _pushBtn.layer.shouldRasterize = YES;
    _pushBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [_pushBtn setTitle:@"提交评价" forState:UIControlStateNormal];
    [_pushBtn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
    _pushBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_pushBtn];
    [_pushBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textView.bottom).offset(58);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(SelfWidth-28);
        make.height.equalTo(40);
    }];
//    [_pushBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma - 初始化
- (NSMutableArray *)starArr{
    if (!_starArr) {
        _starArr = [NSMutableArray array];
    }
    return _starArr;
}

@end
