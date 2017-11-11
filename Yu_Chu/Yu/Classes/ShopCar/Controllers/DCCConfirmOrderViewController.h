//
//  DCCConfirmOrderViewController.h
//  Yu
//
//  Created by duanchongchong on 2017/11/6.
//  Copyright © 2017年 DCC. All rights reserved.
//

#import "DCCBaseViewController.h"


@interface DCCConfirmOrderViewController : DCCBaseViewController

@property (nonatomic, copy) NSString *shopId;//跳转本页面，一定要传shopID 否则会抛出异常

@property (nonatomic, copy) NSString *shopName;

@end
