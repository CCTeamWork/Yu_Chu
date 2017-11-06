//
//  DCCLoginpageViewController.m
//  Yu
//
//  Created by duanchongchong on 2017/11/3.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "DCCLoginpageViewController.h"
#import "XLZHHeader.h"
#import "YYText.h"

@interface DCCLoginpageViewController (){
    
    NSTimer *_timer;
}

@end

@implementation DCCLoginpageViewController{
    UITextField *_phoneTF;
    UIButton *_getNumBtn;
    
    NSInteger totalTime;
}

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
    [navV loginSetTitle:@"登陆" andBackGroundColor:JQXXXLZHFF2D4BCLOLR andTarget:self];
    [[navV.backBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         if (self.callBackReturnLoginStatus) {
             self.callBackReturnLoginStatus(NO);
         }
         [self dismissViewControllerAnimated:YES completion:nil];
     }];
    [self.view addSubview:navV];
    
    UIImageView *phoneIMGV = [[UIImageView alloc] initWithFrame:CGRectMake(14, navV.frameMaxY+37, 17, 17)];
    phoneIMGV.image = [UIImage imageNamed:@""];
    [self.view addSubview:phoneIMGV];
    
    _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(phoneIMGV.frameMaxX+20, navV.frameMaxY+34, kScreenWidth-150-14, 19)];
    _phoneTF.placeholder = @"请输入电话号码";
    _phoneTF.textColor = JQXXXLZH272727CLOLR;
    _phoneTF.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_phoneTF];
    
    _getNumBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-100, _phoneTF.frameOriginY, 100, 19)];
    [_getNumBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getNumBtn setTitleColor:JQXXXLZHFF2D4BCLOLR forState:UIControlStateNormal];
    _getNumBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [[_getNumBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         //获取验证码
         totalTime = 60;
         [_timer setFireDate:[NSDate distantPast]];
     }];
    [self.view addSubview:_getNumBtn];
    
    UIView *veriticalLV = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth-100-1, _phoneTF.frameOriginY, 1.0, 19)];
    veriticalLV.backgroundColor = JQXXXLZHFAFAFACLOLR;
    [self.view addSubview:veriticalLV];
    
    UIView *underLV = [[UIView alloc] initWithFrame:CGRectMake(14, _getNumBtn.frameMaxY+9, kScreenWidth-28, 1.0)];
    underLV.backgroundColor = JQXXXLZHFAFAFACLOLR;
    [self.view addSubview:underLV];
    
    UIImageView *verificationCodeIMGV = [[UIImageView alloc] initWithFrame:CGRectMake(14, underLV.frameMaxY+25, 17, 17)];
    verificationCodeIMGV.image = [UIImage imageNamed:@""];
    [self.view addSubview:verificationCodeIMGV];
    
    _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(phoneIMGV.frameMaxX+20, underLV.frameMaxY+22, kScreenWidth-150-14, 19)];
    _phoneTF.placeholder = @"请输入验证码";
    _phoneTF.textColor = JQXXXLZH272727CLOLR;
    _phoneTF.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_phoneTF];
    
    UIView *underLV2 = [[UIView alloc] initWithFrame:CGRectMake(14, _phoneTF.frameMaxY+9, kScreenWidth-28, 1.0)];
    underLV2.backgroundColor = JQXXXLZHFAFAFACLOLR;
    [self.view addSubview:underLV2];
    
    NSString *contentS = @"温馨提示：未注册两岸御厨的手机号，登录时自动注册，且代表您已经同意《用户服务协议》";
    NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString: contentS];
    text.yy_lineSpacing = 5;
    text.yy_font = [UIFont systemFontOfSize:12];
    text.yy_color = JQXXXLZHD2D2D2CLOLR;
    __weak typeof(self) weakself = self;
    [text yy_setTextHighlightRange:[contentS rangeOfString:@"《用户服务协议》"] color:[UIColor colorWithHexString:@"0x22b4e1"] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"xxx协议被点击了");
        
    }];
    YYLabel *contentLab = [YYLabel new];
    contentLab.frame = CGRectMake(14, underLV2.frameMaxY+13, kScreenWidth-28, 35);
    contentLab.numberOfLines = 0;  //设置多行显示
    contentLab.preferredMaxLayoutWidth = kScreenWidth - 30; //设置最大的宽度
    contentLab.attributedText = text;
    [self.view addSubview:contentLab];
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(14, contentLab.frameMaxY+94, kScreenWidth-28, 36)];
    [loginBtn setBackgroundColor:JQXXXLZHFF2D4BCLOLR];
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [loginBtn setTitleColor:JQXXXLZHFFFFFFCLOLR forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    loginBtn.contentHorizontalAlignment = 0;
    loginBtn.contentVerticalAlignment = 0;
    loginBtn.layer.cornerRadius = 2.5;
    [[loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         //判定信息是否 正确，然后跳转并刷新
         BOOL isOK = YES;
         if (isOK) {
             kAppDelegate.token = @"newToken";
             if (self.callBackReturnLoginStatus) {
                 self.callBackReturnLoginStatus(isOK);
             }
             [self dismissViewControllerAnimated:YES completion:nil];
         }else{
             [SVProgressHUD showErrorWithStatus:@"信息填写错误"];
         }
     }];
    [self.view addSubview:loginBtn];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        _getNumBtn.enabled = NO;
        [_getNumBtn setTitleColor:JQXXXLZHD2D2D2CLOLR forState:UIControlStateNormal];
        [_getNumBtn setTitle:[NSString stringWithFormat:@"已发送(%lds)",totalTime] forState:UIControlStateNormal];
        totalTime--;
        if (totalTime == 0) {
            [_timer setFireDate:[NSDate distantFuture]];
            [_getNumBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [_getNumBtn setTitleColor:JQXXXLZHFF2D4BCLOLR forState:UIControlStateNormal];
            _getNumBtn.enabled = YES;
        }
    }];
    [_timer setFireDate:[NSDate distantFuture]];
    
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
