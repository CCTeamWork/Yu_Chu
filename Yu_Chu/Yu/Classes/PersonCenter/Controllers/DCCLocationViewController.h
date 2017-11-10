//
//  DCCLocationViewController.h
//  Yu
//
//  Created by duanchongchong on 2017/11/3.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "DCCBaseViewController.h"
#import "DCCLocationModel.h"

@interface DCCLocationViewController : DCCBaseViewController


@property (nonatomic, assign)BOOL isSelected;

@property (nonatomic, copy)void(^callBackReturnLocationModel)(DCCLocationModel *model);

@end
