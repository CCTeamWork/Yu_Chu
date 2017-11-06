//
//  DCCIdeaFeedbackViewController.m
//  Yu
//
//  Created by duanchongchong on 2017/11/3.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "DCCIdeaFeedbackViewController.h"
#import "XLZHHeader.h"
#import "FSTextView.h"

@interface DCCIdeaFeedbackViewController (){
    FSTextView *_idearTV;
}

@end

@implementation DCCIdeaFeedbackViewController

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
    [navV setTitle:@"意见反馈" andBackGroundColor:JQXXXLZHF4F4F4COLOR andTarget:self];
    [self.view addSubview:navV];
    
    UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(14, navV.frameMaxY+18, kScreenWidth-28, 190)];
    backV.layer.borderColor = JQXXXLZHB7B7B7CLOLR.CGColor;
    backV.layer.borderWidth = 1.0;
    backV.layer.cornerRadius = 2.5;
    [self.view addSubview:backV];
    
    _idearTV = [[FSTextView alloc] initWithFrame:CGRectMake(8, 8, backV.frameSizeWidth-16, backV.frameSizeHeight-16)];
    _idearTV.placeholder = @"请填写您的意见和建议，我们会不断改进";
    _idearTV.placeholderFont = [UIFont systemFontOfSize:14];
    _idearTV.placeholderColor = JQXXXLZHB7B7B7CLOLR;
    [backV addSubview: _idearTV];
    
    UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(14, backV.frameMaxY+26, kScreenWidth-28, 36)];
    [commitBtn setBackgroundColor:JQXXXLZHFF2D4BCLOLR];
    [commitBtn setTitle:@"提交反馈" forState:UIControlStateNormal];
    [commitBtn setTitleColor:JQXXXLZHFFFFFFCLOLR forState:UIControlStateNormal];
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    commitBtn.contentHorizontalAlignment = 0;
    commitBtn.contentVerticalAlignment = 0;
    commitBtn.layer.cornerRadius = 2.5;
    [[commitBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         //提交登陆
         [self judgeIsEmptyAndCommiIdeaFeedback];
     }];
    [self.view addSubview:commitBtn];
}
- (void)judgeIsEmptyAndCommiIdeaFeedback{
    if (_idearTV.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"内容不能为空"];
        return;
    }
    [SVProgressHUD showSuccessWithStatus:@"感谢您的宝贝意见"];
    [self.navigationController popViewControllerAnimated:YES];
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
