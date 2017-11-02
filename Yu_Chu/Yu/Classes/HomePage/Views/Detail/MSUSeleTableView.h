//
//  MSUSeleTableView.h
//  Yu
//
//  Created by 何龙飞 on 2017/11/2.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUSeleTableView : UIView

@property (nonatomic , strong) UITableView *leftTableView;

@property (nonatomic , strong) UITableView *rightTableView;

@property (nonatomic , strong) NSArray *sectionArr;

@end
