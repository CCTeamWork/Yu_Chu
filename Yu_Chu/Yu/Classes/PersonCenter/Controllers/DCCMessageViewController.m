//
//  DCCMessageViewController.m
//  Yu
//
//  Created by duanchongchong on 2017/11/3.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "DCCMessageViewController.h"
#import "XLZHHeader.h"
#import "Masonry.h"
#import "DCCMessageTableViewCell.h"

@interface DCCMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation DCCMessageViewController{
    UITableView *_mainTableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = JQXXXLZHFFFFFFCLOLR;
    
    [self initAllData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    DCCBaseNavgationView *navV = [[DCCBaseNavgationView alloc] init];
    [navV redBackGroundSetTitle:@"消息中心" andBackGroundColor:JQXXXLZHFF2D4BCLOLR andTarget:self];
    [self.view addSubview:navV];
    
    [SVProgressHUD show];
    double delayInSeconds = 0.8;
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, mainQueue, ^{
        NSLog(@"延时执行的2秒");
        [self initAllSubviews:navV.frameMaxY];
            [SVProgressHUD dismiss];
    });
    
}
- (void)initAllData{
    
}

- (void)initAllSubviews:(CGFloat)height{
    
    BOOL isHaveData = NO;
    if (!isHaveData) {
        if (kAppDelegate.netStatus) {
            self.NONetBtn.hidden = YES;
            //没有评价加载空白页面
            UIImageView *emptyIMGV = [[UIImageView alloc] init];
            emptyIMGV.image = [UIImage imageNamed:@"comment_image_none"];
            emptyIMGV.contentMode = UIViewContentModeScaleAspectFit;
            [self.view addSubview:emptyIMGV];
            
            UILabel *emptyLab = [[UILabel alloc] init];
            emptyLab.text = @"暂无消息";
            emptyLab.textColor = JQXXXLZH272727CLOLR;
            emptyLab.font = [UIFont systemFontOfSize:14];
            emptyLab.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:emptyLab];
            
            [emptyIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(height+87);
                make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
                make.width.mas_equalTo(112);
                make.height.mas_equalTo(112);
            }];
            
            [emptyLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(emptyIMGV.mas_bottom).with.offset(20);
                make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
            }];
            
        }else{
            [self.view addSubview:self.NONetBtn];
            self.NONetBtn.hidden = NO;
            [self.NONetBtn addTarget:self action:@selector(reRequestData) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
    }else{
        //加载消息列表
        _mainTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, height, kScreenWidth, kScreenHeight-height) style:UITableViewStylePlain];
        _mainTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableview.delegate = self;
        _mainTableview.dataSource = self;
        _mainTableview.backgroundColor = JQXXXLZHFAFAFACLOLR;
        [self.view addSubview:_mainTableview];
    }
    
}
- (void)reRequestData{
    double delayInSeconds = 0.8;
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, mainQueue, ^{
        NSLog(@"延时执行的2秒");
        [self initAllSubviews:STATUS_AND_NAVIGATION_HEIGHT];
        [SVProgressHUD dismiss];
    });
}
#pragma mark UITableviewDelegate UITbaleviewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DCCMessageTableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
    if (cell == nil) {
        cell = [[DCCMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"messageCell"];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;

    return cell;
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
