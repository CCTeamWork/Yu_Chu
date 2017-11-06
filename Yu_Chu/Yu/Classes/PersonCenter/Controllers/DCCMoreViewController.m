//
//  DCCMoreViewController.m
//  Yu
//
//  Created by duanchongchong on 2017/11/2.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "DCCMoreViewController.h"
#import "XLZHHeader.h"
#import "DCCAboutUsViewController.h"

@interface DCCMoreViewController ()

@end

@implementation DCCMoreViewController

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
    [navV setTitle:@"更多" andBackGroundColor:JQXXXLZHF4F4F4COLOR andTarget:self];
    [self.view addSubview:navV];
    
    UIImageView *logoIMGV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2.0-36.5, navV.frameMaxY+50, 73, 73)];
    logoIMGV.image = [UIImage imageNamed:@"more_logo"];
    logoIMGV.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:logoIMGV];
    
    UILabel *versionLab = [[UILabel alloc] initWithFrame:CGRectMake(14, logoIMGV.frameMaxY+12, kScreenWidth-28, 14)];
    versionLab.text = @"1.1.2";
    versionLab.textColor = JQXXXLZHB7B7B7CLOLR;
    versionLab.font = [UIFont systemFontOfSize:14];
    versionLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:versionLab];
    
    NSArray *titleArr = @[@"关于我们",@"去Apple Store打赏个好评"];
    NSArray *imgArr = @[@"more_icon_aboutus",@"more_icon_reputation"];
    CGFloat currentHeight = versionLab.frameMaxY+44;
    for (NSInteger i=0; i<titleArr.count; i++) {
        UIView *underLV = [[UIView alloc] initWithFrame:CGRectMake(14, currentHeight, kScreenWidth, 1.0)];
        underLV.backgroundColor = JQXXXLZHFAFAFACLOLR;
        [self.view addSubview:underLV];
        currentHeight += 1;
        
        UIView *cellV = [[UIView alloc] initWithFrame:CGRectMake(0, currentHeight, kScreenWidth, 45)];
        cellV.backgroundColor = JQXXXLZHFFFFFFCLOLR;
        cellV.userInteractionEnabled = YES;
        [self.view addSubview:cellV];
        
        UIButton *recordBtn = [[UIButton alloc] initWithFrame:CGRectMake(14, 0, cellV.frameSizeWidth-14, 45)];
        [recordBtn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [recordBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [recordBtn setTitleColor:JQXXXLZHB7B7B7CLOLR forState:UIControlStateNormal];
        recordBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [[recordBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(id x) {
             UIButton *clickBtn = x;
             if (clickBtn.tag == 1000) {
                 //跳转关于我们
                 DCCAboutUsViewController *vc = [[DCCAboutUsViewController alloc] init];
                 [self secondPushToViewcontroller:vc];
             }else{
                 //跳转去商店
                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1238532713"]];
             }
         }];
        recordBtn.tag = 1000+i;
        [recordBtn horizontalImageAndTitle:11];
        recordBtn.contentHorizontalAlignment = 1;
        [cellV addSubview:recordBtn];
        
        UIImageView *rightIMGV = [[UIImageView alloc] initWithFrame:CGRectMake(recordBtn.frameSizeWidth-14-14, 15, 14, 14)];
        rightIMGV.image = [UIImage imageNamed:@"icon_forward"];
        [recordBtn addSubview:rightIMGV];
        currentHeight += cellV.frameSizeHeight;
        
        if (i == 1) {
            UIView *underLV = [[UIView alloc] initWithFrame:CGRectMake(14, currentHeight, kScreenWidth, 1.0)];
            underLV.backgroundColor = JQXXXLZHFAFAFACLOLR;
            [self.view addSubview:underLV];
            currentHeight += 1;
        }
    }
    
    UIButton *outLogoIn = [[UIButton alloc] initWithFrame:CGRectMake(14, kScreenHeight-36-36, kScreenWidth-28, 36)];
    [outLogoIn setBackgroundColor:JQXXXLZHFF2D4BCLOLR];
    [outLogoIn setTitle:@"退出登录" forState:UIControlStateNormal];
    [outLogoIn setTitleColor:JQXXXLZHFFFFFFCLOLR forState:UIControlStateNormal];
    outLogoIn.titleLabel.font = [UIFont systemFontOfSize:15];
    outLogoIn.contentHorizontalAlignment = 0;
    outLogoIn.contentVerticalAlignment = 0;
    outLogoIn.layer.cornerRadius = 2.5;
    [[outLogoIn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         //退出登录
     }];
    [self.view addSubview:outLogoIn];
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
