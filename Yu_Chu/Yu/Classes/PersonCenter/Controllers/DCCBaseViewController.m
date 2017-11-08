
//
//  DCCBaseViewController.m
//  Yu
//
//  Created by duanchongchong on 2017/11/2.
//

#import "DCCBaseViewController.h"
#import "SVProgressHUD.h"

@interface DCCBaseViewController ()

@end

@implementation DCCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark 封装方法跳转方法
- (void)pushToViewcontroller:(UIViewController *)vc{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

//二级页面push全部用这个方法
- (void)secondPushToViewcontroller:(UIViewController *)vc{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SVProgressHUD dismiss];
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
