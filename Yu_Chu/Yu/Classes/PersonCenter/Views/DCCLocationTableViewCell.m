//
//  DCCLocationTableViewCell.m
//  Yu
//
//  Created by duanchongchong on 2017/11/3.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "DCCLocationTableViewCell.h"
#import "XLZHHeader.h"
#import "Masonry.h"

@implementation DCCLocationTableViewCell{
    UILabel *_nameAndMobilelab;
    UILabel *_locationLab;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initAllSubviews];
    }
    return self;
}
- (void)initAllDataWith:(DCCLocationModel *)model{
    _nameAndMobilelab.text = [NSString stringWithFormat:@"%@  %@",model.consignee,model.mobile];
    _locationLab.text = [NSString stringWithFormat:@"%@  %@",model.address,model.hnumber];
}

- (void)initAllSubviews{
    self.backgroundColor = JQXXXLZHFAFAFACLOLR;
    UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 79)];
    backV.backgroundColor = JQXXXLZHFFFFFFCLOLR;
    backV.userInteractionEnabled = YES;
    [self addSubview:backV];
    
    _nameAndMobilelab = [[UILabel alloc] init];
    _nameAndMobilelab.textColor = JQXXXLZH787878CLOLR;
    _nameAndMobilelab.font = [UIFont systemFontOfSize:14];
    [backV addSubview: _nameAndMobilelab];
    
    _locationLab = [[UILabel alloc] init];
    _locationLab.textColor = JQXXXLZH272727CLOLR;
    _locationLab.font = [UIFont systemFontOfSize:14];
    [backV addSubview:_locationLab];
    
    _editBtn = [[UIButton alloc] init];
    [_editBtn setImage:[UIImage imageNamed:@"address_icon_edit"] forState:UIControlStateNormal];
    _editBtn.contentHorizontalAlignment = 0;
    _editBtn.contentVerticalAlignment = 0;
    [backV addSubview:_editBtn];
    
    [_nameAndMobilelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(14);
        make.top.equalTo(self.mas_top).with.offset(15);
    }];
    
    [_locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(14);
        make.top.equalTo(_nameAndMobilelab.mas_bottom).with.offset(15);
    }];
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(0);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(52);
        make.height.mas_equalTo(52);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
