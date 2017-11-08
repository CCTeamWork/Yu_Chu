//
//  MapPoiTableView.h
//  小莱
//
//  Created by jack on 16/7/19.
//  Copyright © 2016年 李丹阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@protocol MapPoiTableViewDelegate <NSObject>

// 加载更多列表数据
- (void)loadMorePOI;
// 将地图中心移到所选的POI位置上
- (void)setMapCenterWithPOI:(AMapPOI *)point isLocateImageShouldChange:(BOOL)isLocateImageShouldChange;
// 加载完成设置发送按钮可点击
- (void)setSendButtonEnabledAfterLoadFinished;
// 设置当前位置所在城市
- (void)setCurrentCity:(NSString *)city;

@end

@interface MapPoiTableView : UIView <UITableViewDelegate,UITableViewDataSource,AMapSearchDelegate>

@property (nonatomic, weak) id<MapPoiTableViewDelegate> delegate;
// 选中的POI点
@property (nonatomic, strong) AMapPOI *selectedPoi;


@end

