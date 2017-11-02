//
//  DCCAboutUsViewController.m
//  Yu
//
//  Created by duanchongchong on 2017/11/2.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "DCCAboutUsViewController.h"
#import "XLZHHeader.h"
#import "FSTextView.h"

@interface DCCAboutUsViewController ()

@end

@implementation DCCAboutUsViewController

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
    [navV setTitle:@"关于我们" andBackGroundColor:JQXXXLZHF4F4F4COLOR andTarget:self];
    [self.view addSubview:navV];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(33, navV.frameMaxY+25, kScreenWidth-66, (kScreenWidth-66)/16.0*9.0)];
    imageV.image = [UIImage imageNamed:@"chushi"];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageV];
    
    UIView *underLV = [[UIView alloc] initWithFrame:CGRectMake(33, imageV.frameMaxY+25, kScreenWidth-66, 1.0)];
    underLV.backgroundColor = JQXXXLZHFAFAFACLOLR;
    [self.view addSubview:underLV];
    
    FSTextView *textV = [[FSTextView alloc] initWithFrame:CGRectMake(33, underLV.frameMaxY+25, kScreenWidth-66, 100)];
    textV.textColor = JQXXXLZHB7B7B7CLOLR;
    textV.text = @"两岸御厨，于 2017 年正式上线，是知名浙江两岸咖啡集团协力开发之网上订餐平台．秉持”美味匠心，食在安心”的品牌精神，不惜耗资千万元在杭州设立中央厨房，聘请数十位专业厨师致力于研发最美味之饭菜，确保生产质量并严格遵守食品安全规范．严选新鲜食材、当日烹煮配送，是两岸御厨永远的坚持。让大家吃的放心、吃的开心，则是两岸御厨永远的心愿。";
    [self.view addSubview:textV];
    textV.frameSizeHeight = textV.contentSize.height;
    
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
