//
//  MSUHomeNavView.h
//  Yu
//
//  Created by 何龙飞 on 2017/10/31.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUHomeNavView : UIView


/// 定位位置按钮
@property (nonatomic , strong) UIButton *LocationBtn;
@property (nonatomic , strong) UILabel *LocationLab;

/// 返回箭头按钮
@property (nonatomic , strong) UIButton *backArrowBtn;
/// 中间内容
@property (nonatomic , strong) UILabel *titeleLab;
/// 地图按钮
@property (nonatomic , strong) UIButton *positionBtn;
@property (nonatomic , strong) UIButton *homeSearchBtn;


/// 初始化
- (instancetype)initWithFrame:(CGRect)frame showNavWithNumber:(NSInteger)number;


@end
