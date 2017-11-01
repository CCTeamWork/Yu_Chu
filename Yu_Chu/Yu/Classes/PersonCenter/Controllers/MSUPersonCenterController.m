//
//  MSUPersonCenterController.m
//  Yu
//
//  Created by DCC on 2017/10/31.
//  Copyright © 2017年 DCC. All rights reserved.
//

#import "MSUPersonCenterController.h"
#import "XLZHHeader.h"


@interface MSUPersonCenterController (){
    
    UILabel *_userNameLab;//用户姓名
    UIButton *_editNameBtn;//修改姓名按钮
}

@end

@implementation MSUPersonCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initAllData];
    
    [self initAllSubviews];
    
}
- (void)initAllData{
    
}
- (void)initAllSubviews{
    NSString *userNameString = @"我叫天王大哥";
    
    UIView *topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 181)];
    topBackView.userInteractionEnabled = YES;
    topBackView.backgroundColor = JQXXXLZHFF2D4BCLOLR;
    [self.view addSubview:topBackView];
    
    CGFloat headIMGWidth = 53.0;
    UIImageView *headIMGV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2.0-headIMGWidth/2.0, 45, headIMGWidth, headIMGWidth)];
    headIMGV.image = [UIImage imageNamed:@""];
    headIMGV.layer.cornerRadius = headIMGWidth/2.0;
    headIMGV.clipsToBounds = YES;
    [topBackView addSubview:headIMGV];
    
    CGFloat nameidth = 100;
    _userNameLab = [[UILabel alloc] init];
    
    
}
#pragma mark 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
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
