//
//  MSUOrderStatusController.m
//  Yu
//
//  Created by 何龙飞 on 2017/11/6.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUOrderStatusController.h"
#import "MSUOrderCancelController.h"

#import "MSUHomeNavView.h"
#import "MSUPrefixHeader.pch"
#import "MSUPathTools.h"

#import "MSUDeatailTableCell.h"

@interface MSUOrderStatusController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;

@end

@implementation MSUOrderStatusController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = REDCOLOR;
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:12];
    [self.view addSubview:nav];
    [nav.backArrowBtn addTarget:self action:@selector(backArrowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
 
    [self createTopView];
}

- (void)createTopView{
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 64, WIDTH, HEIGHT-64);
    bgView.backgroundColor = HEXCOLOR(0xffffff);
    [self.view addSubview:bgView];
    
    UIButton *sellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sellBtn.layer.cornerRadius = 65*0.5;
    sellBtn.clipsToBounds = YES;
    sellBtn.layer.shouldRasterize = YES;
    sellBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    sellBtn.backgroundColor = [UIColor brownColor];
    //    [sellBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@""] forState:UIControlStateNormal];
    [self.view addSubview:sellBtn];
    [sellBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(42);
        make.left.equalTo(self.view.left).offset(WIDTH*0.5-65*0.5);
        make.width.equalTo(65);
        make.height.equalTo(65);
    }];
    //    [sellBtn addTarget:self action:@selector(iconBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *stutasLab = [[UILabel alloc] init];
    stutasLab.text = @"美食配送中 >";
    stutasLab.font = [UIFont systemFontOfSize:18];
    stutasLab.textAlignment = NSTextAlignmentCenter;
    stutasLab.textColor = HEXCOLOR(0x272727);
    [self.view addSubview:stutasLab];
    [stutasLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sellBtn.bottom).offset(12);
        make.centerX.equalTo(sellBtn.centerX).offset(0);
        make.width.equalTo(WIDTH);
        make.height.equalTo(18);
    }];
    
    UILabel *detailLab = [[UILabel alloc] init];
    detailLab.text = @"美食正在配送中，请耐心等待哦~";
    detailLab.font = [UIFont systemFontOfSize:14];
    detailLab.textAlignment = NSTextAlignmentCenter;
    detailLab.textColor = HEXCOLOR(0xb7b7b7);
    [self.view addSubview:detailLab];
    [detailLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(stutasLab.bottom).offset(12);
        make.centerX.equalTo(sellBtn.centerX).offset(0);
        make.width.equalTo(WIDTH);
        make.height.equalTo(14);
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.layer.cornerRadius = 2.5;
    cancelBtn.clipsToBounds = YES;
    cancelBtn.layer.shouldRasterize = YES;
    cancelBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    cancelBtn.layer.borderWidth = 1;
    cancelBtn.layer.borderColor = HEXCOLOR(0xff2d4b).CGColor;
    [cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:HEXCOLOR(0xff2d4b) forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:cancelBtn];
    [cancelBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(detailLab.bottom).offset(18);
        make.centerX.equalTo(detailLab.centerX).offset(0);
        make.width.equalTo(85);
        make.height.equalTo(29);
    }];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = HEXCOLOR(0xffffff);
    _tableView.scrollEnabled = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.panGestureRecognizer.delaysTouchesBegan = self.tableView.delaysContentTouches;
    _tableView.rowHeight = 60;
    [_tableView registerClass:[MSUDeatailTableCell class] forCellReuseIdentifier:@"detailCell"];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cancelBtn.bottom).offset(56);
        make.left.equalTo(self.view.left).offset(0);
        make.width.equalTo(WIDTH);
        make.height.equalTo(HEIGHT-20-42-65-12-18-16-14-29-56);
    }];


}


#pragma -点击
- (void)cancelBtnClick:(UIButton *)sender{
    self.hidesBottomBarWhenPushed = YES;
    MSUOrderCancelController *cancel = [[MSUOrderCancelController alloc] init];
    [self.navigationController pushViewController:cancel animated:YES];
}

- (void)backArrowBtnClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma - 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MSUDeatailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 0, WIDTH, 50);
    bgView.backgroundColor = HEXCOLOR(0xffffff);
    
    UIButton *iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    iconBtn.backgroundColor = [UIColor brownColor];
    iconBtn.layer.cornerRadius = 35*0.5;
    iconBtn.clipsToBounds = YES;
    iconBtn.layer.shouldRasterize = YES;
    iconBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [iconBtn setImage:[MSUPathTools showImageWithContentOfFileByName:@""] forState:UIControlStateNormal];
    [bgView addSubview:iconBtn];
    [iconBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.top).offset(0);
        make.left.equalTo(bgView.left).offset(14);
        make.width.equalTo(35);
        make.height.equalTo(35);
    }];
    
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.text = @"暂两岸咖啡";
    nameLab.font = [UIFont systemFontOfSize:14];
    nameLab.textColor = HEXCOLOR(0x272727);
    [bgView addSubview:nameLab];
    [nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(iconBtn.centerY).offset(0);
        make.left.equalTo(iconBtn.right).offset(15);
        make.width.equalTo(WIDTH-35-14-14-30);
        make.height.equalTo(14);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, 49, WIDTH, 1);
    lineView.backgroundColor = HEXCOLOR(0xf0f0f0);
    [bgView addSubview:lineView];
    
    UIImageView *imaView = [[UIImageView alloc] init];
    imaView.contentMode = UIViewContentModeScaleAspectFit;
    imaView.image = [MSUPathTools showImageWithContentOfFileByName:@"index_icon_forward"];
    [bgView addSubview:imaView];
    [imaView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(iconBtn.centerY).offset(0);
        make.right.equalTo(bgView.right).offset(-14);
        make.width.equalTo(13);
        make.height.equalTo(13);
    }];

    return bgView;
}

@end
