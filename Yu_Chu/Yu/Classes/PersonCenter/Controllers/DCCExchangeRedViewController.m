//
//  DCCExchangeRedViewController.m
//  Yu
//
//  Created by duanchongchong on 2017/11/2.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "DCCExchangeRedViewController.h"
#import "XLZHHeader.h"

@interface DCCExchangeRedViewController (){
    
    UITextField *_exchangeRedTF;
    
}

@end

@implementation DCCExchangeRedViewController

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
    [navV setTitle:@"兑换红包" andBackGroundColor:JQXXXLZHF4F4F4COLOR andTarget:self];
    [self.view addSubview:navV];
    
    UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(14, navV.frameMaxY+26, kScreenWidth-28, 35)];
    backV.layer.borderColor = JQXXXLZHB7B7B7CLOLR.CGColor;
    backV.layer.borderWidth = 1.0;
    backV.layer.cornerRadius = 2.5;
    backV.userInteractionEnabled = YES;
    [self.view addSubview:backV];
    
    _exchangeRedTF = [[UITextField alloc] initWithFrame:CGRectMake(13, 0, kScreenWidth-28, 35)];
    _exchangeRedTF.placeholder = @"请出入兑换码";
    _exchangeRedTF.keyboardType = UIKeyboardTypeEmailAddress;
    _exchangeRedTF.font = [UIFont systemFontOfSize:15];
    [backV addSubview:_exchangeRedTF];
    
    UIButton *okBtn = [[UIButton alloc] initWithFrame:CGRectMake(14, backV.frameMaxY+26, kScreenWidth-28, 36)];
    [okBtn setBackgroundColor:JQXXXLZHFF2D4BCLOLR];
    [okBtn setTitle:@"兑换" forState:UIControlStateNormal];
    [okBtn setTitleColor:JQXXXLZHFFFFFFCLOLR forState:UIControlStateNormal];
    okBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    okBtn.contentHorizontalAlignment = 0;
    okBtn.contentVerticalAlignment = 0;
    okBtn.layer.cornerRadius = 2.5;
    [[okBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(id x) {
             [self startExchangeRed];
     }];
    [self.view addSubview:okBtn];
}
- (void)startExchangeRed{
    if (_exchangeRedTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"兑换码不能为空"];
        return;
    }
    [SVProgressHUD show];
    double delayInSeconds = 2.0;
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, mainQueue, ^{
        NSLog(@"延时执行的2秒");
//        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"兑换码错误"];
        
    });
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
