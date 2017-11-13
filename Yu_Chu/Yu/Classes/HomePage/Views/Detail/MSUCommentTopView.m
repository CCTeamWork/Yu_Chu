//
//  MSUCommentTopView.m
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

#import "MSUCommentTopView.h"

@implementation MSUCommentTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = HEXCOLOR(0xffffff);
    [self addSubview:bgView];
    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(165.5);
    }];
    
    
    self.commentLab = [[UILabel alloc] init];
    _commentLab.font = [UIFont systemFontOfSize:22];
    _commentLab.textAlignment = NSTextAlignmentCenter;
    _commentLab.textColor = HEXCOLOR(0xff2d4b);
    [bgView addSubview:_commentLab];
    [_commentLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(23);
        make.left.equalTo(self.left).offset(28);
        make.width.equalTo(50);
        make.height.equalTo(22);
    }];
    
    UILabel *totalLab = [[UILabel alloc] init];
    totalLab.text = @"综合评价";
    totalLab.font = [UIFont systemFontOfSize:11];
    totalLab.textAlignment = NSTextAlignmentCenter;
    totalLab.textColor = HEXCOLOR(0x787878);
    [bgView addSubview:totalLab];
    [totalLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commentLab.bottom).offset(6);
        make.left.equalTo(self.left).offset(28);
        make.width.equalTo(50);
        make.height.equalTo(11);
    }];
    
    
    for (NSInteger i = 0; i < 5; i++) {
        UIImageView *imaView = [[UIImageView alloc] init];
        imaView.contentMode = UIViewContentModeScaleToFill;
        imaView.image = [MSUPathTools showImageWithContentOfFileByName:@"comment_icon_greystar"];
        imaView.highlightedImage = [MSUPathTools showImageWithContentOfFileByName:@"comment_icon_redstar"];
        [bgView addSubview:imaView];
        [imaView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.top).offset(31.5);
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
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = HEXCOLOR(0xf0f0f0);
    [bgView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(85);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(1);
    }];
    
    self.allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _allBtn.backgroundColor = HEXCOLOR(0x88abda);
    _allBtn.layer.cornerRadius = 2.5;
    _allBtn.clipsToBounds = YES;
    _allBtn.layer.shouldRasterize = YES;
    _allBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    NSString *allStr = [NSString stringWithFormat:@"全部评论(%@)",@"2"];
    CGSize sizeA = [MSUStringTools danamicGetWidthFromText:allStr WithFont:12];
    [_allBtn setTitle:allStr forState:UIControlStateNormal];
    [_allBtn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
    _allBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:_allBtn];
    [_allBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(14);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(sizeA.width+20);
        make.height.equalTo(29);
    }];
    //    [_allBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.dilisiousBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _dilisiousBtn.backgroundColor = HEXCOLOR(0xcfddf0);
    _dilisiousBtn.layer.cornerRadius = 2.5;
    _dilisiousBtn.clipsToBounds = YES;
    _dilisiousBtn.layer.shouldRasterize = YES;
    _dilisiousBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    NSString *diliStr = [NSString stringWithFormat:@"很好吃(%@)",@"1"];
    CGSize sizeB = [MSUStringTools danamicGetWidthFromText:diliStr WithFont:12];
    [_dilisiousBtn setTitle:allStr forState:UIControlStateNormal];
    [_dilisiousBtn setTitleColor:HEXCOLOR(0x88abda) forState:UIControlStateNormal];
    _dilisiousBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:_dilisiousBtn];
    [_dilisiousBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(14);
        make.left.equalTo(_allBtn.right).offset(10);
        make.width.equalTo(sizeB.width+20);
        make.height.equalTo(29);
    }];
    //    [_allBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendBtn.backgroundColor = HEXCOLOR(0xf6f8fc);
    _sendBtn.layer.cornerRadius = 2.5;
    _sendBtn.clipsToBounds = YES;
    _sendBtn.layer.shouldRasterize = YES;
    _sendBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    NSString *sendStr = [NSString stringWithFormat:@"送货慢(%@)",@"1"];
    CGSize sizeC = [MSUStringTools danamicGetWidthFromText:sendStr WithFont:12];
    [_sendBtn setTitle:allStr forState:UIControlStateNormal];
    [_sendBtn setTitleColor:HEXCOLOR(0x787878) forState:UIControlStateNormal];
    _sendBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:_sendBtn];
    [_sendBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom).offset(14);
        make.left.equalTo(_dilisiousBtn.right).offset(10);
        make.width.equalTo(sizeC.width+20);
        make.height.equalTo(29);
    }];
    //    [_allBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.oherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _oherBtn.backgroundColor = HEXCOLOR(0xb7b7b7);
    _oherBtn.layer.cornerRadius = 2.5;
    _oherBtn.clipsToBounds = YES;
    _oherBtn.layer.shouldRasterize = YES;
    _oherBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    NSString *otherStr = [NSString stringWithFormat:@"送货慢(%@)",@"1"];
    CGSize sizeD = [MSUStringTools danamicGetWidthFromText:otherStr WithFont:12];
    [_oherBtn setTitle:allStr forState:UIControlStateNormal];
    [_oherBtn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
    _oherBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:_oherBtn];
    [_oherBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dilisiousBtn.bottom).offset(8);
        make.left.equalTo(_allBtn.left).offset(0);
        make.width.equalTo(sizeD.width+20);
        make.height.equalTo(29);
    }];
    //    [_allBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma amrk - 初始化
- (NSMutableArray *)starArr{
    if (!_starArr) {
        self.starArr = [NSMutableArray array];
    }
    return _starArr;
}


@end
