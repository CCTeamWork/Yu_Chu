//
//  DCCMyIntegralViewController.m
//  Yu
//
//  Created by duanchongchong on 2017/11/3.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "DCCMyIntegralViewController.h"
#import "XLZHHeader.h"
#import "Masonry.h"

@interface DCCMyIntegralViewController ()

@end

@implementation DCCMyIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initAllData];
    
    [self initAllSubviews];
}

- (void)initAllData{
    
}

- (void)initAllSubviews{
    NSString *userNameString = @"御厨666888";
    NSString *myIntegralString = @"666888";
    
    self.view.backgroundColor = JQXXXLZHFFFFFFCLOLR;
    DCCBaseNavgationView *navV = [[DCCBaseNavgationView alloc] init];
    [navV setTitle:@"我的积分" andBackGroundColor:JQXXXLZHF4F4F4COLOR andTarget:self];
    [self.view addSubview:navV];
    
    UIImageView *logoIMGV = [[UIImageView alloc] initWithFrame:CGRectMake(14, navV.frameMaxY+13, 37, 37)];
    logoIMGV.image = [UIImage imageNamed:@"more_logo"];
    logoIMGV.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:logoIMGV];
    
    UILabel *userNameLab = [[UILabel alloc] init];
    userNameLab.text = userNameString;
    userNameLab.textColor = JQXXXLZH272727CLOLR;
    userNameLab.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:userNameLab];
    [userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(logoIMGV.mas_right).with.offset(12);
        make.centerY.equalTo(logoIMGV.mas_centerY).with.offset(0);
    }];
    
    UILabel *integralLab = [[UILabel alloc] init];
    integralLab.text = myIntegralString;
    integralLab.textColor = JQXXXLZHFF2D4BCLOLR;
    integralLab.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:integralLab];
    
    UIImageView *integralIMGV = [[UIImageView alloc] init];
    integralIMGV.image = [UIImage imageNamed:@"mine_icon_integral"];
    integralIMGV.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:integralIMGV];
    
    [integralLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).with.offset(-14);
        make.centerY.equalTo(logoIMGV.mas_centerY).with.offset(0);
    }];
    
    [integralIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(integralLab.mas_left).with.offset(-5);
        make.centerY.equalTo(logoIMGV.mas_centerY).with.offset(0);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    
    UIView *underLV = [[UIView alloc] initWithFrame:CGRectMake(14, navV.frameMaxY+67, kScreenWidth-28, 1.0)];
    underLV.backgroundColor = JQXXXLZHFAFAFACLOLR;
    [self.view addSubview:underLV];
    
    NSArray *contentArr = @[@"Q 如何获得积分?",@"A 消费获得积分，每消费一笔，实付1元 = 10积分",@"Q 积分有什么用?",@"积分兑换尚未开启，一道博惊喜正在路上"];
    CGFloat currentHeight = underLV.frameMaxY+17;
    for (NSInteger i = 0; i < contentArr.count; i++) {
        UILabel *commonLab = [[UILabel alloc] init];
        commonLab.text = contentArr[i];
        commonLab.textColor = JQXXXLZH272727CLOLR;
        commonLab.frame = CGRectMake(14, currentHeight, kScreenWidth-28, 15);
        if (i == 0 || i == 2) {
            commonLab.font = [UIFont boldSystemFontOfSize:14];
        }else{
            commonLab.font = [UIFont systemFontOfSize:13];
        }
        [self.view addSubview:commonLab];
        currentHeight += 21;
        if (i == 1) {
            currentHeight += 20;
        }
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
