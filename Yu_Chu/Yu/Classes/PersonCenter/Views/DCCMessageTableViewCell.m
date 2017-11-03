//
//  DCCMessageTableViewCell.m
//  Yu
//
//  Created by duanchongchong on 2017/11/3.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "DCCMessageTableViewCell.h"
#import "XLZHHeader.h"
#import "Masonry.h"

@implementation DCCMessageTableViewCell{
    UILabel *_firstLab;
    UILabel *_timeLab;
    UILabel *_contentLab;
    UIImageView *_rightIMGC;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initAllSubviews];
        [self initAllData];
    }
    return self;
}
- (void)initAllData{
    _firstLab.text = @"您的订单已接单";
    _timeLab.text = @"08-08  18:58";
    _contentLab.text = [NSString stringWithFormat:@"您的【%@】已被商家接单",@"麻辣小龙虾"];
}

- (void)initAllSubviews{
    self.backgroundColor = JQXXXLZHFAFAFACLOLR;
    UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 79)];
    backV.backgroundColor = JQXXXLZHFFFFFFCLOLR;
    backV.userInteractionEnabled = YES;
    [self addSubview:backV];
    
    _firstLab = [[UILabel alloc] init];
    _firstLab.textColor = JQXXXLZH272727CLOLR;
    _firstLab.font = [UIFont systemFontOfSize:14];
    [backV addSubview:_firstLab];
    
    _contentLab = [[UILabel alloc] init];
    _contentLab.textColor = JQXXXLZHB7B7B7CLOLR;
    _contentLab.font = [UIFont systemFontOfSize:14];
    [backV addSubview:_contentLab];
    
    _timeLab = [[UILabel alloc] init];
    _timeLab.textColor = JQXXXLZHB7B7B7CLOLR;
    _timeLab.font = [UIFont systemFontOfSize:14];
    [backV addSubview:_timeLab];
    
    _rightIMGC = [[UIImageView alloc] init];
    _rightIMGC.image = [UIImage imageNamed:@"icon_forward"];
    [backV addSubview:_rightIMGC];
    
    [_firstLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(14);
        make.top.equalTo(self.mas_top).with.offset(15);
        make.right.equalTo(self.mas_right).with.offset(-self.frameSizeWidth/4.0*1.0);
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-14);
        make.centerY.equalTo(_firstLab.mas_centerY);
    }];
    
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(14);
        make.top.equalTo(_firstLab.mas_bottom).with.offset(17);
    }];
    
    [_rightIMGC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-14);
        make.centerY.equalTo(_contentLab.mas_centerY);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(14);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
