//
//  MSUHomeScrollView.h
//  Yu
//
//  Created by 何龙飞 on 2017/11/2.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MSUHomeModel.h"

@protocol MSUHomeScrollViewDelegate <NSObject>

- (void)tableViewDidSelectWithShopID:(NSString *)shopID model:(MSUHomeDataModel *)model;

@end

@interface MSUHomeScrollView : UIView


@property (nonatomic , weak) id<MSUHomeScrollViewDelegate> delegate;


@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) MSUHomeModel *homeModel;

@end
