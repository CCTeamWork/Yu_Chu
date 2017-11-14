//
//  MSUShopCarView.h
//  Yu
//
//  Created by 何龙飞 on 2017/11/3.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MSUDetailModel.h"

@interface MSUShopCarView : UIView

@property (nonatomic , strong) UILabel *numLab;

@property (nonatomic , strong) UIButton *clearBtn;

@property (nonatomic , strong) UITableView *tableView;


@property (nonatomic , strong) NSMutableArray *modelArr;
@property (nonatomic , strong) NSMutableArray *numArr;

@end
