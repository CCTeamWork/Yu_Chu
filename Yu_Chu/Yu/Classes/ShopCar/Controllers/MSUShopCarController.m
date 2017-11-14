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
#import "DCCShopCarModel.h"
#import "MSUShopDetailController.h"

@interface MSUShopCarController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_mainTableview;
    DCCBaseNavgationView *navV;
    
    NSMutableArray <DCCShopCarModel *>*_dataSourceArr;
    
    UIImageView *emptyIMGV;
    UILabel *emptyLab;
    
}

@end

@implementation MSUShopCarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom]; //样式使用自定义
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];// 整个后面的背景选择
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];// 弹出框颜色
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];// 弹出框内容颜色
    
    [self initAllSubviews];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    BOOL isLogin = [kAppDelegate.token isEqualToString:@""];
    if (isLogin) {
        [self climpLoginPage];
        return;
    }
    [self initAllData];

}
- (void)initAllData{
    
    [SVProgressHUD show];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [[RequestManager sharedInstance]getSHopCarInfomation:dic WhenComplete:^(BOOL succeed, id responseData, NSError *error) {
            [SVProgressHUD dismiss];
        [_mainTableview.mj_header endRefreshing];
        if (succeed) {
            _dataSourceArr = [DCCShopCarModel mj_objectArrayWithKeyValuesArray:[responseData valueWithNilForKey:@"data"]];
            if (kAppDelegate.netStatus) {
                BOOL isHaveData = (_dataSourceArr.count!=0);
                self.NONetBtn.hidden = YES;
                if (!isHaveData) {
                    //没有评价加载空白页面
                    emptyIMGV.hidden = NO;
                    emptyLab.hidden = NO;
                    [_mainTableview reloadData];
                
                }else{
                    emptyIMGV.hidden = YES;
                    emptyLab.hidden = YES;
                    [_mainTableview reloadData];
                }
            }else{
                [self.view addSubview:self.NONetBtn];
                self.NONetBtn.hidden = NO;
                [self.NONetBtn addTarget:self action:@selector(initAllData) forControlEvents:UIControlEventTouchUpInside];
                
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
        }
    }];
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
    navV = [[DCCBaseNavgationView alloc] init];
    [navV redBackGroundSetTitle:@"购物车" andBackGroundColor:JQXXXLZHFF2D4BCLOLR andTarget:self];
    navV.backBtn.hidden = YES;
    [self.view addSubview:navV];
    
    //加载消息列表
    _mainTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, navV.frameMaxY, kScreenWidth, kScreenHeight-navV.frameMaxY) style:UITableViewStylePlain];
    _mainTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTableview.delegate = self;
    _mainTableview.dataSource = self;
    _mainTableview.backgroundColor = JQXXXLZHFAFAFACLOLR;
    _mainTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self initAllData];
    }];
    [self.view addSubview:_mainTableview];
    
    {
        //没有评价加载空白页面
        emptyIMGV = [[UIImageView alloc] init];
        emptyIMGV.image = [UIImage imageNamed:@"comment_image_none"];
        emptyIMGV.contentMode = UIViewContentModeScaleAspectFit;
        emptyIMGV.hidden = YES;
        [self.view addSubview:emptyIMGV];
        
        emptyLab = [[UILabel alloc] init];
        emptyLab.text = @"去添点什么吧";
        emptyLab.textColor = JQXXXLZH272727CLOLR;
        emptyLab.font = [UIFont systemFontOfSize:14];
        emptyLab.textAlignment = NSTextAlignmentCenter;
        emptyLab.hidden = YES;
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
        
    }
    
}
#pragma mark UITableviewDelegate UITbaleviewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSourceArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DCCShopCarModel *model = _dataSourceArr[indexPath.row];
    NSInteger arrCount = model.shopCars.count;
    return 163+80*arrCount+10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DCCShoppingCarTableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"shopCell"];
    if (cell == nil) {
        cell = [[DCCShoppingCarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shopCell"];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    [cell.removeBtn addTarget:self action:@selector(clickRemoveButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.removeBtn.tag = indexPath.row+2000;
    [cell.commitBtn addTarget:self action:@selector(clickConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.commitBtn.tag = indexPath.row+2000;
    DCCShopCarModel *model = _dataSourceArr[indexPath.row];
    [cell initAllData:model];
    cell.callBackClimpSale = ^{
        self.hidesBottomBarWhenPushed = YES;
        MSUShopDetailController *detail = [[MSUShopDetailController alloc] init];
        detail.shopID = model.shopId;
        [self.navigationController pushViewController:detail animated:YES];
        self.hidesBottomBarWhenPushed = NO;;
    };
    return cell;
}

- (void)clickConfirmButton:(UIButton *)sender{
    DCCShopCarModel *model = _dataSourceArr[sender.tag-2000];
    //结算按钮
    DCCConfirmOrderViewController *vc = [[DCCConfirmOrderViewController alloc] init];
    vc.shopId = model.shopId;
    vc.shopName = model.shopName;
    [self pushToViewcontroller:vc];
}
- (void)clickRemoveButton:(UIButton *)sender{
    DCCShopCarModel *model = _dataSourceArr[sender.tag-2000];
    //删除按钮
    [SVProgressHUD show];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:model.shopId forKey:@"shopId"];
    [[RequestManager sharedInstance]removeShopCarInfomation:dic WhenComplete:^(BOOL succeed, id responseData, NSError *error) {
        [SVProgressHUD dismiss];
        if (succeed) {
            [_dataSourceArr removeObjectAtIndex:sender.tag-2000];
            [_mainTableview reloadData];

            if (_dataSourceArr.count == 0) {
                //没有评价加载空白页面
                emptyIMGV.hidden = NO;
                emptyLab.hidden = NO;
                
            }
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:@"删除失败"];
        }
    }];
}
@end
