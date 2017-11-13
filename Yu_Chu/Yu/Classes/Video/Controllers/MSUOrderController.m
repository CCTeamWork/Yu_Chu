//
//  MSUOrderController.m
//  Yu
//
//  Created by 何龙飞 on 2017/10/31.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUOrderController.h"
#import "MSUCoomentController.h"
#import "MSUOrderStatusController.h"
#import "MSUOrderCompleteController.h"

#import "MSUPrefixHeader.pch"
#import "MSUHomeNavView.h"

#import "MSUAllOrderView.h"
#import "MSUWaitCommentView.h"
#import "XLZHHeader.h"
#import "DCCOrderModel.h"

@interface MSUOrderController ()<UIScrollViewDelegate,MSUAllOrderViewDelegate,MSUWaitCommentViewDelegate>{
    
    NSMutableArray <DCCOrderModel*>*_leftDataSourceArr;
    NSMutableArray <DCCOrderModel*>*_rightDataSourceArr;
    
}

@property (nonatomic , strong) UIScrollView *scrollView;

@property (nonatomic , strong) UIView *lineView ;

@property (nonatomic , strong) MSUAllOrderView *allView;

@property (nonatomic , strong) MSUWaitCommentView *waitView;

@end

@implementation MSUOrderController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self initAllData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0 green:0 blue:55/255.0 alpha:1];
    [self createTopView];
}

- (void)initAllData{
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom]; //样式使用自定义
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];// 整个后面的背景选择
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];// 弹出框颜色
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];// 弹出框内容颜色
    
    RACSubject *firstSignal = [RACSubject subject];
    RACSubject *secondSignal = [RACSubject subject];
    RACSignal *zipSignal = [firstSignal zipWith:secondSignal];
    [SVProgressHUD show];
    [zipSignal subscribeNext:^(id x) {
        RACTuple *racX = x;
        NSNumber *first = racX.first;
        NSNumber *second = racX.second;
        if ([first integerValue] == 0 && [second integerValue] == 0) {
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
            return ;
        }
        //刷新页面
        [SVProgressHUD dismiss];
        _allView.dataSourceArr = _leftDataSourceArr;
        _waitView.dataSourceArr = _rightDataSourceArr;
        [_allView.bootomTableView reloadData];
        [_waitView.bootomTableView reloadData];
        [firstSignal sendCompleted];
        [secondSignal sendCompleted];
    }];
    
    NSMutableDictionary *leftDic = [[NSMutableDictionary alloc] init];
    [leftDic setObjectSafe:@"0" forKey:@"status"];
    [[RequestManager sharedInstance]getMyAllOrderWith:leftDic WhenComplete:^(BOOL succeed, id responseData, NSError *error) {
        if (succeed) {
            _leftDataSourceArr = [DCCOrderModel mj_objectArrayWithKeyValuesArray:[[responseData valueWithNilForKey:@"data"] valueWithNilForKey:@"dataList"]];
            [firstSignal sendNext:@1];
        }else{
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
            [firstSignal sendNext:@0];
        }
        
    }];
    
    NSMutableDictionary *rightDic = [[NSMutableDictionary alloc] init];
    [leftDic setObjectSafe:@"7" forKey:@"status"];
    [[RequestManager sharedInstance]getMyAllOrderWith:rightDic WhenComplete:^(BOOL succeed, id responseData, NSError *error) {
        if (succeed) {
             _rightDataSourceArr = [DCCOrderModel mj_objectArrayWithKeyValuesArray:[[responseData valueWithNilForKey:@"data"] valueWithNilForKey:@"dataList"]];
            [secondSignal sendNext:@1];
        }else{
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
            [secondSignal sendNext:@0];
        }
        
    }];
    
    
    
}

- (void)createTopView{
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 20, WIDTH, HEIGHT-64);
    bgView.backgroundColor = REDCOLOR;
    [self.view addSubview:bgView];
    
    NSArray *titArr  = @[@"全部订单",@"待评价"];
    for (NSInteger i = 0; i < 2; i++) {
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.frame = CGRectMake(WIDTH*0.5-24-62+(48+62)*i, 0, 62, 44);
        [menuBtn setTitle:titArr[i] forState:UIControlStateNormal];
        [menuBtn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
        [menuBtn setTitleColor:REDCOLOR forState:UIControlStateSelected];
        menuBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        menuBtn.tag = 1542 + i;
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:menuBtn];
    }
    
    self.lineView = [[UIView alloc] init];
    _lineView.frame = CGRectMake(WIDTH*0.5-24-60, 37, 50, 3);
    _lineView.backgroundColor = HEXCOLOR(0xffffff);
    [bgView addSubview:_lineView];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, WIDTH, HEIGHT)];
    _scrollView.backgroundColor  = HEXCOLOR(0xf2f2f2);
    _scrollView.scrollEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [bgView addSubview:_scrollView];
    
    self.allView.hidden = NO;
    
}

#pragma mark - 点击事件
- (void)menuBtnClick:(UIButton *)sender{
    
    [UIView animateWithDuration:0.25 animations:^{
        NSInteger a = sender.tag - 1542;
        _lineView.frame = CGRectMake(WIDTH*0.5-24-60 + a*(48+60+5), 37, 50, 3);
    }];
    
    if (sender.tag == 1542) {
        _scrollView.contentOffset = CGPointMake(0,0);
    } else{
        _scrollView.contentOffset = CGPointMake(WIDTH, 0);
        self.waitView.hidden = NO;
    }
}


#pragma mark - 初始化
- (MSUAllOrderView *)allView{
    if (!_allView) {
        self.allView = [[MSUAllOrderView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64-49)];
        _allView.backgroundColor = HEXCOLOR(0xf2f2f2);
        [_scrollView addSubview:_allView];
        _allView.delegate = self;
    }
    return _allView;
}

- (MSUWaitCommentView *)waitView{
    if (!_waitView) {
        self.waitView = [[MSUWaitCommentView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT-64-49)];
        _waitView.backgroundColor = HEXCOLOR(0xf2f2f2);
        [_scrollView addSubview:_waitView];
        _waitView.delegate = self;
    }
    return _waitView;
}

#pragma - 代理
- (void)commentClick{
    self.hidesBottomBarWhenPushed = YES;
    MSUCoomentController *coo = [[MSUCoomentController alloc] init];
    [self.navigationController pushViewController:coo animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)topTableViewCellDidSelect{
    self.hidesBottomBarWhenPushed = YES;
    MSUOrderStatusController *status = [[MSUOrderStatusController alloc] init];
    [self presentViewController:status animated:YES completion:nil];
}

- (void)bottomTableViewCellDidSelect{
    self.hidesBottomBarWhenPushed = YES;
    MSUOrderCompleteController *status = [[MSUOrderCompleteController alloc] init];
    [self presentViewController:status animated:YES completion:nil];
}

@end
