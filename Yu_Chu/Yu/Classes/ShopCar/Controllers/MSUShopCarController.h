//
//  MSUShopCarController.h
//  Yu
//
//  Created by DCC on 2017/10/31.
//  Copyright © 2017年 DCC. All rights reserved.
//

#import "DCCBaseViewController.h"

@interface MSUShopCarController : DCCBaseViewController

@property (nonatomic, copy)void (^callBackClimpShopOwnerORDetail)(NSInteger lab);//lab==0跳转到商家 

@end
