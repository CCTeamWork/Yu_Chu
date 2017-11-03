//
//  MSUSellerView.m
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


#import "MSUSellerView.h"


#import "MSUPathTools.h"

#import "MSUSellerTableCell.h"

@interface MSUSellerView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) NSArray *imaArr;
@property (nonatomic , strong) NSArray *textArr;

@end

@implementation MSUSellerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.imaArr = @[@"shop_icon_time",@"shop_icon_phone",@"shop_icon_place"];
        self.textArr = @[@"营业时间：22：00 ~ 23：00",@"营业时间：22：00 ~ 23：00",@"解放东路迪凯银座"];
        [self createView];
        
    }
    return self;
}


- (void)createView{
    self.tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = HEXCOLOR(0xffffff);
    _tableView.scrollEnabled = YES;
    [self addSubview:_tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.panGestureRecognizer.delaysTouchesBegan = self.tableView.delaysContentTouches;
    _tableView.rowHeight = 50;
    [_tableView registerClass:[MSUSellerTableCell class] forCellReuseIdentifier:@"sellerCell"];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(150);
    }];

    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = HEXCOLOR(0xffffff);
    [self addSubview:bgView];
    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.bottom).offset(14);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(50);
    }];
    
    UILabel *attentionLab = [[UILabel alloc] init];
    attentionLab.text = @"查看适配安全档案";
    attentionLab.font = [UIFont systemFontOfSize:14];
    attentionLab.textColor = HEXCOLOR(0xb7b7b7b);
    [bgView addSubview:attentionLab];
    [attentionLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.top).offset(0);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(50);
    }];
    
    UIImageView *imaView = [[UIImageView alloc] init];
    imaView.image = [MSUPathTools showImageWithContentOfFileByName:@"index_icon_forward"];
    [bgView addSubview:imaView];
    [imaView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.top).offset(18);
        make.right.equalTo(self.right).offset(-14);
        make.width.equalTo(8);
        make.height.equalTo(14);
    }];
    
    UILabel *identyLab = [[UILabel alloc] init];
    identyLab.text = @"已验证";
    identyLab.textAlignment = NSTextAlignmentRight;
    identyLab.font = [UIFont systemFontOfSize:14];
    identyLab.textColor = HEXCOLOR(0x0ea76c);
    [self addSubview:identyLab];
    [identyLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.top).offset(18);
        make.right.equalTo(imaView.left).offset(-5);
        make.width.equalTo(50);
        make.height.equalTo(14);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MSUSellerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sellerCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.leftImaView.image = [MSUPathTools showImageWithContentOfFileByName:self.imaArr[indexPath.row]];
    cell.rightLab.text = self.textArr[indexPath.row];
    
    if (indexPath.row == 1) {
        cell.rightLab.textColor = HEXCOLOR(0x88abda);
    }
    
    return cell;
}


@end
