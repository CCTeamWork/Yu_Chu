//
//  MSUPersonCenterController.m
//  Yu
//
//  Created by DCC on 2017/10/31.
//  Copyright © 2017年 DCC. All rights reserved.
//

#import "MSUPersonCenterController.h"
#import "XLZHHeader.h"
#import "UIButton+vertical.h"
#import "DCCMyRedEnvelopeViewController.h"
#import "DCCMoreViewController.h"
#import "DCCIdeaFeedbackViewController.h"
#import "DCCMyIntegralViewController.h"
#import "DCCMyEvaluateViewController.h"
#import "DCCMessageViewController.h"
#import "DCCLocationViewController.h"
#import "DCCLoginpageViewController.h"
#import "UITextField+Extension.h"
#import "DCCUserInfomationModel.h"

@interface MSUPersonCenterController (){
    BOOL _isLoadView;//标识是否加载过控件

    UIImageView *_headIMGV;
    UILabel *_userNameLab;//用户姓名
    UIButton *_editNameBtn;//修改姓名按钮
    UIButton *_personalIntegralBtn;//显示用户积分
    UIView *_topBackView;
    UIScrollView *_mainSV;
    UIView *_modifyPage;
    UITextField *_editNameTF;
    
    UIButton *_noLoginBtn;
    
    BOOL _isLogin;
    
    DCCUserInfomationModel *_currentModel;
    
    NSInteger _refreshCount;
}


@end

@implementation MSUPersonCenterController



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

- (void)initAllData{
    //请求数据
    _isLogin = ![kAppDelegate.token isEqualToString:@""];
    if (_isLogin) {
        if (_noLoginBtn) {
            _noLoginBtn.hidden = YES;
        }
        [SVProgressHUD show];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [[RequestManager sharedInstance]getUserInfomation:dic WhenComplete:^(BOOL succeed, id responseData, NSError *error) {
            [SVProgressHUD dismiss];
            if (succeed) {
            _currentModel = [DCCUserInfomationModel mj_objectWithKeyValues:[responseData valueWithNilForKey:@"data"]];
                if (_isLoadView) {
                    [self setRequestDataToSubviews];
                    return;
                }
                [self loadHaveDataBackView];
            }else{
                [SVProgressHUD showErrorWithStatus:[responseData valueWithNilForKey:@"message"]];
            }
        }];
    }else{
        if (_isLoadView) {
            _personalIntegralBtn.hidden = YES;
            _editNameBtn.hidden = YES;
            _userNameLab.hidden = YES;
            _headIMGV.hidden = YES;
        }
        if (_noLoginBtn) {
            _noLoginBtn.hidden = NO;
            return;
        }
        _noLoginBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, _topBackView.frameSizeHeight/2-15, 100, 30)];
        [_noLoginBtn setTitle:@"登陆／注册" forState:UIControlStateNormal];
        [_noLoginBtn setTitleColor:JQXXXLZHFFFFFFCLOLR forState:UIControlStateNormal];
        _noLoginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _noLoginBtn.contentHorizontalAlignment = 0;
        _noLoginBtn.contentVerticalAlignment = 0;
        _noLoginBtn.layer.cornerRadius = 15.0;
        _noLoginBtn.layer.borderColor = JQXXXLZHFFFFFFCLOLR.CGColor;
        _noLoginBtn.layer.borderWidth = 1.5;
        _noLoginBtn.clipsToBounds = YES;
        _noLoginBtn.hidden = NO;
        [[_noLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(__kindof UIControl * _Nullable x) {
             [self climpLoginPage];
         }];
        [_topBackView addSubview:_noLoginBtn];
        
    }
    
}
- (void)initAllSubviews{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _mainSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-(IS_IPHONE_X?84:50))];
    _mainSV.backgroundColor = JQXXXLZHF4F4F4COLOR;
    _mainSV.showsVerticalScrollIndicator = NO;
    _mainSV.showsHorizontalScrollIndicator = NO;
    _mainSV.userInteractionEnabled = YES;
    _mainSV.bounces = NO;
    [self.view addSubview:_mainSV];
    
    _topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 181+(IS_IPHONE_X?24:0))];
    _topBackView.userInteractionEnabled = YES;
    _topBackView.backgroundColor = JQXXXLZHFF2D4BCLOLR;
    [_mainSV addSubview:_topBackView];
    
    [self loadTopBackView];
}
- (void)loadTopBackView{
    //右侧进入消息页面按钮
    UIButton *messageBtn = [[UIButton alloc] initWithFrame:CGRectMake(_topBackView.frameMaxX-14-20, 30+(IS_IPHONE_X?24:0), 20, 20)];
    [messageBtn setImage:[UIImage imageNamed:@"mine_icon_message"] forState:UIControlStateNormal];
    [[messageBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x ){
        //点击按钮进入消息页面
        DCCMessageViewController *vc = [[DCCMessageViewController alloc] init];
        vc.view.backgroundColor = JQXXXLZHFFFFFFCLOLR;
        [self pushToViewcontroller:vc];
    }];
    [_topBackView addSubview:messageBtn];
    
    //红包 收货地址等
    NSArray *titleArr = @[@"我的红包",@"收货地址",@"我的评价",@"我的积分",@"意见反馈",@"更多"];
    NSArray *imgArr = @[@"icon_redbag",@"icon_address",@"icon_comment",@"icon_point",@"icon_feedback",@"icon_more"];
    CGFloat currentHeight = _topBackView.frameMaxY;
    for (NSInteger i=0; i<titleArr.count; i++) {
        UIView *cellV = [[UIView alloc] initWithFrame:CGRectMake(0, currentHeight, _mainSV.frameSizeWidth, 45)];
        cellV.backgroundColor = JQXXXLZHFFFFFFCLOLR;
        cellV.userInteractionEnabled = YES;
        [_mainSV addSubview:cellV];
        
        UIButton *recordBtn = [[UIButton alloc] initWithFrame:CGRectMake(14, 0, cellV.frameSizeWidth-14, 45)];
        [recordBtn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [recordBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [recordBtn setTitleColor:JQXXXLZH272727CLOLR forState:UIControlStateNormal];
        recordBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [[recordBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(id x) {
             UIButton *clickBtn = x;
             [self climpOtherPage:clickBtn.tag];
         }];
        recordBtn.tag = 1000+i;
        [recordBtn horizontalImageAndTitle:11];
        recordBtn.contentHorizontalAlignment = 1;
        [cellV addSubview:recordBtn];
        
        UIImageView *rightIMGV = [[UIImageView alloc] initWithFrame:CGRectMake(recordBtn.frameSizeWidth-14-14, 15, 14, 14)];
        rightIMGV.image = [UIImage imageNamed:@"icon_forward"];
        [recordBtn addSubview:rightIMGV];
        
        if (i == 0 || i == 2 || i == 3) {
            UIView *underLineV = [[UIView alloc] initWithFrame:CGRectMake(14, 44, cellV.frameSizeWidth, 1)];
            underLineV.backgroundColor = JQXXXLZHFAFAFACLOLR;
            [cellV addSubview:underLineV];
        }
        currentHeight += cellV.frameSizeHeight;
        if (i == 1 || i == 4) {
            currentHeight += 10;
        }
    }
    _mainSV.contentSize = CGSizeMake(kScreenWidth, currentHeight);
}
- (void)loadHaveDataBackView{
    NSString *userNameString = _currentModel.name;
    NSString *integralString = @"平民";
    _isLoadView = YES;
    CGFloat headIMGWidth = 53.0;
    _headIMGV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2.0-headIMGWidth/2.0, 45+(IS_IPHONE_X?24:0), headIMGWidth, headIMGWidth)];
    _headIMGV.image = [UIImage imageNamed:@"mine_integral_image_head"];
    _headIMGV.layer.cornerRadius = headIMGWidth/2.0;
    _headIMGV.clipsToBounds = YES;
    [_topBackView addSubview:_headIMGV];
    
    CGFloat nameWidth = [NSString calculateRowWidth:userNameString andFont:14 andHeight:15];
    CGFloat totalWidth = nameWidth+8+16;
    _userNameLab = [[UILabel alloc] initWithFrame:CGRectMake((_topBackView.frameSizeWidth-totalWidth)/2.0, _headIMGV.frameMaxY+13, nameWidth, 16)];
    _userNameLab.text = userNameString;
    _userNameLab.textColor = JQXXXLZHFFFFFFCLOLR;
    _userNameLab.font = [UIFont systemFontOfSize:14];
    [_userNameLab sizeToFit];
    [_topBackView addSubview:_userNameLab];
    
    _editNameBtn = [[UIButton alloc] initWithFrame:CGRectMake(_userNameLab.frameMaxX+8, _userNameLab.frameOriginY, 16, 16)];
    [_editNameBtn setImage:[UIImage imageNamed:@"mine_icon_edit"] forState:UIControlStateNormal];
    [[_editNameBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x ){
        //点击按钮进入或者弹出修改名字页面
        [self showModifyUserNamePage];
    }];
    _editNameBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _editNameBtn.imageView.clipsToBounds = YES;
    [_topBackView addSubview:_editNameBtn];
    
    _personalIntegralBtn = [[UIButton alloc] initWithFrame:CGRectMake(14, _editNameBtn.frameMaxY+13, _topBackView.frameSizeWidth-28, 16)];
    [_personalIntegralBtn setImage:[UIImage imageNamed:@"mine_icon_grade"] forState:UIControlStateNormal];
    [_personalIntegralBtn setTitle:integralString forState:UIControlStateNormal];
    [_personalIntegralBtn setTitleColor:JQXXXLZHFFFFFFCLOLR forState:UIControlStateNormal];
    _personalIntegralBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _personalIntegralBtn.enabled = NO;
    [_personalIntegralBtn horizontalImageAndTitle:4.0];
    [_topBackView addSubview:_personalIntegralBtn];
}
- (void)setRequestDataToSubviews{
    _personalIntegralBtn.hidden = NO;
    _editNameBtn.hidden = NO;
    _userNameLab.hidden = NO;
    _headIMGV.hidden = NO;
    NSString *userNameString = _currentModel.name;
    NSString *integralString = @"平民";
    _userNameLab.text = userNameString;
    [_personalIntegralBtn setTitle:integralString forState:UIControlStateNormal];
}
#pragma mark ClimpOtherPage14Ω
- (void)climpOtherPage:(NSInteger)index{
    switch (index) {
        case 1000:{
            //跳转到我的红包页面
            DCCMyRedEnvelopeViewController *vc = [[DCCMyRedEnvelopeViewController alloc] init];
            [self pushToViewcontroller:vc];
            break;
        }
        case 1001:{
            //跳转到收获地址页面
            DCCLocationViewController *vc = [[DCCLocationViewController alloc] init];
            [self pushToViewcontroller:vc];
            break;
        }
        case 1002:{
            //跳转到我的评价
            DCCMyEvaluateViewController *vc = [[DCCMyEvaluateViewController alloc] init];
            vc.userName = _currentModel.name;
            [self pushToViewcontroller:vc];
            break;
        }
        case 1003:{
            //跳转到我的积分
            DCCMyIntegralViewController *vc = [[DCCMyIntegralViewController alloc] init];
            vc.userName = _currentModel.name;
            vc.integral = _currentModel.bonusPointsBalance;
            [self pushToViewcontroller:vc];
            break;
        }
        case 1004:{
            //跳转到意见反馈页面
            DCCIdeaFeedbackViewController *vc = [[DCCIdeaFeedbackViewController alloc] init];
            [self pushToViewcontroller:vc];
            break;
        }
        case 1005:{
            //跳转到更多页面
            DCCMoreViewController *vc = [[DCCMoreViewController alloc] init];
            [self pushToViewcontroller:vc];
            break;
        }
        default:
            break;
    }
}
-(void)pushToViewcontroller:(UIViewController *)vc{
    if (_isLogin) {
        [super pushToViewcontroller:vc];
    }else{
        [self climpLoginPage];
    }
    
}
- (void)climpLoginPage{
    
    DCCLoginpageViewController *vc = [[DCCLoginpageViewController alloc] init];
    vc.callBackReturnLoginStatus = ^(BOOL _isLogin) {
        if (_isLogin) {
            _noLoginBtn.hidden = YES;
//            [self initAllData];
        }
    };
    [self presentViewController:vc animated:YES completion:nil];
}
#pragma mark LoadModifyUserNamePage

- (void)showModifyUserNamePage{
    if (!_modifyPage) {
        _modifyPage = [[UIView alloc] initWithFrame:self.view.bounds];
        _modifyPage.frameOriginY += kScreenHeight;
        _modifyPage.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        _modifyPage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelEditUserName:)];
        [_modifyPage addGestureRecognizer:tapGes];
        [kAppWindow addSubview:_modifyPage];
        
        UIView *contentV = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2-115, kScreenHeight/2-70-60, 230, 140)];
        contentV.backgroundColor = JQXXXLZHFFFFFFCLOLR;
        contentV.userInteractionEnabled = YES;
        contentV.layer.cornerRadius = 5.0;
        [_modifyPage addSubview:contentV];
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(14, 9, contentV.frameSizeWidth-28, 16)];
        titleLab.text = @"修改昵称";
        titleLab.textColor = JQXXXLZH272727CLOLR;
        titleLab.font = [UIFont boldSystemFontOfSize:15];
        titleLab.textAlignment = NSTextAlignmentCenter;
        [contentV addSubview:titleLab];
        
        _editNameTF = [[UITextField alloc] initWithFrame:CGRectMake(30, 50, contentV.frameSizeWidth-60, 22)];
        _editNameTF.placeholder = @"请输入昵称";
        _editNameTF.textColor = JQXXXLZH272727CLOLR;
        _editNameTF.font = [UIFont systemFontOfSize:14];
        [_editNameTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        [contentV addSubview:_editNameTF];
        
        UIView *underLV = [[UIView alloc] initWithFrame:CGRectMake(14, _editNameTF.frameMaxY +16, contentV.frameSizeWidth-28, 1.0)];
        underLV.backgroundColor = JQXXXLZHFAFAFACLOLR;
        [contentV addSubview:underLV];
        
        UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(contentV.frameSizeWidth/2-76.5, underLV.frameMaxY+12, 60, 32)];
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancleBtn setTitleColor:JQXXXLZHFFFFFFCLOLR forState:UIControlStateNormal];
        cancleBtn.contentHorizontalAlignment = 0;
        cancleBtn.contentVerticalAlignment = 0;
        [cancleBtn setBackgroundColor:JQXXXLZHB7B7B7CLOLR];
        cancleBtn.layer.cornerRadius = 16;
        cancleBtn.clipsToBounds = YES;
        [cancleBtn addTarget:self action:@selector(cancleOrModifyUserName:) forControlEvents:UIControlEventTouchUpInside];
        cancleBtn.tag = 30001;
        [contentV addSubview:cancleBtn];
        
        UIButton *okBtn = [[UIButton alloc] initWithFrame:CGRectMake(cancleBtn.frameMaxX+33, underLV.frameMaxY+12, 60, 32)];
        [okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [okBtn setTitleColor:JQXXXLZHFFFFFFCLOLR forState:UIControlStateNormal];
        okBtn.contentHorizontalAlignment = 0;
        okBtn.contentVerticalAlignment = 0;
        [okBtn setBackgroundColor:JQXXXLZHFF2D4BCLOLR];
        okBtn.layer.cornerRadius = 16;
        okBtn.clipsToBounds = YES;
        [okBtn addTarget:self action:@selector(cancleOrModifyUserName:) forControlEvents:UIControlEventTouchUpInside];
        okBtn.tag = 30002;
        [contentV addSubview:okBtn];
    }
    if ( _userNameLab.text.length != 0) {
        _editNameTF.text = _userNameLab.text;
    }
    [UIView animateWithDuration:0.5 animations:^{
        _modifyPage.frameOriginY = 0;
    } completion:^(BOOL finished) {
        [_editNameTF becomeFirstResponder];
    }];
}
- (void)cancleOrModifyUserName:(UIButton *)sender{
    if (sender.tag == 30001) {
        //直接取消
    }else{
        //确定要修改
        if (_editNameTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"昵称不能为空"];
            return;
        }
        NSMutableDictionary *dic= [[NSMutableDictionary alloc] init];
        [dic setObject:_editNameTF.text forKey:@"name"];
        [SVProgressHUD show];
        [[RequestManager sharedInstance]modifyUserInfomation:dic WhenComplete:^(BOOL succeed, id responseData, NSError *error) {
            if (succeed) {
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                CGFloat nameWidth = [NSString calculateRowWidth:_editNameTF.text andFont:14 andHeight:15];
                CGFloat totalWidth = nameWidth+8+16;
                _userNameLab.frameOriginX = (_topBackView.frameSizeWidth-totalWidth)/2.0;
                _userNameLab.frameSizeWidth = nameWidth;
                _userNameLab.text = _editNameTF.text;
                _editNameBtn.frameOriginX = _userNameLab.frameMaxX+8;
                _currentModel.name = _editNameTF.text;
            }else{
                [SVProgressHUD showErrorWithStatus:@"修改失败"];
            }
        }];
        
    }
    [self cancelEditUserName:nil];
}
- (void)textFieldChanged:(UITextField *)TF{
    TF.text = [self disable_emoji:TF.text];
    [TF LimitCharacterWithInteger:10];
}
- (void)cancelEditUserName:(UIGestureRecognizer *)ges{
    [UIView animateWithDuration:0.5 animations:^{
        _modifyPage.frameOriginY = kScreenHeight;
    } completion:^(BOOL finished) {
        [_editNameTF resignFirstResponder];
    }];
}
- (NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}
#pragma mark 页面的出现和消失
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self initAllData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
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
