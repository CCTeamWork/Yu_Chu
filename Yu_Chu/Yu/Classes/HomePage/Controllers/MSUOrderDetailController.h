//
//  MSUOrderDetailController.h
//  Yu
//
//  Created by 何龙飞 on 2017/11/6.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "MSUDetailModel.h"

@interface MSUOrderDetailController : UIViewController

@property (nonatomic , strong) MSUMenuModel *menuModel;

@property (nonatomic , copy) NSString *payMon;

@property (nonatomic, copy) NSString *dishID;
@end
