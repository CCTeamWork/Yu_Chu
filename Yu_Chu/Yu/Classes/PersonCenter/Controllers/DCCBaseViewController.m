
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
}
#pragma mark 空白页面
-(UIButton *)NONetBtn{
    if (!_NONetBtn) {
        _NONetBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAVIGATION_HEIGHT, kScreenWidth, kScreenHeight-STATUS_AND_NAVIGATION_HEIGHT-(IS_IPHONE_X?34:0)-50)];
        [_NONetBtn setImage:[UIImage imageNamed:@"image_nonet"] forState:UIControlStateNormal];
        [_NONetBtn setTitle:@"暂无网络" forState:UIControlStateNormal];
        [_NONetBtn setTitleColor:JQXXXLZHB7B7B7CLOLR forState:UIControlStateNormal];
        _NONetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_NONetBtn verticalImageAndTitle:15];
    }
    return _NONetBtn;
}
-(UIButton *)errorBtn{
    if (!_errorBtn) {
        _errorBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAVIGATION_HEIGHT, kScreenWidth, kScreenHeight-STATUS_AND_NAVIGATION_HEIGHT-(IS_IPHONE_X?34:0)-50)];
        [_errorBtn setImage:[UIImage imageNamed:@"image_nonet"] forState:UIControlStateNormal];
        [_errorBtn setTitle:@"呃…页面出错了！" forState:UIControlStateNormal];
        [_errorBtn setTitleColor:JQXXXLZHB7B7B7CLOLR forState:UIControlStateNormal];
        _errorBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_errorBtn verticalImageAndTitle:15];
    }
    return _errorBtn;
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
