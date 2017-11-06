//
//  DCCAddLocationViewController.m
//  Yu
//
//  Created by duanchongchong on 2017/11/3.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "DCCAddLocationViewController.h"
#import "XLZHHeader.h"
#import "UITextField+Extension.h"

@interface DCCAddLocationViewController (){
    UITextField *_relationName;
    BOOL _isMan;
    UITextField *_phoneNum;
    UILabel *_location;
    UITextField *_doorNum;
    
    UIButton *_currentBtn;
}

@end

@implementation DCCAddLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initAllData];
    
    [self initAllSubviews];
}

- (void)initAllData{
    if (_isEdit) {
        _isMan = NO;
    }else{
        _isMan = YES;
    }
}

- (void)initAllSubviews{
    self.view.backgroundColor = JQXXXLZHFAFAFACLOLR;
    DCCBaseNavgationView *navV = [[DCCBaseNavgationView alloc] init];
    if (_isEdit) {
        [navV setTitle:@"修改地址" andBackGroundColor:JQXXXLZHF4F4F4COLOR andTarget:self];
    }else{
        [navV setTitle:@"新增地址" andBackGroundColor:JQXXXLZHF4F4F4COLOR andTarget:self];
    }
    [self.view addSubview:navV];
    
    UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(0, navV.frameMaxY, kScreenWidth, 250)];
    backV.backgroundColor = JQXXXLZHFFFFFFCLOLR;
    backV.userInteractionEnabled = YES;
    [self.view addSubview:backV];
    
    NSArray *titleArr = @[@"联系人",@"联系电话",@"收货地址",@"门牌号码"];
    CGFloat currentHeight = 0;
    for (NSInteger i = 0; i < titleArr.count; i++) {
        UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(14, currentHeight+26, 60, 14)];
        leftLab.text = titleArr[i];
        leftLab.textColor = JQXXXLZH272727CLOLR;
        leftLab.font = [UIFont systemFontOfSize:14];
        [backV addSubview:leftLab];
        
        if (i == 0) {
            _relationName = [[UITextField alloc] initWithFrame:CGRectMake(leftLab.frameMaxX+13, currentHeight+22, kScreenWidth-100, 22)];
            _relationName.placeholder = @"请填写收餐人姓名";
            _relationName.textColor = JQXXXLZH272727CLOLR;
            _relationName.font = [UIFont systemFontOfSize:14];
            _relationName.tag = 2000;
            [_relationName addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
            [backV addSubview:_relationName];
            
            UIButton *manBtn = [[UIButton alloc] initWithFrame:CGRectMake(_relationName.frameOriginX, _relationName.frameMaxY+26, 60, 20)];
            [manBtn setImage:[UIImage imageNamed:@"address_icon_choose_default"] forState:UIControlStateNormal];
            [manBtn setImage:[UIImage imageNamed:@"address_icon_choose_pressed"] forState:UIControlStateSelected];
            [manBtn setTitle:@"先生" forState:UIControlStateNormal];
            [manBtn setTitle:@"先生" forState:UIControlStateSelected];
            [manBtn setTitleColor:JQXXXLZH272727CLOLR forState:UIControlStateNormal];
            [manBtn setTitleColor:JQXXXLZH272727CLOLR forState:UIControlStateSelected];
            manBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            manBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 13, 0, 0);
            [manBtn addTarget:self action:@selector(changeSex:) forControlEvents:UIControlEventTouchUpInside];
            manBtn.tag = 1001;
            [backV addSubview:manBtn];
            
            UIButton *womanBtn = [[UIButton alloc] initWithFrame:CGRectMake(manBtn.frameMaxX+45, _relationName.frameMaxY+26, 60, 20)];
            [womanBtn setImage:[UIImage imageNamed:@"address_icon_choose_default"] forState:UIControlStateNormal];
            [womanBtn setImage:[UIImage imageNamed:@"address_icon_choose_pressed"] forState:UIControlStateSelected];
            [womanBtn setTitle:@"女士" forState:UIControlStateNormal];
            [womanBtn setTitle:@"女士" forState:UIControlStateSelected];
            [womanBtn setTitleColor:JQXXXLZH272727CLOLR forState:UIControlStateNormal];
            [womanBtn setTitleColor:JQXXXLZH272727CLOLR forState:UIControlStateSelected];
            womanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            womanBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 13, 0, 0);
            [womanBtn addTarget:self action:@selector(changeSex:) forControlEvents:UIControlEventTouchUpInside];            womanBtn.tag = 1000;
            [backV addSubview:womanBtn];
            
            if (_isMan) {
                _currentBtn = manBtn;
            }else{
                _currentBtn = womanBtn;
            }
            _currentBtn.selected = YES;
            UIView *underLV = [[ UIView alloc] initWithFrame:CGRectMake(14, currentHeight+99, kScreenWidth-28, 1)];
            underLV.backgroundColor = JQXXXLZHFAFAFACLOLR;
            [backV addSubview:underLV];
            currentHeight+=100;
        }else{
            if (i == 1) {
                _phoneNum = [[UITextField alloc] initWithFrame:CGRectMake(leftLab.frameMaxX+13, currentHeight+22, kScreenWidth-100, 22)];
                _phoneNum.placeholder = @"请填写收餐人的手机号码";
                _phoneNum.textColor = JQXXXLZH272727CLOLR;
                _phoneNum.font = [UIFont systemFontOfSize:14];
                _phoneNum.tag = 2001;
                _phoneNum.keyboardType = UIKeyboardTypeNumberPad;
                [_phoneNum addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
                [backV addSubview:_phoneNum];
            }
            if (i == 2) {
                _location = [[UILabel alloc] initWithFrame:CGRectMake(leftLab.frameMaxX+13, currentHeight+22, kScreenWidth-128, 22)];
                _location.textColor = JQXXXLZH272727CLOLR;
                _location.font = [UIFont systemFontOfSize:14];
                [backV addSubview:_location];
                
                UIImageView *rightIMGV = [[UIImageView alloc] initWithFrame:CGRectMake(backV.frameSizeWidth-14-14,currentHeight+10, 14, 14)];
                rightIMGV.image = [UIImage imageNamed:@"icon_forward"];
                [backV addSubview:rightIMGV];
                
                UIButton *selectLocationBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, currentHeight, kScreenWidth, 50)];
                [selectLocationBtn addTarget:self action:@selector(climpLocationPage) forControlEvents:UIControlEventTouchUpInside];
                [backV addSubview:selectLocationBtn];
            }
            if (i == 3) {
                _doorNum = [[UITextField alloc] initWithFrame:CGRectMake(leftLab.frameMaxX+13, currentHeight+22, kScreenWidth-100, 22)];
                _doorNum.placeholder = @"请填写收餐具体的门牌号及楼层";
                _doorNum.textColor = JQXXXLZH272727CLOLR;
                _doorNum.font = [UIFont systemFontOfSize:14];
                _doorNum.tag = 2002;
                _doorNum.keyboardType = UIKeyboardTypeNumberPad;
                [_doorNum addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
                [backV addSubview:_doorNum];
            }
            UIView *underLV = [[ UIView alloc] initWithFrame:CGRectMake(14, currentHeight+49, kScreenWidth-28, 1)];
            underLV.backgroundColor = JQXXXLZHFAFAFACLOLR;
            [backV addSubview:underLV];
            currentHeight+=50;
        }
    }
    
    UIButton *okBtn = [[UIButton alloc] initWithFrame:CGRectMake(14, backV.frameMaxY+26, kScreenWidth-28, 36)];
    [okBtn setBackgroundColor:JQXXXLZHFF2D4BCLOLR];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTitleColor:JQXXXLZHFFFFFFCLOLR forState:UIControlStateNormal];
    okBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    okBtn.contentHorizontalAlignment = 0;
    okBtn.contentVerticalAlignment = 0;
    okBtn.layer.cornerRadius = 2.5;
    [[okBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         //判定信息是否 正确，然后跳转并刷新
         BOOL isOK = YES;

         if (isOK) {
             if (self.callBackAndRefreshPage) {
                 self.callBackAndRefreshPage();
             }
             [self.navigationController popViewControllerAnimated:YES];
         }else{
             [SVProgressHUD showErrorWithStatus:@"信息填写不正确"];
         }
     }];
    [self.view addSubview:okBtn];
}
- (void)changeSex:(UIButton *)sender{
    if (_currentBtn == sender) {
        return;
    }
    _currentBtn.selected = NO;
    _currentBtn = sender;
    _currentBtn.selected = YES;
    
    if (_currentBtn.tag == 1001) {
        _isMan = YES;
    }else{
        _isMan = NO;
    }
}
- (void)textFieldChanged:(UITextField *)TF{
    if (TF.tag == 2000) {
        [TF LimitCharacterWithInteger:10];
    }
    if (TF.tag == 2001) {
        [TF LimitCharacterWithInteger:11];
    }
    if (TF.tag == 2002) {
        [TF LimitCharacterWithInteger:20];
    }
}
- (void)climpLocationPage{
    //跳转选择位置页面
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
