//
//  DCCLoginpageViewController.h
//  Yu
//
//  Created by duanchongchong on 2017/11/3.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "DCCBaseViewController.h"

@interface DCCLoginpageViewController : DCCBaseViewController

@property (nonatomic, copy)void(^callBackReturnLoginStatus)(BOOL isLogin);

@end
