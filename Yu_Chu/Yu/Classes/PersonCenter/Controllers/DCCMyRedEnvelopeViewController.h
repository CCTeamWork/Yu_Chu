//
//  DCCMyRedEnvelopeViewController.h
//  Yu
//
//  Created by duanchongchong on 2017/11/2.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "DCCBaseViewController.h"
@interface DCCMyRedEnvelopeViewController : DCCBaseViewController

@property (nonatomic, assign)BOOL isSelected;

@property (nonatomic, copy)void(^callBackReturnRedModel)();

@end
