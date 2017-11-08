//
//  DCCMyRedEnvelopeViewController.m
//  Yu
//
//  Created by duanchongchong on 2017/11/2.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "DCCMyRedEnvelopeViewController.h"
#import "XLZHHeader.h"
#import "DCCUseRulesViewController.h"
#import "DCCRedTableViewCell.h"
#import "DCCExchangeRedViewController.h"
#import "Masonry.h"



@interface DCCMyRedEnvelopeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_mainTableView;
}

@end

@implementation DCCMyRedEnvelopeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAllData];
    
    [self initAllSubviews];
}

- (void)initAllData{
    
}

- (void)initAllSubviews{
    self.view.backgroundColor = JQXXXLZHFFFFFFCLOLR;
    DCCBaseNavgationView *navV = [[DCCBaseNavgationView alloc] init];
    [navV setTitle:@"我的红包" andBackGroundColor:JQXXXLZHF4F4F4COLOR andTarget:self];
    [self.view addSubview:navV];
    
    UIButton *exchangeCouponBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-80, STATUS_BAR_HEIGHT, 66, 44)];
    [exchangeCouponBtn setTitle:@"兑换码" forState:UIControlStateNormal];
    [exchangeCouponBtn setTitleColor:JQXXXLZHFF2D4BCLOLR forState:UIControlStateNormal];
    exchangeCouponBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [[exchangeCouponBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(id x) {
         //点击兑换优惠券按钮
             DCCExchangeRedViewController *vc = [[DCCExchangeRedViewController alloc] init];
             [self secondPushToViewcontroller:vc];
     }];
    exchangeCouponBtn.contentHorizontalAlignment = 2;
    [navV addSubview:exchangeCouponBtn];
    
    UIButton *climpRulesBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-14-100, navV.frameMaxY, 100, 39)];
    [climpRulesBtn setTitleColor:JQXXXLZHB7B7B7CLOLR forState:UIControlStateNormal];
    [climpRulesBtn setTitle:@"使用规则" forState:UIControlStateNormal];
    climpRulesBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [climpRulesBtn setImage:[UIImage imageNamed:@"icon_question"] forState:UIControlStateNormal];
    climpRulesBtn.contentHorizontalAlignment = 2;
    climpRulesBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6);
    [[climpRulesBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(id x) {
         //跳转兑换规则页面
             DCCUseRulesViewController *vc = [[DCCUseRulesViewController alloc] init];
             [self secondPushToViewcontroller:vc];
     }];
    [self.view addSubview:climpRulesBtn];
    
    BOOL isHaveData = NO;
    if (!isHaveData) {
        //没有评价加载空白页面
        
        UIImageView *emptyIMGV = [[UIImageView alloc] init];
        emptyIMGV.image = [UIImage imageNamed:@"comment_image_none"];
        emptyIMGV.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:emptyIMGV];
        
        UILabel *emptyLab = [[UILabel alloc] init];
        emptyLab.text = @"暂无红包";
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
        CGFloat currentY = climpRulesBtn.frameMaxY;
        CGFloat height = kScreenHeight - currentY;
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, currentY, kScreenWidth, kScreenHeight-currentY) style:UITableViewStylePlain];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTableView];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
    }
    
}
#pragma mark UITableviewDelegate UITbaleviewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (kScreenWidth/375.0*100.0+10);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DCCRedTableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"redCell"];
    if (cell == nil) {
        cell = [[DCCRedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"redCell"];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isSelected) {
        if (self.callBackReturnRedModel) {
            self.callBackReturnRedModel();
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark 页面的出现和消失
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
