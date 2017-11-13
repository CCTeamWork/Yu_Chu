//
//  MSUDetailCommentView.h
//  Yu
//
//  Created by 何龙飞 on 2017/11/3.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "MSUCommentModel.h"
@interface MSUDetailCommentView : UIView


@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) MSUDataModel *commentModel;

@end
