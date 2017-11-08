//
//  DCCMyEvaluateViewController.m
//  Yu
//
//  Created by duanchongchong on 2017/11/3.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "DCCMyEvaluateViewController.h"
#import "XLZHHeader.h"
#import "Masonry.h"
#import "DCCEvaluateTableViewCell.h"

@interface DCCMyEvaluateViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_mainTableview;
}

@end

@implementation DCCMyEvaluateViewController

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
    NSString *userNameString = self.userName;
    NSString *evaluateString = @"0";
    UIView *topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 181+(IS_IPHONE_X?24:0))];
    topBackView.userInteractionEnabled = YES;
    topBackView.backgroundColor = JQXXXLZHFF2D4BCLOLR;
    [self.view addSubview:topBackView];
    
    CGFloat headIMGWidth = 53.0;
    UIImageView *headIMGV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2.0-headIMGWidth/2.0, 45+(IS_IPHONE_X?24:0), headIMGWidth, headIMGWidth)];
    headIMGV.image = [UIImage imageNamed:@"mine_integral_image_head"];
    headIMGV.layer.cornerRadius = headIMGWidth/2.0;
    headIMGV.clipsToBounds = YES;
    [topBackView addSubview:headIMGV];
    
    UILabel *userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(14, headIMGV.frameMaxY+13, kScreenWidth-28, 14)];
    userNameLab.text = userNameString;
    userNameLab.textColor = JQXXXLZHFFFFFFCLOLR;
    userNameLab.font = [UIFont systemFontOfSize:14];
    userNameLab.textAlignment = NSTextAlignmentCenter;
    [topBackView addSubview:userNameLab];
    
    UILabel *evaluateLab = [[UILabel alloc] initWithFrame:CGRectMake(14, userNameLab.frameMaxY+13, kScreenWidth-28, 14)];
    evaluateLab.text = [NSString stringWithFormat:@"已贡献%@条评价",evaluateString];
    evaluateLab.textColor = JQXXXLZHFFFFFFCLOLR;
    evaluateLab.font = [UIFont systemFontOfSize:14];
    evaluateLab.textAlignment = NSTextAlignmentCenter;
    [topBackView addSubview:evaluateLab];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, headIMGV.frameOriginY-20, 60, 40)];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [[backBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(__kindof UIControl * _Nullable x) {
             [self.navigationController popViewControllerAnimated:YES];
    }];
    [topBackView addSubview:backBtn];
    
    if (evaluateString.integerValue == 0) {
        //没有评价加载空白页面
        
        UIImageView *emptyIMGV = [[UIImageView alloc] init];
        emptyIMGV.image = [UIImage imageNamed:@"comment_image_none"];
        emptyIMGV.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:emptyIMGV];
        
        UILabel *emptyLab = [[UILabel alloc] init];
        emptyLab.text = @"暂无评价";
        emptyLab.textColor = JQXXXLZH272727CLOLR;
        emptyLab.font = [UIFont systemFontOfSize:14];
        emptyLab.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:emptyLab];
        
        [emptyIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topBackView.mas_bottom).with.offset(87);
            make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
            make.width.mas_equalTo(112);
            make.height.mas_equalTo(112);
        }];
        
        [emptyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(emptyIMGV.mas_bottom).with.offset(20);
            make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        }];
        
        
    }else{
        _mainTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, topBackView.frameMaxY, kScreenWidth, kScreenHeight-topBackView.frameMaxY) style:UITableViewStylePlain];
        _mainTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableview.delegate = self;
        _mainTableview.dataSource = self;
        [self.view addSubview:_mainTableview];
    }
}
#pragma mark UITableviewDelegate UITbaleviewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *contentStr = @"两岸御厨，于 2017 年正式上线，是知名浙江两岸咖啡集团协力开发之网上订餐平台．秉持”美味匠心，食在安心”的品牌精神，不惜耗资千万元在杭州设立中央厨房，聘请数十位专业厨师致力于研发最美味之饭菜，确保生产质量并严格遵守食品安全规范．严选新鲜食材、当日烹煮配送，是两岸御厨永远的坚持。让大家吃的放心、吃的开心，则是两岸御厨永远的心愿。";
    return [self getSpaceLabelHeight:contentStr withFont:[UIFont systemFontOfSize:14] withWidth:kScreenWidth-40]+65;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DCCEvaluateTableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"evaluateCell"];
    if (cell == nil) {
        cell = [[DCCEvaluateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"evaluateCell"];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;

    return cell;
}
-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 0;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
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
