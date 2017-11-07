//
//  SearchResultTableVC.h
//  小莱
//
//  Created by jack on 16/7/19.
//  Copyright © 2016年 李丹阳. All rights reserved.
//

#import <UIKit/UIKit.h>


@class AMapPOI,SearchResultTable;

@protocol SearchResultTableVCDelegate <NSObject>

- (void)setSelectedLocationWithLocation:(AMapPOI *)poi;
- (void)shouldShowTable:(SearchResultTable *)table;

@end

@interface SearchResultTable : UITableView

- (void)setSearchCity:(NSString *)city;

@property (nonatomic, weak) id<SearchResultTableVCDelegate> mDelegate;
- (void)searchWithText:(NSString *)text;
@end
