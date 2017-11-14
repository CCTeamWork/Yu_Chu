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
#import "MSUNoDataView.h"


#import "MSUAllOrderView.h"
#import "MSUWaitCommentView.h"

@interface MSUOrderController ()<UIScrollViewDelegate,MSUAllOrderViewDelegate,MSUWaitCommentViewDelegate>

@property (nonatomic , strong) UIScrollView *scrollView;

@property (nonatomic , strong) UIView *lineView ;

@property (nonatomic , strong) MSUAllOrderView *allView;

@property (nonatomic , strong) MSUWaitCommentView *waitView;

@property (nonatomic , strong) MSUNoDataView *noDataView;


@end

@implementation MSUOrderController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0 green:0 blue:55/255.0 alpha:1];
    
//    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:2];
//    [self.view addSubview:nav];
    
    
    [self createTopView];
    
    [self loadRequstWithStatus:@"0" page:@"1"];
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

// 0是全部 10是完成
- (void)loadRequstWithStatus:(NSString *)status page:(NSString *)page{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"dccLoginToken"];
    if (!token) {
        token = @"";
    }
    
    NSDictionary *dic = @{@"token":token,@"status":status,@"pageSize":@"10",@"pageIndex":page};
    NSLog(@"--- dic %@",dic);
    [[MSUAFNRequest sharedInstance] postRequestWithURL:@"http://192.168.10.21:8202/member/order/pageMyOrder" parameters:dic withBlock:^(id obj, NSError *error) {
//        NSLog(@"---%@",error);
        if (obj) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingMutableLeaves error:nil];
            if (!error) {
                NSLog(@"访问成功%@",jsonDict);
                if([jsonDict[@"code"] isEqualToString:@"200"]){
                    MSUOrderModel *orderModel = [MSUOrderModel mj_objectWithKeyValues:jsonDict];

                    if (orderModel.data.dataList.count > 0) {
                        self.noDataView.hidden = YES;
                        if ([status isEqualToString:@"0"]) {
                            self.allView.hidden = NO;
                            self.waitView.hidden = YES;
                            
                            self.allView.dataArr = orderModel.data.dataList;
                        } else{
                            self.allView.hidden = YES;
                            self.waitView.hidden = NO;
                            
                            self.waitView.dataArr = orderModel.data.dataList;
                        }

                    } else{
                        self.noDataView.hidden = NO;
                        self.allView.hidden = YES;
                        self.waitView.hidden = YES;
                    }
                    
                } else{
                    self.noDataView.hidden = NO;
                    self.allView.hidden = YES;
                    self.waitView.hidden = YES;
                }
                
            }else{
                NSLog(@"访问报错%@",error);
                self.noDataView.hidden = NO;
                self.allView.hidden = YES;
                self.waitView.hidden = YES;
            }
            
        } else{
            [MSUHUD showFileWithString:@"服务器请求为空"];
            self.noDataView.hidden = NO;
            self.allView.hidden = YES;
            self.waitView.hidden = YES;
        }
        
    }];
}

#pragma mark - 点击事件
- (void)menuBtnClick:(UIButton *)sender{
    
    [UIView animateWithDuration:0.25 animations:^{
        NSInteger a = sender.tag - 1542;
        _lineView.frame = CGRectMake(WIDTH*0.5-24-60 + a*(48+60+5), 37, 50, 3);
    }];
    
    if (sender.tag == 1542) {
        _scrollView.contentOffset = CGPointMake(0,0);
        [self loadRequstWithStatus:@"0" page:@"1"];
    } else{
        _scrollView.contentOffset = CGPointMake(WIDTH, 0);
        self.waitView.hidden = NO;
        [self loadRequstWithStatus:@"0" page:@"7"];

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

- (MSUNoDataView *)noDataView{
    if(!_noDataView){
        _noDataView = [[MSUNoDataView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-49)];
        [self.view addSubview:_noDataView];
        _noDataView.backgroundColor = HEXCOLOR(0xf0f0f0);
    }
    return _noDataView;
}

#pragma - 代理
- (void)commentClickModel:(MSUListModel *)model{
    self.hidesBottomBarWhenPushed = YES;
    MSUCoomentController *coo = [[MSUCoomentController alloc] init];
//    [self.navigationController pushViewController:coo animated:YES];
    coo.detailModel = model;
    [self presentViewController:coo animated:YES completion:nil];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)topTableViewCellDidSelectWithModel:(MSUListModel *)model{
    self.hidesBottomBarWhenPushed = YES;
    MSUOrderStatusController *status = [[MSUOrderStatusController alloc] init];
    status.detaiModel = model;
    [self presentViewController:status animated:YES completion:nil];
}

- (void)bottomTableViewCellDidSelectWithModel:(MSUListModel *)model{
    self.hidesBottomBarWhenPushed = YES;
    MSUOrderCompleteController *status = [[MSUOrderCompleteController alloc] init];
    status.detailModel = model;
    [self presentViewController:status animated:YES completion:nil];
}

@end
