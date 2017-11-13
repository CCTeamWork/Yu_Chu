//
//  MSUSeleTableView.h
//  Yu
//
//  Created by 何龙飞 on 2017/11/2.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MSUDetailModel.h"

@protocol MSUSeleTableViewDelegate <NSObject>

- (void)seleDelegateToCaculateWithGoodsID:(NSString *)goodId goodsNum:(NSString *)num model:(MSUMenuModel *)model isAdd:(NSInteger)signNum;

- (void)seleRightDelegateToPush;


@end

@interface MSUSeleTableView : UIView

@property (nonatomic , weak) id<MSUSeleTableViewDelegate> delegate;

@property (nonatomic , strong) UITableView *leftTableView;

@property (nonatomic , strong) UITableView *rightTableView;


@property (nonatomic , strong) MSUDetailModel *detailModel;

@end
