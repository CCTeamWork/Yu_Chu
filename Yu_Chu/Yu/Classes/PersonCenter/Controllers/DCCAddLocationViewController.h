//
//  DCCAddLocationViewController.h
//  Yu
//
//  Created by duanchongchong on 2017/11/3.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "DCCBaseViewController.h"

@interface DCCAddLocationViewController : DCCBaseViewController

@property (nonatomic, assign) BOOL isEdit;//默认是NO

@property (nonatomic, copy) void(^callBackAndRefreshPage)();

@end
