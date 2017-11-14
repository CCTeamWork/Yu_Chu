//
//  MSUAllOrderView.h
//  Yu
//
//  Created by 何龙飞 on 2017/11/6.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MSUOrderModel.h"

@protocol MSUAllOrderViewDelegate <NSObject>

- (void)commentClick;

- (void)topTableViewCellDidSelect;

- (void)bottomTableViewCellDidSelect;


@end

@interface MSUAllOrderView : UIView

@property (nonatomic , weak) id<MSUAllOrderViewDelegate> delegate;

@property (nonatomic , strong) UITableView *topTableView;

@property (nonatomic , strong) UITableView *bootomTableView;

@property (nonatomic , strong) NSArray *dataArr;


@end
