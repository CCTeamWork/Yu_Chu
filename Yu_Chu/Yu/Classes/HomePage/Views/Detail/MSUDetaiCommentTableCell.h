//
//  MSUDetaiCommentTableCell.h
//  Yu
//
//  Created by 何龙飞 on 2017/11/3.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUDetaiCommentTableCell : UITableViewCell

@property (nonatomic , strong) UIButton *iconBtn;

@property (nonatomic , strong) UILabel *nickLab;

@property (nonatomic , strong) UILabel *timeLab;

@property (nonatomic , strong) NSMutableArray *starArr;

@property (nonatomic , strong) UIButton *likeBtn;

@property (nonatomic , strong) UILabel *numLab;

@property (nonatomic , strong) UILabel *contenLab;

@property (nonatomic , strong) UIView *lineView;

@end
