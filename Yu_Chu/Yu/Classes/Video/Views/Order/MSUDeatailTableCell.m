//
//  MSUDeatailTableCell.m
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


#import "MSUDeatailTableCell.h"

@implementation MSUDeatailTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContentView];
    }
    return self;
}

- (void)createContentView{
    self.leftLab = [[UILabel alloc] init];
    _leftLab.text = @"下单成功~";
    _leftLab.font = [UIFont systemFontOfSize:14];
    _leftLab.textColor = HEXCOLOR(0x272727);
    [self addSubview:_leftLab];
    [_leftLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(23);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(SelfWidth/3-14);
        make.height.equalTo(14);
    }];
    
    self.centerLab = [[UILabel alloc] init];
    _centerLab.text = @"x1";
    _centerLab.textAlignment = NSTextAlignmentCenter;
    _centerLab.font = [UIFont systemFontOfSize:14];
    _centerLab.textColor = HEXCOLOR(0x272727);
    [self addSubview:_centerLab];
    [_centerLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftLab.centerY).offset(0);
        make.left.equalTo(self.left).offset(SelfWidth*0.5-15);
        make.width.equalTo(30);
        make.height.equalTo(14);
    }];
    
    self.rightLab = [[UILabel alloc] init];
    _rightLab.textAlignment = NSTextAlignmentRight;
    _rightLab.text = @"¥23";
    _rightLab.font = [UIFont systemFontOfSize:14];
    _rightLab.textColor = HEXCOLOR(0x272727);
    [self addSubview:_rightLab];
    [_rightLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftLab.centerY).offset(0);
        make.right.equalTo(self.right).offset(-14);
        make.width.equalTo(60);
        make.height.equalTo(14);
    }];
}



@end
