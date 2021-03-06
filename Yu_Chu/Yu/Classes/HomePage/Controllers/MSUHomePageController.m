//
//  MSUHomePageController.m
//  Yu
//
//  Created by 何龙飞 on 2017/10/31.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUHomePageController.h"
#import "MSUSeleAddressController.h"
#import "MSUShopDetailController.h"

#import "MSUHomeScrollView.h"

#import "MSUPrefixHeader.pch"
#import "MSUHomeNavView.h"
#import "MSUAFNRequest.h"
#import "MSUNoDataView.h"

/* 地图框架 */
#import <CoreLocation/CoreLocation.h>
#import "TQLocationConverter.h"
#import "ZCChinaLocation.h"

#import "MSUHomeModel.h"

@interface MSUHomePageController ()<MSUHomeScrollViewDelegate,CLLocationManagerDelegate>

@property (nonatomic , strong) MSUHomeNavView *nav;

/// 定位
@property (nonatomic , strong) CLLocationManager *locationManager;
/// 得到当前位置的经纬度
@property (nonatomic , assign) CLLocationCoordinate2D curCoordinate2D;
@property (nonatomic , strong) NSNumber *latiNum;
@property (nonatomic , strong) NSNumber *longNum;

@property (nonatomic , strong) MSUHomeScrollView *scrolleView;
@property (nonatomic , strong) MSUNoDataView *noDataView;

@end

@implementation MSUHomePageController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /// 状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    

    NSLog(@" %@,%@",self.latiNum,self.longNum);
    if (self.latiNum) {
        [self loadRequest];
    }


}

- (void)loadRequest
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"dccLoginToken"];
    if (!token) {
        token = @"";
    }
    
    NSDictionary *dic = @{@"token":token,@"latitude":self.latiNum,@"longitude":self.longNum};
    NSLog(@"--- dic %@",dic);
    [[MSUAFNRequest sharedInstance] postRequestWithURL:@"http://192.168.10.21:8202/member/shop/nearbyShop" parameters:dic withBlock:^(id obj, NSError *error) {
        if (obj) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingMutableLeaves error:nil];
            if (!error) {
                NSLog(@"访问成功%@",jsonDict);
                if([jsonDict[@"code"] isEqualToString:@"200"]){
                    MSUHomeModel *homeModel = [MSUHomeModel mj_objectWithKeyValues:jsonDict];
                    if (homeModel.data.count > 0) {
                        self.scrolleView.hidden = NO;
                        self.noDataView.hidden = YES;
                        self.scrolleView.homeModel = homeModel;
                    } else{
                        self.noDataView.hidden = NO;
                        self.scrolleView.hidden = YES;
                    }
                    
                } else{
                    self.noDataView.hidden = NO;
                    self.scrolleView.hidden = YES;
                }
                
            }else{
                NSLog(@"访问报错%@",error);
            }

        } else{
            [MSUHUD showFileWithString:@"服务器请求为空"];
        }
       
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = REDCOLOR;
    
    self.nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:0];
    [self.view addSubview:_nav];
    [_nav.LocationBtn addTarget:self action:@selector(locationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-49)];
    bgView.backgroundColor = HEXCOLOR(0xf0f0f0);
    [self.view addSubview:bgView];
 
    
    // 定位初始化
    [self locationInit];
    // 后台进入前台 通知 （此处通知是为了 用户跳往设置打开定位允许回到APP页面后，自动刷新定位城市）
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ApplicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    
    NSString *city;
    //取出存值，判断是否第一次进入 如果第一次进入 city默认为上海 ；如果不是第一次进入 city为上次定位位置
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"city"]) {
        city = [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
    }else{
        city = @"上海";
    }
//    [_nav.LocationBtn setTitle:city forState:UIControlStateNormal];
    _nav.LocationLab.text = city;
}

- (void)ApplicationDidBecomeActive:(NSNotification *)noti{
    NSLog(@"由后台进入前台");
    // 判断是否定位权限被允许 ，此处为未允许
    if (!([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined)) {
        // 判断是否 city是否被存储 ，此处为未存储
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"city"]) {
            [self locationInit];
        }
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 视图相关
// 定位初始化
- (void)locationInit{
    NSLog(@"定位初始化");
    //定位管理器
    self.locationManager = [[CLLocationManager alloc]init];
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined ){
        [_locationManager requestWhenInUseAuthorization];
    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
        //设置代理
        _locationManager.delegate = self;
        //设置定位精度
        //        [self.locationManager setAllowsBackgroundLocationUpdates:YES];
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        _locationManager.pausesLocationUpdatesAutomatically = NO;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance = 100;
        _locationManager.distanceFilter=distance;
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
        
        //重大位置变化通知
        //        [_locationManager startMonitoringSignificantLocationChanges];
    }
}


#pragma mark - 点击事件
- (void)locationBtnClick:(UIButton *)sender{
    self.hidesBottomBarWhenPushed = YES;
    MSUSeleAddressController *sele = [[MSUSeleAddressController alloc] init];
    __weak typeof(self) weakSelf = self;
    sele.selectSuccessBlock = ^(NSString *addressStr,NSNumber *latiNum,NSNumber *longnum) {
        __strong typeof(weakSelf) strongSelf = weakSelf;

        if (addressStr.length > 0) {
//            [strongSelf.nav.LocationBtn setTitle:addressStr forState:UIControlStateNormal];
            strongSelf.nav.LocationLab.text = addressStr;

            strongSelf.latiNum = latiNum;
            strongSelf.longNum = longnum;
            [[NSUserDefaults standardUserDefaults] setObject:addressStr forKey:@"city"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    };
    [self.navigationController pushViewController:sele animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


#pragma mark - 代理
- (void)tableViewDidSelectWithShopID:(NSString *)shopID model:(MSUHomeDataModel *)model{
    self.hidesBottomBarWhenPushed = YES;
    MSUShopDetailController *detail = [[MSUShopDetailController alloc] init];
    detail.shopID = shopID;
    detail.intro = model.remarks;
    detail.sendMoney = model.minSendFee;
    detail.payMon = model.shipmentFee;
    detail.iconStr =  model.logo;
    detail.shopName = model.name;
    [self.navigationController pushViewController:detail animated:YES];
    self.hidesBottomBarWhenPushed = NO;;
}

/*  定位代理 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *currentLoction = [locations lastObject];
    /// 得到当前位置的经纬度
    self.curCoordinate2D = currentLoction.coordinate;
    //    NSLog(@"定位直接得到的坐标===%f  %f",_curCoordinate2D.latitude,_curCoordinate2D.longitude);
    [self.locationManager stopUpdatingLocation];
    
    /// 判断当前坐标是否在中国
    BOOL isChina = [[ZCChinaLocation shared] isInsideChina:(CLLocationCoordinate2D){_curCoordinate2D.latitude,_curCoordinate2D.longitude}];
    if (isChina) {
        /// 转换坐标 不转换会出现偏移
        _curCoordinate2D = [TQLocationConverter transformFromWGSToGCJ:_curCoordinate2D];
        
        //获得地理位置名字
        [self googleMapAddress];
    }
    
}

// 获得地理位置名字
- (NSString *)googleMapAddress{
    __block NSString *addressStr;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:_curCoordinate2D.latitude longitude:_curCoordinate2D.longitude];
    self.latiNum = [NSNumber numberWithDouble:_curCoordinate2D.latitude];
    self.longNum = [NSNumber numberWithDouble:_curCoordinate2D.longitude];
    if (self.latiNum) {
        [self loadRequest];
    }
    //    NSLog(@"转换后得到的坐标===%f  %f",_curCoordinate2D.latitude,_curCoordinate2D.longitude);
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error || placemarks.count == 0) {
            addressStr = @"";
            NSLog(@"获取定理位置失败");
        }else{
            addressStr = [placemarks firstObject].locality;

            //            NSLog(@"------------ %@",addressStr);
            NSString *locationCity = [NSString stringWithFormat:@"%@",[placemarks firstObject].thoroughfare];
//            [_nav.LocationBtn setTitle:locationCity forState:UIControlStateNormal];
            _nav.LocationLab.text = locationCity;

            //存储city  用以判断下次app进入city默认显示值
            [[NSUserDefaults standardUserDefaults] setObject:locationCity forKey:@"city"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];
    return addressStr;
}


#pragma mark - 初始化
- (MSUHomeScrollView *)scrolleView{
    if (!_scrolleView) {
       _scrolleView = [[MSUHomeScrollView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-49)];
        [self.view addSubview:_scrolleView];
        _scrolleView.delegate = self;
    }
    return _scrolleView;
}

- (MSUNoDataView *)noDataView{
    if(!_noDataView){
        _noDataView = [[MSUNoDataView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-49)];
        [self.view addSubview:_noDataView];
        _noDataView.backgroundColor = HEXCOLOR(0xf0f0f0);
    }
    return _noDataView;
}

@end
