//
//  MSUCarTableCell.h
//  Yu
//
//  Created by 何龙飞 on 2017/11/3.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUCarTableCell : UITableViewCell

@property (nonatomic , copy) void(^addBlock)(UIButton *btn);
@property (nonatomic , copy) void(^deleBlock)(UIButton *btn);


@property (nonatomic , strong) UILabel *nameLab;

@property (nonatomic , strong) UILabel *introLab;

@property (nonatomic , strong) UILabel *priceLab;

@property (nonatomic , strong) UIButton *deleBtn;

@property (nonatomic , strong) UIButton *addBtn;

@property (nonatomic , strong) UILabel *numLab;

@end
