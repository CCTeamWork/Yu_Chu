//
//  DCCShoppingCarTableViewCell.h
//  Yu
//
//  Created by duanchongchong on 2017/11/4.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCCShopCarModel.h"

@interface DCCShoppingCarTableViewCell : UITableViewCell

@property(nonatomic, strong) UIButton *removeBtn;

@property(nonatomic, strong) UIButton *commitBtn;

-(void)initAllData:(DCCShopCarModel *)model;

@end
