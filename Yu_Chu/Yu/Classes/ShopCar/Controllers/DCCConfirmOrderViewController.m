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
#import "DCCLocationViewController.h"
#import "DCCMyRedEnvelopeViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DCCLocationModel.h"
#import "DCCConfirmOrderModel.h"

@interface DCCConfirmOrderViewController (){
    UIScrollView *_mainScrollerView;
    
    //地址栏目
    UILabel *_userNameLab;
    UILabel *_phoneLab;
    UILabel *_detailLocationLab;
    
    CGFloat _currentHeight;
    
    UILabel *_arriveTimeLab;
    UILabel *_redCountLab;
    UIButton *_clickBtn;
    
    DCCConfirmOrderModel *_currentModel;
    UIImageView *_leftIMGV;
    UIImageView *_rightIMGV;
    UILabel *_arriveLcationLab;
    
    NSString *_locationID;
    DCCBaseNavgationView *_navV;
    
}

@end

@implementation DCCConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = JQXXXLZHFFFFFFCLOLR;
    _navV = [[DCCBaseNavgationView alloc] init];
    [_navV redBackGroundSetTitle:@"确认订单" andBackGroundColor:JQXXXLZHFF2D4BCLOLR andTarget:self];
    [self.view addSubview:_navV];

    if (self.shopId) {
        if (![self.shopId isEqualToString:@""]) {
            [self initAllData];
            return;
        }
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(payResult:) name:@"payResult" object:nil];
}

- (void)initAllData{
    [SVProgressHUD show];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"1" forKey:@"shopId"];
    [[RequestManager sharedInstance]PayMoneySHopCarInfomation:dic WhenComplete:^(BOOL succeed, id responseData, NSError *error) {
        [SVProgressHUD dismiss];
        if (succeed) {
            _currentModel = [DCCConfirmOrderModel mj_objectWithKeyValues:[responseData valueWithNilForKey:@"data"]];
            _locationID = _currentModel.addressId;
            [self initAllSubviews];
        }else{
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
        }
    }];
}

- (void)initAllSubviews{
    
    _mainScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _navV.frameMaxY, kScreenWidth, kScreenHeight-_navV.frameSizeHeight-70-(IS_IPHONE_X?34:0))];
    _mainScrollerView.backgroundColor = JQXXXLZHFAFAFACLOLR;
    _mainScrollerView.showsVerticalScrollIndicator = NO;
    _mainScrollerView.showsHorizontalScrollIndicator = NO;
    _mainScrollerView.userInteractionEnabled = YES;
    [self.view addSubview:_mainScrollerView];
    _currentHeight = 0;
    
    //加载收货地址view
    [self loadLocationView];
    
    [self creatView:@"付款信息" andFontSize:14 andColor:JQXXXLZH272727CLOLR andLeftIMG:nil andLeftIMGWidth:0 andRightTitle:@"在线支付" andightFontSize:14 andColor:JQXXXLZHB7B7B7CLOLR andLeftIMG:@"icon_forward" andLeftIMGWidth:14 andNSInteger:0];
    _currentHeight+=6;
    
    UIView * selectTimeV = [self creatView:@"就餐时间" andFontSize:14 andColor:JQXXXLZH272727CLOLR andLeftIMG:@"icon_clock" andLeftIMGWidth:18 andRightTitle:@"尽快送达" andightFontSize:14 andColor:JQXXXLZHB7B7B7CLOLR andLeftIMG:@"icon_forward" andLeftIMGWidth:14 andNSInteger:1];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTime)];
    [selectTimeV addGestureRecognizer:tapGes];
    _currentHeight+=6;
    
    [self creatView:self.shopName andFontSize:15 andColor:JQXXXLZH272727CLOLR andLeftIMG:_currentModel.shopLogo andLeftIMGWidth:35 andRightTitle:@"" andightFontSize:14 andColor:JQXXXLZHB7B7B7CLOLR andLeftIMG:@"icon_forward" andLeftIMGWidth:14 andNSInteger:3];
    [self addUnderLV:_currentHeight];
    
    [self addGoodsList];
    
    [self creatView:@"在线支付立减优惠" andFontSize:15 andColor:JQXXXLZH272727CLOLR andLeftIMG:@"icon_onlinepayment" andLeftIMGWidth:18 andRightTitle:@"¥0" andightFontSize:14 andColor:JQXXXLZH272727CLOLR andLeftIMG:nil andLeftIMGWidth:0 andNSInteger:2];
    
//    [self creatView:@"会员减配送费" andFontSize:15 andColor:JQXXXLZH272727CLOLR andLeftIMG:@"icon_member" andLeftIMGWidth:18 andRightTitle:@"0" andightFontSize:14 andColor:JQXXXLZH272727CLOLR andLeftIMG:@"nil" andLeftIMGWidth:0 andNSInteger:2];
//    [self addUnderLV:_currentHeight];
    
    [self addRedPocket];
    _mainScrollerView.contentSize = CGSizeMake(kScreenWidth, _currentHeight);
    
    [self addFooterView];
}
- (void)addFooterView{
    _arriveLcationLab = [[UILabel alloc] initWithFrame:CGRectMake(0,_mainScrollerView.frameMaxY ,kScreenWidth, 20 )];
    _arriveLcationLab.text = [NSString stringWithFormat:@"  送至：%@",_currentModel.address];
    _arriveLcationLab.backgroundColor = JQXXXLZH272727CLOLR;
    _arriveLcationLab.backgroundColor = JQXXXLZHFFFADACLOLR;
    _arriveLcationLab.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:_arriveLcationLab];
    
    UILabel *discountInfoLab = [[UILabel alloc] initWithFrame:CGRectMake(0,_arriveLcationLab.frameMaxY ,kScreenWidth-106, 50 )];
    discountInfoLab.text = [NSString stringWithFormat:@"  待支付 ¥%@ | 优惠 ¥%@",_currentModel.totalAmount,_currentModel.couponAmount];
    discountInfoLab.backgroundColor = JQXXXLZH272727CLOLR;
    discountInfoLab.backgroundColor = JQXXXLZHF4F4F4COLOR;
    discountInfoLab.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:discountInfoLab];
    
    UIButton *okBtn = [[UIButton alloc] initWithFrame:CGRectMake(discountInfoLab.frameMaxX, discountInfoLab.frameOriginY, 106, 50)];
    [okBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [okBtn setTitleColor:JQXXXLZHFFFFFFCLOLR forState:UIControlStateNormal];
    okBtn.contentHorizontalAlignment = 0;
    okBtn.contentVerticalAlignment = 0;
    [okBtn setBackgroundColor:JQXXXLZHFF2D4BCLOLR];
    [[okBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(__kindof UIControl * _Nullable x) {
         //点击提交订单
             [SVProgressHUD show];
             NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
             [dic setObjectSafe:self.shopId forKey:@"shopId"];
             [dic setObjectSafe:_locationID forKey:@"addressId"];
             [[RequestManager sharedInstance]commitOrderWith:dic WhenComplete:^(BOOL succeed, id responseData, NSError *error) {
                 if (succeed) {
                     NSMutableDictionary *paramic = [[NSMutableDictionary alloc] init];
                     [paramic setObjectSafe:[[responseData valueWithNilForKey:@"data"]valueWithNilForKey:@"id"] forKey:@"orderId"];
                     [[RequestManager sharedInstance]getPayOrderWith:paramic WhenComplete:^(BOOL succeed, id responseData, NSError *error) {
                         if (succeed) {
                             [self gotoAliPay:[[responseData valueWithNilForKey:@"data"] valueWithNilForKey:@"alipay"]];
                         }else{
                              [SVProgressHUD showErrorWithStatus:@"提交失败"];
                         }
                     }];
                 }else{
                     [SVProgressHUD showErrorWithStatus:@"提交失败"];

                 }
             }];
     }];
    [self.view addSubview:okBtn];
}
- (void)gotoAliPay:(NSString *)payString{
    NSString *appScheme = @"haixiayuchu";
    [[AlipaySDK defaultService] payOrder:payString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSString  *resultString = resultDic[@"resultStatus"] ;
        if ([resultString isEqualToString:@"9000"]) {
            //支付成功,这里放你们想要的操作
            NSLog(@"成功了");
            [SVProgressHUD showSuccessWithStatus:@"支付成功"];
            [self.navigationController popViewControllerAnimated:NO];
        }
        else{
            NSLog(@"失败了");
            [SVProgressHUD showErrorWithStatus:@"支付失败"];
        }
    }];
}
- (void)payResult:(NSNotification *)noti{
    if ([noti.object isEqualToString:@"1"]) {
        //支付成功
        [self.navigationController popViewControllerAnimated:YES];
    }
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
    _redCountLab.textColor = JQXXXLZHB7B7B7CLOLR;
    _redCountLab.font = [UIFont systemFontOfSize:12];
//    _redCountLab.backgroundColor = JQXXXLZHFF2D4BCLOLR;
    _redCountLab.text = @"暂无可用红包";
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
    UIView *locationV = [[UIView alloc] initWithFrame:CGRectMake(0, _currentHeight, kScreenWidth, 85)];
    locationV.backgroundColor = JQXXXLZHFFFFFFCLOLR;
    locationV.userInteractionEnabled = YES;
    [_mainScrollerView addSubview:locationV];
    _currentHeight += (locationV.frameSizeHeight+6);
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(climpLocationListPage)];
    [locationV addGestureRecognizer:tapGes];
    
    _leftIMGV = [[UIImageView alloc] init];
    _leftIMGV.image = [UIImage imageNamed:@"icon_address11"];
    _leftIMGV.contentMode = UIViewContentModeScaleAspectFit;
    [locationV addSubview:_leftIMGV];
    
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
    
    _rightIMGV = [[UIImageView alloc] init];
    _rightIMGV.image = [UIImage imageNamed:@"icon_forward"];
    [locationV addSubview:_rightIMGV];
    
    //布局
    [_leftIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locationV.mas_left).with.offset(14);
        make.top.equalTo(locationV.mas_top).with.offset(14);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(14);
    }];
    
    [_userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftIMGV.mas_right).with.offset(16);
        make.centerY.equalTo(_leftIMGV.mas_centerY).with.offset(0);
    }];
    
    [_phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userNameLab.mas_right).with.offset(20);
        make.centerY.equalTo(_leftIMGV.mas_centerY).with.offset(0);
    }];
    
    [_detailLocationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userNameLab.mas_left);
        make.top.equalTo(_userNameLab.mas_bottom).with.offset(15);
        make.right.equalTo(locationV.mas_right).with.offset(14);
    }];
    
    [_rightIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(locationV.mas_right).with.offset(-14);
        make.centerY.equalTo(_leftIMGV.mas_centerY).with.offset(0);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(14);
    }];
    
    BOOL isHaveAddress = ![_currentModel.consignee  isEqualToString:@""];
    if (isHaveAddress) {
        [self modifyOrSetValueToLocationView];
    }else{
        _leftIMGV.hidden = YES;
        _rightIMGV.hidden = YES;
        _clickBtn = [[UIButton alloc] initWithFrame:locationV.bounds];
        [locationV addSubview:_clickBtn];
        [_clickBtn setTitle:@"点击选择地址" forState:UIControlStateNormal];
        [_clickBtn setTitleColor:JQXXXLZH272727CLOLR forState:UIControlStateNormal];
        _clickBtn.contentHorizontalAlignment = 0;
        _clickBtn.contentVerticalAlignment = 0;
        _clickBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_clickBtn addTarget:self action:@selector(climpLocationListPage) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
- (void)modifyOrSetValueToLocationView{
    _userNameLab.text = _currentModel.consignee;
    _phoneLab.text = _currentModel.mobile;
    _detailLocationLab.text  = [NSString stringWithFormat:@"%@%@%@%@  %@",_currentModel.provinceName,_currentModel.cityName,_currentModel.districtName,_currentModel.address,_currentModel.hnumber];;
}
- (UIView *)creatView:(NSString *)lefrtTitle andFontSize:(CGFloat)leftFontSize andColor:(UIColor *)leftColor andLeftIMG:(NSString *)lefImgV andLeftIMGWidth:(CGFloat)leftWidth andRightTitle:(NSString *)rightTitle andightFontSize:(CGFloat)rightFontSize andColor:(UIColor *)rightColor andLeftIMG:(NSString *)rightImgV andLeftIMGWidth:(CGFloat)rightWidth andNSInteger:(NSInteger )lab{
    CGFloat viewHeight = 45;
    if (lab == 2 || lab == 3) {
        viewHeight = 65;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, _currentHeight, kScreenWidth, viewHeight)];
    view.backgroundColor = JQXXXLZHFFFFFFCLOLR;
    [_mainScrollerView addSubview:view];
    _currentHeight += view.frameSizeHeight;
    
    UIImageView *leftIMGV = [[UIImageView alloc] init];
    if (lab == 3) {
        [leftIMGV sd_setImageWithURL:[NSURL URLWithString:lefImgV]];
        leftIMGV.contentMode = UIViewContentModeScaleAspectFill;
        leftIMGV.clipsToBounds = YES;
    }else{
        leftIMGV.image = [UIImage imageNamed:lefImgV?lefImgV:@""];
    }
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
        make.left.equalTo(view.mas_left).with.offset(leftMargin);
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
    
    NSMutableArray *titleArr = [[NSMutableArray alloc] init];;
    NSMutableArray *countArr = [[NSMutableArray alloc] init];
    NSMutableArray *priceArr = [[NSMutableArray alloc] init];
    for (DCCGoodsModel *goodModel in _currentModel.goods) {
        [titleArr addSafeObject:goodModel.dishName];
        [countArr addSafeObject:goodModel.num];
        [priceArr addSafeObject:goodModel.payPrice];
    }
    [titleArr addSafeObject:@"餐盒"];
    [countArr addSafeObject:@"1"];
    [priceArr addSafeObject:@"0"];
    [titleArr addSafeObject:@"配送费"];
    [countArr addSafeObject:@""];
    [priceArr addSafeObject:@"0"];
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
    DCCLocationViewController *vc = [[DCCLocationViewController alloc] init];
    vc.isSelected = YES;
    __weak typeof(self) weakSelf = self;
    vc.callBackReturnLocationModel = ^(DCCLocationModel *model) {
        [weakSelf modifyLocationInfo:model];
    };
    [self secondPushToViewcontroller:vc];
}
- (void)modifyLocationInfo:(DCCLocationModel *)model{
    _clickBtn.hidden = YES;
    _leftIMGV.hidden = NO;
    _rightIMGV.hidden = NO;
    _arriveLcationLab.text = [NSString stringWithFormat:@"  送至：%@",model.address];
    _userNameLab.text = model.consignee;
    _phoneLab.text = model.mobile;
    _locationID = model.tid;
    _detailLocationLab.text  =[NSString stringWithFormat:@"%@%@%@%@  %@",model.provinceName,model.cityName,model.districtName ,model.address,model.hnumber];
    CGFloat contentHeight = [self getSpaceLabelHeight:_detailLocationLab.text withFont:[UIFont systemFontOfSize:14] withWidth:_detailLocationLab.frameSizeWidth];
    _detailLocationLab.numberOfLines = 2;
    [_detailLocationLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(contentHeight+4);
    }];

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
- (void)selectTime{
    //选择配送时间
}
- (void)climpRedPage{
    DCCMyRedEnvelopeViewController *vc = [[DCCMyRedEnvelopeViewController alloc] init];
    vc.isSelected = YES;
    [self secondPushToViewcontroller:vc];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
