//
//  MSUShopCarView.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/3.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUShopCarView.h"

//masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#import "MSUStringTools.h"
#import "MSUCarTableCell.h"

#define SelfContentWidth self.contentView.frame.size.width
#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight [UIScreen mainScreen].bounds.size.height

#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MSUShopCarView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MSUShopCarView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
    }
    return self;
}


- (void)createView{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = HEXCOLOR(0xb7b7b7);
    [self addSubview:bgView];
    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(35);
    }];
    
    self.numLab = [[UILabel alloc] init];
    _numLab.font = [UIFont systemFontOfSize:13];
    NSString *text = [NSString stringWithFormat:@"购物车 (共%@件)",@"3"];
    _numLab.attributedText = [MSUStringTools makeKeyWordAttributedWithSubText:@"购物车" inOrigiText:text font:14 color:HEXCOLOR(0x787878)];
    _numLab.textColor = HEXCOLOR(0x787878);
    [bgView addSubview:_numLab];
    [_numLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.top).offset(0);
        make.left.equalTo(self.left).offset(14);
        make.width.equalTo(SelfWidth*0.5);
        make.height.equalTo(35);
    }];
    
    self.clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_clearBtn setTitle:@"清空" forState:UIControlStateNormal];
    [_clearBtn setTitleColor:HEXCOLOR(0x787878) forState:UIControlStateNormal];
    _clearBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [bgView addSubview:_clearBtn];
    [_clearBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.top).offset(0);
        make.right.equalTo(self.right).offset(-14);
        make.width.equalTo(40);
        make.height.equalTo(35);
    }];
//    [_clearBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = HEXCOLOR(0xffffff);
    _tableView.scrollEnabled = YES;
    [self addSubview:_tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.panGestureRecognizer.delaysTouchesBegan = self.tableView.delaysContentTouches;
    _tableView.rowHeight = 60;
    [_tableView registerClass:[MSUCarTableCell class] forCellReuseIdentifier:@"carCell"];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(35);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(SelfWidth);
        make.height.equalTo(60);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MSUCarTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"carCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}



@end
