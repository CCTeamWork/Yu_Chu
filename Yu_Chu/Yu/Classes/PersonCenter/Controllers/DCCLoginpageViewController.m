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
#import "UITextField+Extension.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface DCCLoginpageViewController (){
    
    NSTimer *_timer;
}

@end

@implementation DCCLoginpageViewController{
    UITextField *_phoneTF;
    UITextField *_verificationTF;
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
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_timer invalidate];

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
    phoneIMGV.image = [UIImage imageNamed:@"login_icon_Phone"];
    [self.view addSubview:phoneIMGV];
    
    _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(phoneIMGV.frameMaxX+20, navV.frameMaxY+34, kScreenWidth-150-14, 19)];
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTF.placeholder = @"请输入电话号码";
    _phoneTF.textColor = JQXXXLZH272727CLOLR;
    [_phoneTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    _phoneTF.tag = 1001;
    _phoneTF.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_phoneTF];
    
    _getNumBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-100, _phoneTF.frameOriginY, 100, 19)];
    [_getNumBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getNumBtn setTitleColor:JQXXXLZHFF2D4BCLOLR forState:UIControlStateNormal];
    _getNumBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [[_getNumBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         //获取验证码
         if (_phoneTF.text.length != 11) {
             [SVProgressHUD showErrorWithStatus:@"手机号码格式错误"];
             return ;
         }
         BOOL ret = [NSString validateMobile:_phoneTF.text];
         if (ret) {
             NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
             [dic setObject:_phoneTF.text forKey:@"mobile"];
             [[RequestManager sharedInstance]getVerificationWith:dic WhenComplete:^(BOOL succeed, id responseData, NSError *error) {
                 if (succeed) {
                     totalTime = 60;
                     [_timer setFireDate:[NSDate distantPast]];
                     [SVProgressHUD showSuccessWithStatus:@"发送成功"];
                     
                 }else{
                     [SVProgressHUD showErrorWithStatus:@"发送失败请重试"];
                 }
             }];
         }else{
             [SVProgressHUD showErrorWithStatus:@"手机号码格式错误"];
         }
        
     }];
    [self.view addSubview:_getNumBtn];
    
    UIView *veriticalLV = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth-100-1, _phoneTF.frameOriginY, 1.0, 19)];
    veriticalLV.backgroundColor = JQXXXLZHFAFAFACLOLR;
    [self.view addSubview:veriticalLV];
    
    UIView *underLV = [[UIView alloc] initWithFrame:CGRectMake(14, _getNumBtn.frameMaxY+9, kScreenWidth-28, 1.0)];
    underLV.backgroundColor = JQXXXLZHFAFAFACLOLR;
    [self.view addSubview:underLV];
    
    UIImageView *verificationCodeIMGV = [[UIImageView alloc] initWithFrame:CGRectMake(14, underLV.frameMaxY+25, 17, 17)];
    verificationCodeIMGV.image = [UIImage imageNamed:@"login_icon_key"];
    [self.view addSubview:verificationCodeIMGV];
    
    _verificationTF = [[UITextField alloc] initWithFrame:CGRectMake(phoneIMGV.frameMaxX+20, underLV.frameMaxY+22, kScreenWidth-150-14, 19)];
    _verificationTF.placeholder = @"请输入验证码";
    _verificationTF.textColor = JQXXXLZH272727CLOLR;
    _verificationTF.font = [UIFont systemFontOfSize:15];
    _verificationTF.tag = 1002;
    _verificationTF.keyboardType = UIKeyboardTypeNumberPad;
    [_verificationTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_verificationTF];
    
    UIView *underLV2 = [[UIView alloc] initWithFrame:CGRectMake(14, _verificationTF.frameMaxY+9, kScreenWidth-28, 1.0)];
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
         
         BOOL isOK = [self judgeIsOK];
         if (isOK) {
             [SVProgressHUD show];
             NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
             [dic setObject:_phoneTF.text forKey:@"mobile"];
             [dic setObject:_verificationTF.text forKey:@"validateCode"];
             [[RequestManager sharedInstance]loginAndGetToken:dic WhenComplete:^(BOOL succeed, id responseData, NSError *error) {
                 [SVProgressHUD dismiss];
                 if (succeed) {
                     kAppDelegate.token = [[responseData valueWithNilForKey:@"data"] valueWithNilForKey:@"token"];
                     [[NSUserDefaults standardUserDefaults] setObject:kAppDelegate.token forKey:@"dccLoginToken"];
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
                     if (self.callBackReturnLoginStatus) {
                         self.callBackReturnLoginStatus(isOK);
                     }
                     NSString *userTag = [[responseData valueWithNilForKey:@"data"] valueWithNilForKey:@"pushTag"];
                     [[NSUserDefaults standardUserDefaults] setObject:userTag forKey:@"userTag"];
                     NSSet *set = [[NSSet alloc] initWithObjects:userTag, nil];
                     [JPUSHService setTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                         if (iResCode == 0) {
                             NSLog(@"覆盖tag成功");
                         }
                     } seq:1];
                     [self dismissViewControllerAnimated:YES completion:nil];
                 }else{
                     [SVProgressHUD showErrorWithStatus:[responseData valueWithNilForKey:@"message"]];
                 }
             }];
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
- (BOOL)judgeIsOK{
    if (_phoneTF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"手机号码格式错误"];
        return NO;
    }
    if (!(_verificationTF.text.length == 6 || _verificationTF.text.length == 4)) {
        [SVProgressHUD showErrorWithStatus:@"验证码格式错误"];
        return NO;
    }
    
    return [NSString validateMobile:_phoneTF.text];;
}
- (void)textFieldChanged:(UITextField *)TF{

    if (TF.tag == 1001) {
        [TF LimitCharacterWithInteger:11];
    }
    if (TF.tag == 1002) {
        [TF LimitCharacterWithInteger:6];
    }
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
