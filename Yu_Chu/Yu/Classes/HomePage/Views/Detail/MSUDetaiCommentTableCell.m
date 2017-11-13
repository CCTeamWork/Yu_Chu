//
//  MSUDetaiCommentTableCell.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/3.
//  Copyright © 2017年 何龙飞. All rights reserved.
//


#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#import "MSUPathTools.h"
#import "MSUStringTools.h"

#import "MSUDetaiCommentTableCell.h"

@implementation MSUDetaiCommentTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createContentView];
    }
    return self;
}

- (void)createContentView{
    self.iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _iconBtn.layer.cornerRadius = 41*0.5;
    _iconBtn.clipsToBounds = YES;
    _iconBtn.layer.shouldRasterize = YES;
    _iconBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _iconBtn.backgroundColor = [UIColor brownColor];
//    [_iconBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@""] forState:UIControlStateNormal];
    [self.contentView addSubview:_iconBtn];
    [_iconBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.top).offset(28);
        make.left.equalTo(self.contentView.left).offset(14);
        make.width.equalTo(33);
        make.height.equalTo(33);
    }];
//    [_iconBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.nickLab = [[UILabel alloc] init];
    _nickLab.font = [UIFont systemFontOfSize:14];
    _nickLab.textColor = HEXCOLOR(0xff2d4b);
    [self addSubview:_nickLab];
    [_nickLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconBtn.top).offset(0);
        make.left.equalTo(_iconBtn.right).offset(10);
        make.width.equalTo(150);
        make.height.equalTo(14);
    }];
    
    self.timeLab = [[UILabel alloc] init];
    _timeLab.text = @"17-01-01 12：00";
    _timeLab.font = [UIFont systemFontOfSize:11];
    _timeLab.textColor = HEXCOLOR(0xb7b7b7);
    [self addSubview:_timeLab];
    [_timeLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickLab.bottom).offset(10);
        make.left.equalTo(_iconBtn.right).offset(10);
        make.width.equalTo(150);
        make.height.equalTo(11);
    }];
    
    for (NSInteger i = 0; i < 5; i++) {
//        UIImageView *imaView = [[UIImageView alloc] init];
//        imaView.contentMode = UIViewContentModeScaleToFill;
//        imaView.image = [MSUPathTools showImageWithContentOfFileByName:@"comment_icon_greystar"];
//        imaView.highlightedImage = [MSUPathTools showImageWithContentOfFileByName:@"comment_icon_redstar"];
//        [self addSubview:imaView];
//        [imaView makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_timeLab.bottom).offset(8);
//            make.left.equalTo(_iconBtn.right).offset(10+16*i);
//            make.width.equalTo(11);
//            make.height.equalTo(11);
//        }];
//        [self.starArr addObject:imaView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[MSUPathTools showImageWithContentOfFileByName:@"comment_icon_greystar"] forState:UIControlStateNormal];
        [btn setImage:[MSUPathTools showImageWithContentOfFileByName:@"comment_icon_redstar"] forState:UIControlStateSelected];
        [self addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_timeLab.bottom).offset(8);
            make.left.equalTo(_iconBtn.right).offset(10+16*i);
            make.width.equalTo(11);
            make.height.equalTo(11);
        }];
        [self.starArr addObject:btn];
    }
    
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_likeBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"comment_icon_dot_default"] forState:UIControlStateNormal];
    [_likeBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@"comment_icon_dot_pressed"] forState:UIControlStateSelected];
    [self addSubview:_likeBtn];
    [_likeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconBtn.top).offset(0);
        make.right.equalTo(self.contentView.right).offset(-14);
        make.width.equalTo(11);
        make.height.equalTo(11);
    }];
    [_likeBtn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.numLab = [[UILabel alloc] init];
    _numLab.textAlignment = NSTextAlignmentRight;
    _numLab.font = [UIFont systemFontOfSize:11];
    _numLab.textColor = HEXCOLOR(0xb7b7b7);
    [self addSubview:_numLab];
    [_numLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_likeBtn.centerY).offset(1);
        make.right.equalTo(_likeBtn.left).offset(-5);
        make.width.equalTo(150);
        make.height.equalTo(11);
    }];
    
    self.contenLab = [[UILabel alloc] init];
    _contenLab.text = @"17-01-01 12：00";
    _contenLab.font = [UIFont systemFontOfSize:14];
    _contenLab.numberOfLines = 0;
    _contenLab.textColor = HEXCOLOR(0x272727);
    [self addSubview:_contenLab];
//    [_contenLab makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_timeLab.bottom).offset(8+11+16);
//        make.left.equalTo(_iconBtn.right).offset(10);
//        make.width.equalTo(SelfWidth-14-33-10-14);
//        make.height.equalTo(14);
//    }];
    
    self.lineView = [[UIView alloc] init];
    _lineView.backgroundColor = HEXCOLOR(0xf0f0f0);
    [self addSubview:_lineView];
    
}

- (void)likeBtnClick:(UIButton *)sender{
    if (self.likeBtnBlock) {
        self.likeBtnBlock(sender);
    }
}


@end
