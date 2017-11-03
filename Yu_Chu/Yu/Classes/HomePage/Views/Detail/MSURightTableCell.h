//
//  MSURightTableCell.h
//  Yu
//
//  Created by 何龙飞 on 2017/11/2.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSURightTableCell : UITableViewCell

@property (nonatomic , copy) void(^addClickBlock)(UIButton *btn);
@property (nonatomic , copy) void(^deleClickBlock)(UIButton *btn);

@property (nonatomic , strong) UIImageView *shopImaView;

@property (nonatomic , strong) UILabel *nameLab;

@property (nonatomic , strong) UILabel *introLab;

@property (nonatomic , strong) UILabel *priceLab;

@property (nonatomic , strong) UIButton *addBtn;

@property (nonatomic , strong) UIButton *deleBtn;

@property (nonatomic , strong) UILabel *numLab;



@end
