//
//  MSUHomeScrollView.h
//  Yu
//
//  Created by 何龙飞 on 2017/11/2.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MSUHomeScrollViewDelegate <NSObject>

- (void)tableViewDidSelect;

@end

@interface MSUHomeScrollView : UIView


@property (nonatomic , weak) id<MSUHomeScrollViewDelegate> delegate;


@property (nonatomic , strong) UITableView *tableView;


@end
