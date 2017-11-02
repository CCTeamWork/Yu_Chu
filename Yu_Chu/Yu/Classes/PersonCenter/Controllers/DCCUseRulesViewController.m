//
//  DCCUseRulesViewController.m
//  Yu
//
//  Created by duanchongchong on 2017/11/2.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "DCCUseRulesViewController.h"
#import "XLZHHeader.h"

@interface DCCUseRulesViewController ()

@end

@implementation DCCUseRulesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initAllData];
    
    [self initAllSubviews];
}

- (void)initAllData{
    
}

- (void)initAllSubviews{
    self.view.backgroundColor = JQXXXLZHFFFFFFCLOLR;
    DCCBaseNavgationView *navV = [[DCCBaseNavgationView alloc] init];
    [navV setTitle:@"使用规则" andBackGroundColor:JQXXXLZHF4F4F4COLOR andTarget:self];
    [self.view addSubview:navV];
    UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(14, navV.frameMaxY, kScreenWidth-28, 35)];
    backV.userInteractionEnabled = YES;
    [self.view addSubview:backV];
    
    NSArray *contentArr = @[@"Q1:怎么获得红包?",@"1.新用户注册可以获得红包",@"2.推荐新用户下单可以获得红包",@"3.通过兑换码可以获得红包",@"Q2:红包如何使用?",@"使用红包需同时满足以下条件",@"(1).仅限在线支付使用",@"(2).每个订单只能使用一张红包"];
    CGFloat currentHeight = backV.frameMaxY+50;
    for (NSInteger i = 0; i < contentArr.count; i++) {
        UILabel *commonLab = [[UILabel alloc] init];
        commonLab.text = contentArr[i];
        commonLab.textColor = JQXXXLZH272727CLOLR;
        if (i == 0 || i == 4) {
            commonLab.frame = CGRectMake(47, currentHeight, kScreenWidth-47, 15);
            commonLab.font = [UIFont boldSystemFontOfSize:15];
        }else{
            commonLab.frame = CGRectMake(67, currentHeight, kScreenWidth-67, 15);
            commonLab.font = [UIFont systemFontOfSize:14];
        }
        [self.view addSubview:commonLab];
        currentHeight += 21;
        if (i == 3) {
            currentHeight += 27;
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
