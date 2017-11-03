//
//  MSUSellerTableCell.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/3.
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

#import "MSUSellerTableCell.h"

@implementation MSUSellerTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContentView];
    }
    return self;
}

- (void)createContentView{
    self.leftImaView = [[UIImageView alloc] init];
    [self addSubview:_leftImaView];
    [_leftImaView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.top).offset(14.5);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(21);
        make.height.equalTo(21);
    }];
    
    self.rightLab = [[UILabel alloc] init];
    _rightLab.font = [UIFont systemFontOfSize:14];
    _rightLab.textColor = HEXCOLOR(0x272727);
    [self addSubview:_rightLab];
    [_rightLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftImaView.centerY).offset(0);
        make.left.equalTo(_leftImaView.right).offset(8);
        make.width.equalTo(SelfWidth-28-30);
        make.height.equalTo(14);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, 49, SelfWidth, 1);
    lineView.backgroundColor = HEXCOLOR(0xf0f0f0);
    [self addSubview:lineView];
}


@end
