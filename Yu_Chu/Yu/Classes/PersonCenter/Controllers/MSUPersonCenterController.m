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


@interface MSUPersonCenterController (){
    
    UILabel *_userNameLab;//用户姓名
    UIButton *_editNameBtn;//修改姓名按钮
    UIButton *_personalIntegralBtn;//显示用户积分
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
    
    [self initAllData];
    
    [self initAllSubviews];
    
}
- (void)initAllData{
    
}
- (void)initAllSubviews{
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSString *userNameString = @"我叫天王大哥";
    NSString *integralString = @"菜鸟";
    
    UIScrollView *mainSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-(IS_IPHONE_X?84:50))];
    mainSV.backgroundColor = JQXXXLZHF4F4F4COLOR;
    mainSV.showsVerticalScrollIndicator = NO;
    mainSV.showsHorizontalScrollIndicator = NO;
    mainSV.userInteractionEnabled = YES;
    mainSV.bounces = NO;
    [self.view addSubview:mainSV];
    
    UIView *topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 181+(IS_IPHONE_X?24:0))];
    topBackView.userInteractionEnabled = YES;
    topBackView.backgroundColor = JQXXXLZHFF2D4BCLOLR;
    [mainSV addSubview:topBackView];
    
    CGFloat headIMGWidth = 53.0;
    UIImageView *headIMGV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2.0-headIMGWidth/2.0, 45+(IS_IPHONE_X?24:0), headIMGWidth, headIMGWidth)];
    headIMGV.image = [UIImage imageNamed:@"mine_integral_image_head"];
    headIMGV.layer.cornerRadius = headIMGWidth/2.0;
    headIMGV.clipsToBounds = YES;
    [topBackView addSubview:headIMGV];

    CGFloat nameWidth = [NSString calculateRowWidth:userNameString andFont:14 andHeight:15];
    CGFloat totalWidth = nameWidth+8+16;
    _userNameLab = [[UILabel alloc] initWithFrame:CGRectMake((topBackView.frameSizeWidth-totalWidth)/2.0, headIMGV.frameMaxY+13, totalWidth, 16)];
    _userNameLab.text = userNameString;
    _userNameLab.textColor = JQXXXLZHFFFFFFCLOLR;
    _userNameLab.font = [UIFont systemFontOfSize:14];
    [_userNameLab sizeToFit];
    [topBackView addSubview:_userNameLab];
    
    UIButton *editNameBtn = [[UIButton alloc] initWithFrame:CGRectMake(_userNameLab.frameMaxX+8, _userNameLab.frameOriginY, 16, 16)];
    [editNameBtn setImage:[UIImage imageNamed:@"address_icon_edit"] forState:UIControlStateNormal];
    [[editNameBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x ){
        //点击按钮进入或者弹出修改名字页面
    }];
    editNameBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    editNameBtn.imageView.clipsToBounds = YES;
    [topBackView addSubview:editNameBtn];
    
    _personalIntegralBtn = [[UIButton alloc] initWithFrame:CGRectMake(14, editNameBtn.frameMaxY+13, topBackView.frameSizeWidth-28, 16)];
    [_personalIntegralBtn setImage:[UIImage imageNamed:@"mine_icon_grade"] forState:UIControlStateNormal];
    [_personalIntegralBtn setTitle:integralString forState:UIControlStateNormal];
    [_personalIntegralBtn setTitleColor:JQXXXLZHFFFFFFCLOLR forState:UIControlStateNormal];
    _personalIntegralBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _personalIntegralBtn.enabled = NO;
    [_personalIntegralBtn horizontalImageAndTitle:4.0];
    [topBackView addSubview:_personalIntegralBtn];
    
    //右侧进入消息页面按钮
    UIButton *messageBtn = [[UIButton alloc] initWithFrame:CGRectMake(topBackView.frameMaxX-14-20, 30+(IS_IPHONE_X?24:0), 20, 20)];
    [messageBtn setImage:[UIImage imageNamed:@"mine_icon_message"] forState:UIControlStateNormal];
    [[messageBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x ){
        //点击按钮进入消息页面
        DCCMessageViewController *vc = [[DCCMessageViewController alloc] init];
        [self pushToViewcontroller:vc];
    }];
    [topBackView addSubview:messageBtn];
    
    //红包 收货地址等
    NSArray *titleArr = @[@"我的红包",@"收货地址",@"我的评价",@"我的积分",@"意见反馈",@"更多"];
    NSArray *imgArr = @[@"icon_redbag",@"icon_address",@"icon_comment",@"icon_point",@"icon_feedback",@"icon_more"];
    CGFloat currentHeight = topBackView.frameMaxY;
    for (NSInteger i=0; i<titleArr.count; i++) {
        UIView *cellV = [[UIView alloc] initWithFrame:CGRectMake(0, currentHeight, mainSV.frameSizeWidth, 45)];
        cellV.backgroundColor = JQXXXLZHFFFFFFCLOLR;
        cellV.userInteractionEnabled = YES;
        [mainSV addSubview:cellV];
        
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
    mainSV.contentSize = CGSizeMake(kScreenWidth, currentHeight);
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
            [self pushToViewcontroller:vc];
            break;
        }
        case 1003:{
            //跳转到我的积分
            DCCMyIntegralViewController *vc = [[DCCMyIntegralViewController alloc] init];
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

#pragma mark 页面的出现和消失
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
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
