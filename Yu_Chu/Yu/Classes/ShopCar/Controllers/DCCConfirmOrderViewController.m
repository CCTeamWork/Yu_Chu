//
//  DCCConfirmOrderViewController.m
//  Yu
//
//  Created by duanchongchong on 2017/11/6.
//  Copyright © 2017年 DCC. All rights reserved.
//

#import "DCCConfirmOrderViewController.h"
#import "XLZHHeader.h"
#import "Masonry.h"

@interface DCCConfirmOrderViewController (){
    UIScrollView *_mainScrollerView;
    
    //地址栏目
    UILabel *_userNameLab;
    UILabel *_phoneLab;
    UILabel *_detailLocationLab;
    
    CGFloat _currentHeight;
    
    UILabel *_arriveTimeLab;
    UILabel *_redCountLab;
}

@end

@implementation DCCConfirmOrderViewController

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
    [navV redBackGroundSetTitle:@"确认订单" andBackGroundColor:JQXXXLZHFF2D4BCLOLR andTarget:self];
    [self.view addSubview:navV];
    
    _mainScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, navV.frameMaxY, kScreenWidth, kScreenHeight-navV.frameSizeHeight-70-(IS_IPHONE_X?34:0))];
    _mainScrollerView.backgroundColor = JQXXXLZHFAFAFACLOLR;
    _mainScrollerView.showsVerticalScrollIndicator = NO;
    _mainScrollerView.showsHorizontalScrollIndicator = NO;
    _mainScrollerView.userInteractionEnabled = YES;
    [self.view addSubview:_mainScrollerView];
    _currentHeight = 0;
    
    //加载收货地址view
    [self loadLocationView];
    [self modifyOrSetValueToLocationView];
    
    [self creatView:@"付款信息" andFontSize:14 andColor:JQXXXLZH272727CLOLR andLeftIMG:nil andLeftIMGWidth:0 andRightTitle:@"在线支付" andightFontSize:14 andColor:JQXXXLZHB7B7B7CLOLR andLeftIMG:@"icon_forward" andLeftIMGWidth:14 andNSInteger:0];
    _currentHeight+=6;
    
    UIView * selectTimeV = [self creatView:@"就餐时间" andFontSize:14 andColor:JQXXXLZH272727CLOLR andLeftIMG:@"icon_clock" andLeftIMGWidth:18 andRightTitle:@"尽快送达" andightFontSize:14 andColor:JQXXXLZHB7B7B7CLOLR andLeftIMG:@"icon_forward" andLeftIMGWidth:14 andNSInteger:1];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTime)];
    [selectTimeV addGestureRecognizer:tapGes];
    _currentHeight+=6;
    
    [self creatView:@"两岸咖啡（绍兴店）" andFontSize:15 andColor:JQXXXLZH272727CLOLR andLeftIMG:@"img_big" andLeftIMGWidth:35 andRightTitle:@"" andightFontSize:14 andColor:JQXXXLZHB7B7B7CLOLR andLeftIMG:@"icon_forward" andLeftIMGWidth:14 andNSInteger:2];
    [self addUnderLV:_currentHeight];
    
    [self addGoodsList];
    
    [self creatView:@"在线支付立减优惠" andFontSize:15 andColor:JQXXXLZH272727CLOLR andLeftIMG:@"icon_onlinepayment" andLeftIMGWidth:18 andRightTitle:@"-¥16" andightFontSize:14 andColor:JQXXXLZH272727CLOLR andLeftIMG:nil andLeftIMGWidth:0 andNSInteger:2];
    
    [self creatView:@"会员减配送费" andFontSize:15 andColor:JQXXXLZH272727CLOLR andLeftIMG:@"icon_member" andLeftIMGWidth:18 andRightTitle:@"-¥4" andightFontSize:14 andColor:JQXXXLZH272727CLOLR andLeftIMG:@"nil" andLeftIMGWidth:0 andNSInteger:2];
    [self addUnderLV:_currentHeight];
    
    [self addRedPocket];
    _mainScrollerView.contentSize = CGSizeMake(kScreenWidth, _currentHeight);
    
    [self
     addFooterView];
}
- (void)addFooterView{
    UILabel *arriveLcationLab = [[UILabel alloc] initWithFrame:CGRectMake(0,_mainScrollerView.frameMaxY ,kScreenWidth, 20 )];
    arriveLcationLab.text = @"  送至：迪凯银座";
    arriveLcationLab.backgroundColor = JQXXXLZH272727CLOLR;
    arriveLcationLab.backgroundColor = JQXXXLZHFFFADACLOLR;
    arriveLcationLab.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:arriveLcationLab];
    
    UILabel *discountInfoLab = [[UILabel alloc] initWithFrame:CGRectMake(0,arriveLcationLab.frameMaxY ,kScreenWidth-106, 50 )];
    discountInfoLab.text = @"  待支付 ¥24 | 优惠 ¥14";
    discountInfoLab.backgroundColor = JQXXXLZH272727CLOLR;
    discountInfoLab.backgroundColor = JQXXXLZHFAFAFACLOLR;
    discountInfoLab.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:discountInfoLab];
    
    UIButton *okBtn = [[UIButton alloc] initWithFrame:CGRectMake(discountInfoLab.frameMaxX, discountInfoLab.frameOriginY+12, 106, 50)];
    [okBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [okBtn setTitleColor:JQXXXLZHFFFFFFCLOLR forState:UIControlStateNormal];
    okBtn.contentHorizontalAlignment = 0;
    okBtn.contentVerticalAlignment = 0;
    [okBtn setBackgroundColor:JQXXXLZHFF2D4BCLOLR];
    [[okBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(__kindof UIControl * _Nullable x) {
         //点击提交订单
     }];
    [self.view addSubview:okBtn];
}
- (void)addRedPocket{
    UIView *redV = [[UIView alloc] initWithFrame:CGRectMake(0, _currentHeight, kScreenWidth, 45)];
    redV.backgroundColor = JQXXXLZHFFFFFFCLOLR;
    redV.userInteractionEnabled = YES;
    [_mainScrollerView addSubview:redV];
    _currentHeight += (redV.frameSizeHeight+6);
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(climpRedPage)];
    [redV addGestureRecognizer:tapGes];
    
    UILabel *leftLab = [[UILabel alloc] init];
    leftLab.text = @"红包";
    leftLab.textColor = JQXXXLZH272727CLOLR;
    leftLab.font = [UIFont systemFontOfSize:14];
    [redV addSubview:leftLab];
    
    _redCountLab = [[UILabel alloc] init];
    _redCountLab.textColor = JQXXXLZHFFFFFFCLOLR;
    _redCountLab.font = [UIFont systemFontOfSize:12];
    _redCountLab.backgroundColor = JQXXXLZHFF2D4BCLOLR;
    _redCountLab.text = @"3个可用";
    [redV addSubview:_redCountLab];
    
    UIImageView *rightIMGV = [[UIImageView alloc] init];
    rightIMGV.image = [UIImage imageNamed:@"icon_forward"];
    [redV addSubview:rightIMGV];
    
    [leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(redV.mas_left).with.offset(14);
        make.centerY.equalTo(redV.mas_centerY).with.offset(0);
    }];
    
    [rightIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(redV.mas_right).with.offset(-14);
        make.centerY.equalTo(redV.mas_centerY).with.offset(0);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(14);
    }];
    
    [_redCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rightIMGV.mas_left).with.offset(-14);
        make.centerY.equalTo(redV.mas_centerY).with.offset(0);
    }];
}
- (void )addUnderLV:(CGFloat)height{
    UIView *underLV = [[UIView alloc] initWithFrame:CGRectMake(14, height, kScreenWidth-28, 1)];
    underLV.backgroundColor = JQXXXLZHFAFAFACLOLR;
    [_mainScrollerView addSubview:underLV];
    _currentHeight+=1;
}
- (void)loadLocationView{
    UIView *locationV = [[UIView alloc] initWithFrame:CGRectMake(0, _currentHeight, kScreenWidth, 79)];
    locationV.backgroundColor = JQXXXLZHFFFFFFCLOLR;
    locationV.userInteractionEnabled = YES;
    [_mainScrollerView addSubview:locationV];
    _currentHeight += (locationV.frameSizeHeight+6);
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(climpLocationListPage)];
    [locationV addGestureRecognizer:tapGes];
    
    UIImageView *leftIMGV = [[UIImageView alloc] init];
    leftIMGV.image = [UIImage imageNamed:@"icon_address11"];
    leftIMGV.contentMode = UIViewContentModeScaleAspectFit;
    [locationV addSubview:leftIMGV];
    
    _userNameLab = [[UILabel alloc] init];
    _userNameLab.textColor = JQXXXLZH272727CLOLR;
    _userNameLab.font = [UIFont systemFontOfSize:14];
    [locationV addSubview:_userNameLab];
    
    _phoneLab = [[UILabel alloc] init];
    _phoneLab.textColor = JQXXXLZH272727CLOLR;
    _phoneLab.font = [UIFont systemFontOfSize:14];
    [locationV addSubview:_phoneLab];
    
    _detailLocationLab = [[UILabel alloc] init];
    _detailLocationLab.textColor = JQXXXLZHB7B7B7CLOLR;
    _detailLocationLab.font = [UIFont systemFontOfSize:14];
    [locationV addSubview:_detailLocationLab];
    
    UIImageView *rightIMGV = [[UIImageView alloc] init];
    rightIMGV.image = [UIImage imageNamed:@"icon_forward"];
    [locationV addSubview:rightIMGV];
    
    //布局
    [leftIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locationV.mas_left).with.offset(14);
        make.top.equalTo(locationV.mas_top).with.offset(14);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(14);
    }];
    
    [_userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftIMGV.mas_right).with.offset(16);
        make.centerY.equalTo(leftIMGV.mas_centerY).with.offset(0);
    }];
    
    [_phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userNameLab.mas_right).with.offset(20);
        make.centerY.equalTo(leftIMGV.mas_centerY).with.offset(0);
    }];
    
    [_detailLocationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userNameLab.mas_left);
        make.top.equalTo(_userNameLab.mas_bottom).with.offset(18);
    }];
    
    [rightIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(locationV.mas_right).with.offset(-14);
        make.centerY.equalTo(leftIMGV.mas_centerY).with.offset(0);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(14);
    }];
    
}
- (void)modifyOrSetValueToLocationView{
    _userNameLab.text = @"两岸咖啡";
    _phoneLab.text = @"18888888888";
    _detailLocationLab.text  = @"杭州市江干区迪凯银座1301";
}
- (UIView *)creatView:(NSString *)lefrtTitle andFontSize:(CGFloat)leftFontSize andColor:(UIColor *)leftColor andLeftIMG:(NSString *)lefImgV andLeftIMGWidth:(CGFloat)leftWidth andRightTitle:(NSString *)rightTitle andightFontSize:(CGFloat)rightFontSize andColor:(UIColor *)rightColor andLeftIMG:(NSString *)rightImgV andLeftIMGWidth:(CGFloat)rightWidth andNSInteger:(NSInteger )lab{
    CGFloat viewHeight = 45;
    if (lab == 2) {
        viewHeight = 65;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, _currentHeight, kScreenWidth, viewHeight)];
    view.backgroundColor = JQXXXLZHFFFFFFCLOLR;
    [_mainScrollerView addSubview:view];
    _currentHeight += view.frameSizeHeight;
    
    UIImageView *leftIMGV = [[UIImageView alloc] init];
    leftIMGV.image = [UIImage imageNamed:lefImgV?lefImgV:@""];
    [view addSubview:leftIMGV];
    
    UILabel *leftLab = [[UILabel alloc] init];
    leftLab.textColor = leftColor;
    leftLab.font = [UIFont systemFontOfSize:leftFontSize];
    leftLab.text = lefrtTitle;
    [view addSubview:leftLab];
    
    UILabel *rightLab = [[UILabel alloc] init];
    rightLab.text = rightTitle;
    rightLab.textColor = rightColor;
    rightLab.font = [UIFont systemFontOfSize:rightFontSize];
    [view addSubview:rightLab];
    if (lab == 1) {
        _arriveTimeLab = rightLab;
    }
    
    UIImageView *rightIMGV = [[UIImageView alloc] init];
    rightIMGV.image = [UIImage imageNamed:rightImgV?rightImgV:@""];
    [view addSubview:rightIMGV];
    
    //布局
    CGFloat leftW = 4;
    CGFloat leftMargin = 0;
    if (lefImgV) {
        leftW = leftWidth;
        leftMargin = 14;
    }
    [leftIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).with.offset(leftWidth);
        make.centerY.equalTo(view.mas_centerY);
        make.width.mas_equalTo(leftW);
        make.height.mas_equalTo(leftW);
    }];
    
    [leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftIMGV.mas_right).with.offset(10);
        make.centerY.equalTo(view.mas_centerY);
    }];
    
    CGFloat rightW = 4;
    CGFloat rightMargin = 0;
    if (rightImgV) {
        rightW = rightWidth;
        rightMargin = -14;
    }
    [rightIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).with.offset(rightMargin);
        make.centerY.equalTo(view.mas_centerY);
        make.width.mas_equalTo(rightW);
        make.height.mas_equalTo(rightW);
    }];
    
    [rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rightIMGV.mas_left).with.offset(-10);
        make.centerY.equalTo(view.mas_centerY);
    }];
    return view;
}
- (void)addGoodsList{
    //跳转收货地址列表页面
    NSArray *titleArr = @[@"维他柠檬茶",@"黄椒牛蛙套餐",@"餐盒",@"配送费"];
    NSArray *countArr = @[@"1",@"1",@"",@""];
    NSArray *priceArr = @[@"5",@"26",@"2",@"5"];
    CGFloat totalHeight = 46+25*(titleArr.count-2)+15*(titleArr.count-1) +50;
    UIView *goodsV = [[UIView alloc] initWithFrame:CGRectMake(0, _currentHeight, kScreenWidth, totalHeight)];
    goodsV.backgroundColor = JQXXXLZHFFFFFFCLOLR;
    [_mainScrollerView addSubview:goodsV];
    _currentHeight += totalHeight;
    CGFloat goodsCurrentHeight = 23;
    for (NSInteger i = 0; i < titleArr.count; i++) {
        UILabel *leftLab = [[UILabel alloc] init];
        leftLab.textColor = JQXXXLZH272727CLOLR;
        leftLab.text = titleArr[i];
        leftLab.font = [UIFont systemFontOfSize:14];
        [goodsV addSubview:leftLab];
        
        UILabel *countLab = [[UILabel alloc] init];
        countLab.textColor = JQXXXLZH272727CLOLR;
        if (![countArr[i] isEqualToString:@""]) {
            countLab.text = [NSString stringWithFormat:@"x%@",countArr[i]];
        }
        countLab.font = [UIFont systemFontOfSize:14];
        [goodsV addSubview:countLab];
        
        UILabel *rightLab = [[UILabel alloc] init];
        rightLab.textColor = JQXXXLZH272727CLOLR;
        rightLab.text = [NSString stringWithFormat:@"¥%@",priceArr[i]];
        rightLab.font = [UIFont systemFontOfSize:14];
        [goodsV addSubview:rightLab];
        
        
        [leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(goodsV.mas_left).with.offset(14);
            make.top.mas_equalTo(goodsCurrentHeight);
        }];
        
        [countLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(goodsV.mas_centerX);
            make.top.mas_equalTo(goodsCurrentHeight);
        }];
        
        [rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(goodsV.mas_right).with.offset(-14);
            make.top.mas_equalTo(goodsCurrentHeight);
        }];
        if (i == (titleArr.count-2)) {
            goodsCurrentHeight += (23+15);
            UIView *underLV = [[UIView alloc] initWithFrame:CGRectMake(14, goodsCurrentHeight, kScreenWidth-28, 1)];
            underLV.backgroundColor = JQXXXLZHFAFAFACLOLR;
            [goodsV addSubview:underLV];
            goodsCurrentHeight += 18;
        }else if (i == (titleArr.count-1)){
            goodsCurrentHeight += (18+14);
            UIView *underLV = [[UIView alloc] initWithFrame:CGRectMake(14, goodsV.frameSizeHeight-1, kScreenWidth-28, 1)];
            underLV.backgroundColor = JQXXXLZHFAFAFACLOLR;
            [goodsV addSubview:underLV];
            
        }else{
            goodsCurrentHeight += (25+15);
        }
    }
}
#pragma mark ONClick
- (void)climpLocationListPage{
    
}

- (void)selectTime{
    
}
- (void)climpRedPage{
    
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
