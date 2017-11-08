
//
//  DCCLocationViewController.m
//  Yu
//
//  Created by duanchongchong on 2017/11/3.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "DCCLocationViewController.h"
#import "XLZHHeader.h"
#import "Masonry.h"
#import "DCCLocationTableViewCell.h"
#import "DCCAddLocationViewController.h"
#import "DCCLocationModel.h"

@interface DCCLocationViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_mainTableview;
    NSMutableArray <DCCLocationModel*>*_dataSourceArr;
}

@end

@implementation DCCLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initAllData];
    
    [self initAllSubviews];
}

- (void)initAllData{
    [SVProgressHUD show];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [[RequestManager sharedInstance]getConfirmLocationListWith:dic WhenComplete:^(BOOL succeed, id responseData, NSError *error) {
        [SVProgressHUD dismiss];
        if (succeed) {
            _dataSourceArr = [DCCLocationModel mj_objectArrayWithKeyValuesArray:[responseData valueWithNilForKey:@"data"]];
            [_mainTableview reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:[responseData valueWithNilForKey:@"message"]];
        }
    }];
}

- (void)initAllSubviews{
    self.view.backgroundColor = JQXXXLZHFFFFFFCLOLR;
    DCCBaseNavgationView *navV = [[DCCBaseNavgationView alloc] init];
    [navV redBackGroundSetTitle:@"收货地址" andBackGroundColor:JQXXXLZHFF2D4BCLOLR andTarget:self];
    [self.view addSubview:navV];
    
    BOOL isHaveData = YES;
    if (!isHaveData) {
        //没有评价加载空白页面
        
        UIImageView *emptyIMGV = [[UIImageView alloc] init];
        emptyIMGV.image = [UIImage imageNamed:@"mine_image_none"];
        emptyIMGV.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:emptyIMGV];
        
        UILabel *emptyLab = [[UILabel alloc] init];
        emptyLab.text = @"您还没有任何收货地址";
        emptyLab.textColor = JQXXXLZH787878CLOLR;
        emptyLab.font = [UIFont systemFontOfSize:14];
        emptyLab.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:emptyLab];
        
        UILabel *alertLab = [[UILabel alloc] init];
        alertLab.text = @"赶紧添加一个吧";
        alertLab.textColor = JQXXXLZH787878CLOLR;
        alertLab.font = [UIFont systemFontOfSize:14];
        alertLab.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:alertLab];
        
        [emptyIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(navV.mas_bottom).with.offset(69);
            make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
            make.width.mas_equalTo(115);
            make.height.mas_equalTo(88);
        }];
        
        [emptyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(emptyIMGV.mas_bottom).with.offset(53);
            make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        }];
        
        [alertLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(emptyLab.mas_bottom).with.offset(10);
            make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        }];
        
        
    }else{
        //加载消息列表
        _mainTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, navV.frameMaxY, kScreenWidth, kScreenHeight-navV.frameMaxY-100) style:UITableViewStylePlain];
        _mainTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableview.delegate = self;
        _mainTableview.dataSource = self;
        _mainTableview.backgroundColor = JQXXXLZHFAFAFACLOLR;
        [self.view addSubview:_mainTableview];
    }
    
    UIButton *addLocationBtn = [[UIButton alloc] initWithFrame:CGRectMake(14, kScreenHeight-36-36, kScreenWidth-28, 36)];
    [addLocationBtn setBackgroundColor:JQXXXLZHFF2D4BCLOLR];
    [addLocationBtn setTitle:@"新增地址" forState:UIControlStateNormal];
    [addLocationBtn setTitleColor:JQXXXLZHFFFFFFCLOLR forState:UIControlStateNormal];
    addLocationBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    addLocationBtn.contentHorizontalAlignment = 0;
    addLocationBtn.contentVerticalAlignment = 0;
    addLocationBtn.layer.cornerRadius = 2.5;
    [[addLocationBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         //跳转添加地址页面
         [self climpEditLocationPageWithIndexPath:nil];
     }];
    [self.view addSubview:addLocationBtn];
    
}
#pragma mark UITableviewDelegate UITbaleviewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSourceArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DCCLocationTableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"locationCell"];
    if (cell == nil) {
        cell = [[DCCLocationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"locationCell"];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    [[cell.editBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         [self climpEditLocationPageWithIndexPath:indexPath];
     }];
    DCCLocationModel *model = _dataSourceArr[indexPath.row];
    [cell initAllDataWith:model];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isSelected) {
        if (self.callBackReturnLocationModel) {
            self.callBackReturnLocationModel();
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 *  修改Delete按钮文字为“删除”
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        DCCLocationModel *model = _dataSourceArr[indexPath.row];
        [SVProgressHUD show];
        //删除补充删除接口
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:model.tid forKey:@"id"];
        [[RequestManager sharedInstance]removeLocationAddressToSVR:dic WhenComplete:^(BOOL succeed, id responseData, NSError *error) {
            [SVProgressHUD dismiss];
            if (succeed) {
                [_dataSourceArr removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
                [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            }else{
                [SVProgressHUD showErrorWithStatus:@"删除失败"];
            }
        }];
    }
}

- (void)climpEditLocationPageWithIndexPath:(NSIndexPath *)indexPath{
    DCCAddLocationViewController *vc = [[DCCAddLocationViewController alloc] init];
    if (indexPath) {
        vc.isEdit = YES;
    }else{
        vc.isEdit = NO;
    }
    vc.callBackAndRefreshPage = ^{
        //刷新页面
        [self initAllData];
    };
    [self secondPushToViewcontroller:vc];
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
