//
//  MSUShopCarController.m
//  Yu
//
//  Created by 何龙飞 on 2017/10/31.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUShopCarController.h"
#import "XLZHHeader.h"
#import "DCCShoppingCarTableViewCell.h"
#import "Masonry.h"
#import "DCCConfirmOrderViewController.h"
#import "DCCLoginpageViewController.h"

@interface MSUShopCarController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_mainTableview;
}

@end

@implementation MSUShopCarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initAllData];
    
    [self initAllSubviews];
    
    [[NotificationCenter rac_addObserverForName:@"outLogin" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        [self initAllData];
    }];
    [[NotificationCenter rac_addObserverForName:@"loginSuccess" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        [self initAllData];
    }];
}

- (void)initAllData{
    BOOL isLogin = [kAppDelegate.token isEqualToString:@""];
    if (!isLogin) {
        [self climpLoginPage];
    }
}
- (void)climpLoginPage{
    
    DCCLoginpageViewController *vc = [[DCCLoginpageViewController alloc] init];
    vc.callBackReturnLoginStatus = ^(BOOL _isLogin) {
        if (_isLogin) {
            [self initAllData];
        }else{
            kAppDelegate.mainTabBar.selectedIndex = 0;
        }
    };
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)initAllSubviews{
    self.view.backgroundColor = JQXXXLZHFFFFFFCLOLR;
    DCCBaseNavgationView *navV = [[DCCBaseNavgationView alloc] init];
    [navV redBackGroundSetTitle:@"购物车" andBackGroundColor:JQXXXLZHFF2D4BCLOLR andTarget:self];
    navV.backBtn.hidden = YES;
    [self.view addSubview:navV];
    
    BOOL isHaveData = YES;
    if (!isHaveData) {
        //没有评价加载空白页面
        
        UIImageView *emptyIMGV = [[UIImageView alloc] init];
        emptyIMGV.image = [UIImage imageNamed:@"comment_image_none"];
        emptyIMGV.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:emptyIMGV];
        
        UILabel *emptyLab = [[UILabel alloc] init];
        emptyLab.text = @"去添点什么吧";
        emptyLab.textColor = JQXXXLZH272727CLOLR;
        emptyLab.font = [UIFont systemFontOfSize:14];
        emptyLab.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:emptyLab];
        
        [emptyIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(navV.mas_bottom).with.offset(87);
            make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
            make.width.mas_equalTo(112);
            make.height.mas_equalTo(112);
        }];
        
        [emptyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(emptyIMGV.mas_bottom).with.offset(20);
            make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        }];
        
        
    }else{
        //加载消息列表
        _mainTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, navV.frameMaxY, kScreenWidth, kScreenHeight-navV.frameMaxY) style:UITableViewStylePlain];
        _mainTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableview.delegate = self;
        _mainTableview.dataSource = self;
        _mainTableview.backgroundColor = JQXXXLZHFAFAFACLOLR;
        [self.view addSubview:_mainTableview];
    }
    
}
#pragma mark UITableviewDelegate UITbaleviewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 163+160+10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DCCShoppingCarTableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"shopCell"];
    if (cell == nil) {
        cell = [[DCCShoppingCarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shopCell"];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    [cell.removeBtn addTarget:self action:@selector(clickRemoveButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.removeBtn.tag = indexPath.row;
    [cell.commitBtn addTarget:self action:@selector(clickConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)clickConfirmButton{
    //结算按钮
    DCCConfirmOrderViewController *vc = [[DCCConfirmOrderViewController alloc] init];
    [self pushToViewcontroller:vc];
}
- (void)clickRemoveButton:(UIButton *)sender{
    //删除按钮
    
}
@end
