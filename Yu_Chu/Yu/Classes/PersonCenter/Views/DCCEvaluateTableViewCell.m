//
//  DCCEvaluateTableViewCell.m
//  Yu
//
//  Created by duanchongchong on 2017/11/3.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "DCCEvaluateTableViewCell.h"
#import "XLZHHeader.h"
#import "Masonry.h"

@implementation DCCEvaluateTableViewCell{
    UILabel *_timeLab;
    UILabel *_contetLab;
    
    UIImageView *_starsOne;
    UIImageView *_starsTwo;
    UIImageView *_starsThree;
    UIImageView *_starsFour;
    UIImageView *_starsFive;
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

- (void)initAllData:(DCCMyEvaluateModel *)model{
    NSString *timeStr = model.replySime;
    NSString *stars = model.score;
    NSString *contentStr = model.content;
    _timeLab.text = timeStr;
    NSArray <UIImageView *>*imgArr = @[_starsOne,_starsTwo,_starsThree,_starsFour,_starsFive];
    NSInteger count = stars.integerValue;
    for (NSInteger i = 0; i < imgArr.count; i++) {
        UIImageView *imgv = imgArr[i];
        if (count > i) {
            imgv.image = [UIImage imageNamed:@"comment_icon_redstar"];
        }else{
            imgv.image = [UIImage imageNamed:@"comment_icon_greystar"];
        }
    }
    _contetLab.text = contentStr;
    _contetLab.numberOfLines = 0;
    CGFloat contentHeight = [self getSpaceLabelHeight:contentStr withFont:[UIFont systemFontOfSize:14] withWidth:_contetLab.frameSizeWidth];
    [_contetLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(contentHeight);
    }];
}

- (void)initAllSubviews{
    _timeLab = [[UILabel alloc] init];
    _timeLab.textColor = JQXXXLZHB7B7B7CLOLR;
    _timeLab.font = [UIFont systemFontOfSize:11];
    [self addSubview:_timeLab];
    
    _starsOne = [[UIImageView alloc] init];
    [self addSubview:_starsOne];
    
    _starsTwo = [[UIImageView alloc] init];
    [self addSubview:_starsTwo];
    
    _starsThree = [[UIImageView alloc] init];
    [self addSubview:_starsThree];
    
    _starsFour = [[UIImageView alloc] init];
    [self addSubview:_starsFour];
    
    _starsFive = [[UIImageView alloc] init];
    [self addSubview:_starsFive];
    
    _contetLab = [[UILabel alloc] init];
    _contetLab.textColor = JQXXXLZH272727CLOLR;
    _contetLab.font = [UIFont systemFontOfSize:14];
    _contetLab.numberOfLines = 0;
    [self addSubview:_contetLab];
    
    UIView *undeLV = [[UIView alloc] init];
    undeLV.backgroundColor = JQXXXLZHFAFAFACLOLR;
    [self addSubview:undeLV];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(20);
        make.top.equalTo(self.mas_top).with.offset(10);
    }];
    
    [_starsOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(20);
        make.top.equalTo(_timeLab.mas_bottom).with.offset(10);
        make.width.mas_equalTo(11);
        make.height.mas_equalTo(11);
    }];
    
    [_starsTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_starsOne.mas_right).with.offset(4);
        make.top.equalTo(_timeLab.mas_bottom).with.offset(10);
        make.width.mas_equalTo(11);
        make.height.mas_equalTo(11);
    }];
    
    [_starsThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_starsTwo.mas_right).with.offset(4);
        make.top.equalTo(_timeLab.mas_bottom).with.offset(10);
        make.width.mas_equalTo(11);
        make.height.mas_equalTo(11);
    }];
    
    [_starsFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_starsThree.mas_right).with.offset(4);
        make.top.equalTo(_timeLab.mas_bottom).with.offset(10);
        make.width.mas_equalTo(11);
        make.height.mas_equalTo(11);
    }];
    
    [_starsFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_starsFour.mas_right).with.offset(4);
        make.top.equalTo(_timeLab.mas_bottom).with.offset(10);
        make.width.mas_equalTo(11);
        make.height.mas_equalTo(11);
    }];
    
    [_contetLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(20);
        make.top.equalTo(_starsFive.mas_bottom).with.offset(10);
        make.width.mas_equalTo(kScreenWidth-40);
    }];
    [undeLV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(20);
        make.right.equalTo(self.mas_right).with.offset(-20);
        make.top.equalTo(self.mas_bottom).with.offset(-1);
        make.height.mas_equalTo(1);
    }];
}

-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 0;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
