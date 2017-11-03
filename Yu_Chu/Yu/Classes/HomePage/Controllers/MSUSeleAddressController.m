//
//  MSUSeleAddressController.m
//  Yu
//
//  Created by 何龙飞 on 2017/10/31.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUSeleAddressController.h"


#import "MSUSeleLocaView.h"

#import "MSUPrefixHeader.pch"
#import "MSUHomeNavView.h"
#import "MSUPathTools.h"
#import "MSUStringTools.h"

//#import <BaiduMapKit/BaiduMapAPI_Map/BMKMapView.h> //mapview 显示相关
//#import <BaiduMapKit/BaiduMapAPI_Location/BMKLocationService.h> //定位相关
//#import <BaiduMapAPI_Search/BMKGeocodeSearch.h> //geo编码和反geo编码相关
//#import <BaiduMapAPI_Search/BMKPoiSearchType.h> //定位信息相关
//#import <BaiduMapAPI_Search/BMKSuggestionSearch.h>
#import <BaiduMapAPI/BMapKit.h>

@interface MSUSeleAddressController ()<UIScrollViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UITableViewDelegate,UITableViewDataSource,BMKMapViewDelegate,BMKSuggestionSearchDelegate,UISearchBarDelegate>
{
    BOOL isFirstLocation;
}


@property (nonatomic , strong) UIScrollView *scrollView;

@property (nonatomic , strong) UIView *shareShadowView;
@property (nonatomic , strong) UIView *searchView;
/// 搜索框按钮
@property (nonatomic , strong) UISearchBar *search;
@property(nonatomic,strong)BMKMapView* mapView;
@property(nonatomic,strong)BMKLocationService* localService;
@property(nonatomic,strong)BMKGeoCodeSearch* geocodesearch;
@property (nonatomic , strong) BMKSuggestionSearch *searcher;

@property(nonatomic,assign)NSInteger currentSelectLocationIndex;
@property(nonatomic,assign)CLLocationCoordinate2D currentCoordinate;

@property (nonatomic , copy)NSString *cityName;
//数据源
@property (nonatomic , strong) UITableView *sugeTableView;
@property (nonatomic , strong) NSMutableArray *dataList;
@property (nonatomic , strong) NSMutableArray *cityList;
@property (nonatomic , strong) NSMutableArray *districtList;

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *dataArr;

@property (nonatomic , strong) MSUSeleLocaView *locaView;

@end

@implementation MSUSeleAddressController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = REDCOLOR;
    
    MSUHomeNavView *nav = [[MSUHomeNavView alloc] initWithFrame:NavRect showNavWithNumber:1];
    [self.view addSubview:nav];
    [nav.backArrowBtn addTarget:self action:@selector(backArrowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
    _scrollView.backgroundColor  = HEXCOLOR(0xffffff);
    _scrollView.scrollEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_scrollView];
    
    [self createTopView];
    
    // 定位初始化
    self.localService = [[BMKLocationService alloc] init];
    _localService.delegate = self;
    [_localService startUserLocationService];
    
    //geo编码相关
    self.geocodesearch = [[BMKGeoCodeSearch alloc] init];
    _geocodesearch.delegate = self;
    
    //初始化tableview列表
    self.dataArr = [NSMutableArray array];
}

-(void)viewWillAppear:(BOOL)animated
{
    /// 状态栏字体颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.localService.delegate = self;
    self.geocodesearch.delegate = self;
    self.searcher.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    self.localService.delegate = nil;
    self.geocodesearch.delegate = nil;
    self.searcher.delegate = nil;
}

- (void)dealloc
{
    if (_mapView)
    {
        _mapView = nil;
    }
    if (_geocodesearch)
    {
        _geocodesearch = nil;
    }
    if (_localService)
    {
        _localService = nil;
    }
}



#pragma mark - 视图相关
- (void)createTopView{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = HEXCOLOR(0xffffff);
    bgView.frame = CGRectMake(0, 0, WIDTH, 39+23);
    [_scrollView addSubview:bgView];
    
    UIImageView *imaView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 6, WIDTH-28, 33)];
    imaView.image = [MSUPathTools showImageWithContentOfFileByName:@"address_frame"];
    imaView.backgroundColor = HEXCOLOR(0xf2f2f2);
    [bgView addSubview:imaView];

    UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bgBtn.backgroundColor = [UIColor clearColor];
    [bgView addSubview:bgBtn];
    bgBtn.frame = CGRectMake(0, 0, WIDTH, 39);
    [bgBtn addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.locaView= [[MSUSeleLocaView alloc] initWithFrame:CGRectMake(0, 62, WIDTH, 170)];
    _locaView.backgroundColor = HEXCOLOR(0xffffff);
    [_scrollView addSubview:_locaView];
}


#pragma mark - 搜索框代理
/* 搜索框代理 */
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText && searchText.length>0) {
        self.sugeTableView.hidden = NO;
    }else{
        self.sugeTableView.hidden = YES;
    }
    
    BMKSuggestionSearchOption *option = [[BMKSuggestionSearchOption alloc] init];
    option.keyword = searchText;
    option.cityname = self.cityName;
    NSLog(@"城市---%@",self.cityName);
    BOOL flag = [self.searcher suggestionSearch:option];
    if(flag)
    {
        NSLog(@"建议检索发送成功");
    }
    else
    {
        NSLog(@"建议检索发送失败");
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_search resignFirstResponder];
}

#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _sugeTableView) {
        return self.dataList.count;
    }else{
        return self.dataArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _sugeTableView) {
        static NSString *cellID = @"poiCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        
        if (self.dataList && self.dataList.count>0) {
            cell.textLabel.text = self.dataList[indexPath.row];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@",self.cityList[indexPath.row],self.districtList[indexPath.row]];
            cell.detailTextLabel.textColor = [UIColor grayColor];
        }
        
        return cell;
    } else{
        static NSString *cellID = @"haha";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        
        BMKPoiInfo *model=[self.dataArr objectAtIndex:indexPath.row];
        cell.textLabel.text=model.name;
        cell.detailTextLabel.text=model.address;
        cell.detailTextLabel.textColor=[UIColor grayColor];
        //    if (self.currentSelectLocationIndex==indexPath.row){
        //        cell.accessoryType=UITableViewCellAccessoryCheckmark;
        //    }
        //    else{
        //        cell.accessoryType=UITableViewCellAccessoryNone;
        //    }
        return cell;

    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableView) {
//        [_search resignFirstResponder];
//        _search.text = @"";
//        _tableView.hidden = YES;
//        
//        BMKGeoCodeSearchOption *option = [[BMKGeoCodeSearchOption alloc] init];
//        option.city = self.cityList[indexPath.row];
//        option.address = self.dataList[indexPath.row];
//        BOOL flag = [_geocodesearch geoCode:option];
//        if(flag)
//        {
//            NSLog(@"geo检索发送成功");
//        }
//        else
//        {
//            NSLog(@"geo检索发送失败");
//        }
        if (self.selectSuccessBlock) {
            self.selectSuccessBlock(self.dataArr[indexPath.row]);
        }
        
    } else{
        if (self.selectSuccessBlock) {
            self.selectSuccessBlock(self.dataArr[indexPath.row]);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)setCurrentCoordinate:(CLLocationCoordinate2D)currentCoordinate{
    _currentCoordinate=currentCoordinate;
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = currentCoordinate;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    
}


#pragma mark - 地图代理相关

/**
 *在地图View将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [self.mapView updateLocationData:userLocation];
    //    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    isFirstLocation=NO;
    [self.mapView  updateLocationData:userLocation];
    self.currentCoordinate = userLocation.location.coordinate;
    
    NSLog(@"地理位置信息 %f %f",self.currentCoordinate.latitude,self.currentCoordinate.longitude);
    
    if (self.currentCoordinate.latitude!=0)
    {
        [self.localService stopUserLocationService];
    }
}

/**
 *在地图View停止定位后，会调用此函数
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
    
}

#pragma mark - BMKGeoCodeSearchDelegate

/**
 *返回地址信息搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结BMKGeoCodeSearch果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSLog(@"返回地址信息搜索结果,失败-------------");
}

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR)
    {
        [self.dataArr removeAllObjects];
        [self.dataArr addObjectsFromArray:result.poiList];
        
        
        NSLog(@"--   %@",result.address);
//        NSString *cityStr = [result.address substringToIndex:6];
        [self.locaView.addreBtn setTitle:result.address forState:UIControlStateNormal];
        CGSize sizea = [MSUStringTools danamicGetWidthFromText:result.address WithFont:16];
        [self.locaView.addreBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_locaView.top).offset(34);
            make.left.equalTo(_locaView.left).offset(14);
            make.width.equalTo(sizea.width+30);
            make.height.equalTo(20);
        }];
        
        if (isFirstLocation)
        {
            //把当前定位信息自定义组装 放进数组首位
            BMKPoiInfo *first =[[BMKPoiInfo alloc]init];
            first.address=result.address;
            first.name=@"[当前位置]";
            first.pt=result.location;
            first.city=result.addressDetail.city;
            [self.dataArr insertObject:first atIndex:0];
        }
        
        [self.tableView reloadData];
        
    }
}

- (void)onGetSuggestionResult:(BMKSuggestionSearch *)searcher result:(BMKSuggestionResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        NSLog(@"成功");
        self.dataList = [NSMutableArray arrayWithArray:result.keyList];
        self.cityList = [NSMutableArray arrayWithArray:result.cityList];
        self.districtList = [NSMutableArray arrayWithArray:result.districtList];
        
        [self.sugeTableView reloadData];
    }else{
        NSLog(@"失败");
    }
}

#pragma mark - 点击事件
- (void)bgBtnClick:(UIButton *)sender{
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollView.contentOffset = CGPointMake(0, 40);
        self.shareShadowView.hidden = NO;
        self.searchView.hidden = NO;
        [_search becomeFirstResponder];
    }];
   
}

- (void)cancelBtnClick:(UIButton *)sender{
    [UIView animateWithDuration:0.25 animations:^{
        self.sugeTableView.hidden = YES;
        self.shareShadowView.hidden = YES;
        self.scrollView.contentOffset = CGPointMake(0, 0);
        [self.view endEditing:YES];
    }];

}

- (void)backArrowBtnClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 初始化
- (UIView *)shareShadowView{
    if (!_shareShadowView) {
        self.shareShadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT)];
        _shareShadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self.view addSubview:_shareShadowView];
        _shareShadowView.hidden = YES;
    }
    return _shareShadowView;
}

- (UIView *)searchView{
    if (!_searchView) {
        self.searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
        [self.shareShadowView addSubview:_searchView];
        _searchView.backgroundColor = HEXCOLOR(0xffffff);
        
        /// 搜索框
        self.search = [[UISearchBar alloc]initWithFrame:CGRectMake(10, 3, WIDTH-40-14-10, 34)];
        _search.placeholder =  @"搜索收货地址";
        _search.backgroundImage = [self imageWithColor:WHITECOLOR size:_search.bounds.size];
        _search.layer.borderColor = HEXCOLOR(0xf4f4f4).CGColor;
        _search.layer.borderWidth = 2;
        _search.layer.cornerRadius = 7;
        _search.clipsToBounds = YES;
        _search.delegate = self;
        [_searchView addSubview:_search];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchView addSubview:cancelBtn];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        cancelBtn.frame = CGRectMake(WIDTH-30-14, 6, 30, 30);
        [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchView;
}

/** 搜索框背景图片的封装方法 */
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect recte = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(recte.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, recte);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 300, WIDTH, HEIGHT-300) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_scrollView addSubview:_tableView];
    }
    return _tableView;
}

- (UITableView *)sugeTableView{
    if (!_sugeTableView) {
        self.sugeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT-60) style:UITableViewStylePlain];
        _sugeTableView.backgroundColor = HEXCOLOR(0xffffff);
        _sugeTableView.dataSource = self;
        _sugeTableView.delegate = self;
        [self.view addSubview:_sugeTableView];
        _sugeTableView.hidden = YES;
        _sugeTableView.rowHeight = 50;
    }
    return _sugeTableView;
}

- (BMKSuggestionSearch *)searcher{
    if (_searcher == nil) {
        _searcher = [[BMKSuggestionSearch alloc] init];
    }
    return _searcher;
}

@end
