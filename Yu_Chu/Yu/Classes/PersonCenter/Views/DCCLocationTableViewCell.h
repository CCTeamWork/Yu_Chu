//
//  DCCLocationTableViewCell.h
//  Yu
//
//  Created by duanchongchong on 2017/11/3.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCCLocationModel.h"

@interface DCCLocationTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *editBtn;;

- (void)initAllDataWith:(DCCLocationModel *)model;

@end
