//
//  MSUOrderBottomView.m
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

#import "MSUOrderBottomView.h"

@implementation MSUOrderBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    UILabel *disLab = [[UILabel alloc] init];
    disLab.text = @"描述";
    disLab.font = [UIFont systemFontOfSize:15];
    disLab.textColor = HEXCOLOR(0x272727);
    [self addSubview:disLab];
    [disLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(14);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(100);
        make.height.equalTo(15);
    }];
    
    self.introLab = [[UILabel alloc] init];
    _introLab.font = [UIFont systemFontOfSize:14];
    _introLab.numberOfLines = 0;
    _introLab.textColor = HEXCOLOR(0x787878);
    [self addSubview:_introLab];
//    [_introLab makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(disLab.bottom).offset(14);
//        make.left.equalTo(self.left).offset(14);
//        make.width.equalTo(SelfWidth*0.5);
//        make.height.equalTo(15);
//    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = HEXCOLOR(0xf0f0f0);
    [self addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_introLab.bottom).offset(14);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(SelfWidth-28);
        make.height.equalTo(1);
    }];
    
    UILabel *foodLab = [[UILabel alloc] init];
    foodLab.text = @"食材";
    foodLab.font = [UIFont systemFontOfSize:15];
    foodLab.textColor = HEXCOLOR(0x272727);
    [self addSubview:foodLab];
    [foodLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(14);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(100);
        make.height.equalTo(15);
    }];
    
    self.mainLab = [[UILabel alloc] init];
    _mainLab.font = [UIFont systemFontOfSize:14];
    _mainLab.numberOfLines = 0;
    _mainLab.textColor = HEXCOLOR(0x787878);
    [self addSubview:_mainLab];
    
}

@end
