//
//  MSUOrderBottomTableCell.h
//  Yu
//
//  Created by 何龙飞 on 2017/11/6.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUOrderBottomTableCell : UITableViewCell

@property (nonatomic , copy) void(^commentBlickBlock)(UIButton *btn);

@property (nonatomic , strong) UIButton *iconBtn;

@property (nonatomic , strong) UILabel *nameLab;

@property (nonatomic , strong) UILabel *statusLab;

@property (nonatomic , strong) UILabel *timeLab;

@property (nonatomic , strong) UILabel *detailLab;

@property (nonatomic , strong) UILabel *priceLab;

@property (nonatomic , strong) UIButton *commentBtn;

@property (nonatomic , strong) UIButton *againBtn;

@end
