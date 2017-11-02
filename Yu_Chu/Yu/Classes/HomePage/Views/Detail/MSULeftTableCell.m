//
//  MSULeftTableCell.m
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

#import "MSULeftTableCell.h"

@implementation MSULeftTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContentView];
    }
    return self;
}

- (void)createContentView{
//    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_leftBtn setTitle:@"御厨\n精选系列" forState:UIControlStateNormal];
//    _leftBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    [_leftBtn setTitleColor:HEXCOLOR(0xb7b7b7) forState:UIControlStateNormal];
//    [_leftBtn setTitleColor:HEXCOLOR(0xff2d4b) forState:UIControlStateSelected];
//    _leftBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//    _leftBtn.userInteractionEnabled = NO;
//    [self addSubview:_leftBtn];
//    [_leftBtn makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.top).offset(0);
//        make.left.equalTo(self.left).offset(0);
//        make.width.equalTo(74);
//        make.height.equalTo(56);
//    }];
//        [_leftBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
        self.topLab = [[UILabel alloc] init];
        _topLab.text = @"御厨";
        _topLab.font = [UIFont systemFontOfSize:12];
        _topLab.textAlignment = NSTextAlignmentCenter;
        _topLab.textColor = HEXCOLOR(0xb7b7b7);
        _topLab.highlightedTextColor = HEXCOLOR(0xff2d4b);
        [self addSubview:_topLab];
        [_topLab makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.top).offset(16);
            make.left.equalTo(self.left).offset(0);
            make.width.equalTo(74);
            make.height.equalTo(12);
        }];
    
        self.bottomlab = [[UILabel alloc] init];
        _bottomlab.text = @"精选系列";
        _bottomlab.font = [UIFont systemFontOfSize:12];
        _bottomlab.textAlignment = NSTextAlignmentCenter;
        _bottomlab.textColor = HEXCOLOR(0xb7b7b7);
        _bottomlab.highlightedTextColor = HEXCOLOR(0xff2d4b);
        [self addSubview:_bottomlab];
        [_bottomlab makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_topLab.bottom).offset(0);
            make.left.equalTo(self.left).offset(0);
            make.width.equalTo(74);
            make.height.equalTo(12);
        }];
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    self.contentView.backgroundColor = selected ? HEXCOLOR(0xffffff) : HEXCOLOR(0xf4f4f4);
    self.highlighted = selected;
    self.topLab.highlighted = selected;
    self.bottomlab.highlighted = selected;

}


@end
