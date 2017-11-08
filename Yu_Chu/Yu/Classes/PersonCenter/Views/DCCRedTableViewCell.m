//
//  DCCRedTableViewCell.m
//  Yu
//
//  Created by duanchongchong on 2017/11/2.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "DCCRedTableViewCell.h"
#import "XLZHHeader.h"
#import "Masonry.h"

@implementation DCCRedTableViewCell{
    
    UILabel *_firstLab;
    UILabel *_secondLab;
    UILabel *_thirdLab;
    UILabel *_fourthLab;
    UILabel *_priceLab;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initAllSubviews];
        [self initAllData];
    }
    return self;
}
- (void)initAllData{
    _firstLab.text = @"欢迎成为两岸御厨领取红包";
    _secondLab.text = @"满0元可使用";
    _thirdLab.text = @"有效期至：2017-11-30";
    _fourthLab.text = @"仅限手机号13522812258的帅哥用户使用";
    _priceLab.text = @"¥ 1000";
}
- (void)initAllSubviews{
    UIImageView *backIMGV = [[UIImageView alloc] init];
    backIMGV.image = [UIImage imageNamed:@"bg_icon_redbag"];
    backIMGV.userInteractionEnabled = YES;
    backIMGV.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:backIMGV];
    [backIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(14);
        make.top.equalTo(self.mas_top).with.offset(5);
        make.right.equalTo(self.mas_right).with.offset(-14);
        make.bottom.equalTo(self.mas_bottom).with.offset(-5);
    }];
    
    _firstLab = [[UILabel alloc] init];
    _firstLab.textColor = JQXXXLZHFF2D4BCLOLR;
    _firstLab.font = [UIFont systemFontOfSize:15];
    [backIMGV addSubview:_firstLab];
    
    _secondLab = [[UILabel alloc] init];
    _secondLab.textColor = JQXXXLZH787878CLOLR;
    _secondLab.font = [UIFont systemFontOfSize:11];
    [backIMGV addSubview:_secondLab];
    
    _thirdLab = [[UILabel alloc] init];
    _thirdLab.textColor = JQXXXLZH787878CLOLR;
    _thirdLab.font = [UIFont systemFontOfSize:11];
    [backIMGV addSubview:_thirdLab];
    
    _fourthLab = [[UILabel alloc] init];
    _fourthLab.textColor = JQXXXLZHFF2D4BCLOLR;
    _fourthLab.font = [UIFont systemFontOfSize:11];
    [backIMGV addSubview:_fourthLab];
    
    _priceLab = [[UILabel alloc] init];
    _priceLab.textColor = JQXXXLZHFF2D4BCLOLR;
    _priceLab.font = [UIFont systemFontOfSize:15];
    [backIMGV addSubview:_priceLab];
    
    [_firstLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backIMGV.mas_left).with.offset(7);
        make.top.equalTo(backIMGV.mas_top).with.offset(10);
        make.right.equalTo(backIMGV.mas_right).with.offset(backIMGV.frameSizeWidth/8.0*3.0);
    }];
    
    [_secondLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backIMGV.mas_left).with.offset(7);
        make.top.equalTo(_firstLab.mas_bottom).with.offset(10);
        make.right.equalTo(backIMGV.mas_right).with.offset(backIMGV.frameSizeWidth/8.0*3.0);
    }];
    
    [_thirdLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backIMGV.mas_left).with.offset(7);
        make.top.equalTo(_secondLab.mas_bottom).with.offset(2);
        make.right.equalTo(backIMGV.mas_right).with.offset(backIMGV.frameSizeWidth/8.0*3.0);
    }];
    
    [_fourthLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backIMGV.mas_left).with.offset(7);
        make.top.equalTo(_thirdLab.mas_bottom).with.offset(10);
        make.right.equalTo(backIMGV.mas_right).with.offset(backIMGV.frameSizeWidth/8.0*3.0);
    }];
    
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backIMGV.mas_centerY).with.offset(0);
        make.right.equalTo(backIMGV.mas_right).with.offset(-30);
    }];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
