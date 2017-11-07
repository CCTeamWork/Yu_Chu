//
//  ChooseLocationVC.m
//  小莱
//
//  Created by jack on 16/7/19.
//  Copyright © 2016年 李丹阳. All rights reserved.
//

#import "ChooseLocationVC.h"
#import <MAMapKit/MAMapKit.h>
#import "MapPoiTableView.h"
#import "SearchResultTable.h"
#import "XLZHHeader.h"

@interface ChooseLocationVC ()<MAMapViewDelegate,MapPoiTableViewDelegate,AMapSearchDelegate,UISearchBarDelegate,SearchResultTableVCDelegate>

@property (nonatomic,weak) UISearchBar *searchBar;

@end

@implementation ChooseLocationVC
{
    MAMapView *_mapView;
    // 地图中心点的标记
    UIImageView *_centerMaker;
    // 地图中心点POI列表
    MapPoiTableView *_tableView;
    // 高德API不支持定位开关，需要自己设置
    UIButton *_locationBtn;
    UIImage *_imageLocated;
    UIImage *_imageNotLocate;
    // 搜索API
    AMapSearchAPI *_searchAPI;
    
    // 第一次定位标记
    BOOL isFirstLocated;
    // 搜索页数
    NSInteger searchPage;
    
    // 禁止连续点击两次
    BOOL _isMapViewRegionChangedFromTableView;

    SearchResultTable *_searchResultTable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = JQXXXLZHF4F4F4COLOR;
    [self initMapView];
    [self initCenterMarker];
    [self initLocationButton];
    [self initTableView];
    [self initSearch];
}

#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    // 首次定位
    if (updatingLocation && !isFirstLocated) {
        [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude)];
        isFirstLocated = YES;
    }
}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (!_isMapViewRegionChangedFromTableView && isFirstLocated) {
        AMapGeoPoint *point = [AMapGeoPoint locationWithLatitude:_mapView.centerCoordinate.latitude longitude:_mapView.centerCoordinate.longitude];
        [self searchReGeocodeWithAMapGeoPoint:point];
        [self searchPoiByAMapGeoPoint:point];
        // 范围移动时当前页面数重置
        searchPage = 1;
        
    }
    _isMapViewRegionChangedFromTableView = NO;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *reuseIndetifier = @"anntationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (!annotationView) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
            annotationView.image = [UIImage imageNamed:@"msg_location"];
            annotationView.centerOffset = CGPointMake(0, -18);
        }
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.showsAccuracyRing = NO;
        [_mapView updateUserLocationRepresentation:pre];
        
        view.calloutOffset = CGPointMake(0, 0);
    }
}

#pragma mark - PlaceAroundTableViewDelegate
- (void)loadMorePOI
{
    searchPage++;
    AMapGeoPoint *point = [AMapGeoPoint locationWithLatitude:_mapView.centerCoordinate.latitude longitude:_mapView.centerCoordinate.longitude];
    [self searchPoiByAMapGeoPoint:point];
}

- (void)setMapCenterWithPOI:(AMapPOI *)point isLocateImageShouldChange:(BOOL)isLocateImageShouldChange
{
    
    // 切换定位图标
    if (isLocateImageShouldChange) {
        [_locationBtn setImage:_imageNotLocate forState:UIControlStateNormal];
    }
    _isMapViewRegionChangedFromTableView = YES;
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(point.location.latitude, point.location.longitude);
    [_mapView setCenterCoordinate:location animated:YES];
}

- (void)setSendButtonEnabledAfterLoadFinished
{
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)setCurrentCity:(NSString *)city
{
   [_searchResultTable setSearchCity:city];
}


#pragma mark - SearchResultTableVCDelegate
- (void)setSelectedLocationWithLocation:(AMapPOI *)poi
{
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(poi.location.latitude,poi.location.longitude) animated:NO];
    
    self.searchBar.text = poi.name;
    [self.searchBar resignFirstResponder];
}
- (void)shouldShowTable:(SearchResultTable *)table{

}


#pragma mark - 初始化
- (void)initMapView
{
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0,44, kScreenWidth, kScreenHeight*6/11)];
    _mapView.delegate = self;
    // 不显示罗盘
    _mapView.showsCompass = NO;
    // 不显示比例尺
    _mapView.showsScale = NO;
    // 地图缩放等级
    _mapView.zoomLevel = 16;
    // 开启定位
    _mapView.showsUserLocation = YES;
    [self.view addSubview:_mapView];
}

- (void)initCenterMarker
{
    UIImage *image = [UIImage imageNamed:@"wateRedBlank"];
    _centerMaker = [[UIImageView alloc] initWithImage:image];
    _centerMaker.frame = CGRectMake(self.view.frame.size.width/2-image.size.width/2, _mapView.bounds.size.height/2-image.size.height, image.size.width, image.size.height);
    _centerMaker.center = CGPointMake(self.view.frame.size.width / 2, (CGRectGetHeight(_mapView.bounds) -  _centerMaker.frame.size.height - 64) * 0.5);
    [self.view addSubview:_centerMaker];
}

- (void)initTableView
{
    _tableView = [[MapPoiTableView alloc] initWithFrame:CGRectMake(0, kScreenHeight*6/11, kScreenWidth, kScreenHeight*5/11)];
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)initLocationButton
{
    _imageLocated = [UIImage imageNamed:@"gpsselected"];
    _imageNotLocate = [UIImage imageNamed:@"gpsnormal"];
    _locationBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(_mapView.bounds)-50, CGRectGetHeight(_mapView.bounds)-50, 40, 40)];
    _locationBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _locationBtn.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    _locationBtn.layer.cornerRadius = 3;
    [_locationBtn addTarget:self action:@selector(actionLocation) forControlEvents:UIControlEventTouchUpInside];
    [_locationBtn setImage:_imageNotLocate forState:UIControlStateNormal];
    [self.view addSubview:_locationBtn];
}

- (void)initSearch
{
    self.view.backgroundColor = JQXXXLZHFFFFFFCLOLR;
    UIView *navV = [[DCCBaseNavgationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, STATUS_AND_NAVIGATION_HEIGHT)];
    navV.backgroundColor = JQXXXLZHF4F4F4COLOR;
    [self.view addSubview:navV];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, 60, 44)];
    [backBtn setImage:[UIImage imageNamed:@"nav_icon_back"] forState:UIControlStateNormal];
    [backBtn setTitle:@"杭州" forState:UIControlStateNormal];
    [backBtn setTitleColor:JQXXXLZH272727CLOLR forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 14, 0, 0);
    backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 22, 0, 0);
    [[backBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         [self dismissBtnAction];
     }];
    [navV addSubview:backBtn];
    
    UIView *searchBackView = [[UIView alloc]initWithFrame:CGRectMake(68, STATUS_BAR_HEIGHT+8, kScreenWidth-68-14, 28)];
    searchBackView.userInteractionEnabled = YES;
    searchBackView.backgroundColor = JQXXXLZHFFFFFFCLOLR;
    searchBackView.clipsToBounds = YES;
    [navV addSubview:searchBackView];
    
    searchPage = 1;
    _searchAPI = [[AMapSearchAPI alloc] init];
    _searchAPI.delegate = _tableView;
    
    _searchResultTable = [[SearchResultTable alloc] init];
    _searchResultTable.mDelegate = self;
    [self.view addSubview:_searchResultTable];
    _searchResultTable.hidden = YES;

    UISearchBar *searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(-30, 0, searchBackView.frameSizeWidth+40, 28)];
    self.searchBar = searchbar;
    searchbar.placeholder = @"      查找小区／大厦等";
    [searchBackView addSubview:searchbar];
    searchbar.delegate = self;
}


-(void)dismissBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Action
- (void)actionLocation
{
    [_mapView setCenterCoordinate:_mapView.userLocation.coordinate animated:YES];
}

// 搜索中心点坐标周围的POI-AMapGeoPoint
- (void)searchPoiByAMapGeoPoint:(AMapGeoPoint *)location
{
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = location;
    // 搜索半径
    request.radius = 1000;
    // 搜索结果排序
    request.sortrule = 1;
    // 当前页数
    request.page = searchPage;
    [_searchAPI AMapPOIAroundSearch:request];
    
}

// 搜索逆向地理编码-AMapGeoPoint
- (void)searchReGeocodeWithAMapGeoPoint:(AMapGeoPoint *)location
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = location;
    // 返回扩展信息
    regeo.requireExtension = YES;
    [_searchAPI AMapReGoecodeSearch:regeo];
}



- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    _searchResultTable.frame = CGRectMake(0, 64, self.view.frameSizeWidth, self.view.frameSizeHeight);
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
#pragma mark - UISearchBar
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length > 0) {
        _searchResultTable.hidden = NO;
        [_searchResultTable searchWithText:searchText];
    }else{
        _searchResultTable.hidden = YES;
    }
}

@end
