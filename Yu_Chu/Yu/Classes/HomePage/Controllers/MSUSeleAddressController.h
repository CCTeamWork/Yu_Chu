//
//  MSUSeleAddressController.h
//  Yu
//
//  Created by 何龙飞 on 2017/10/31.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUSeleAddressController : UIViewController

@property (nonatomic , copy) void (^selectSuccessBlock)(NSString *addressStr,NSNumber *latiNum,NSNumber *longNum);


@end
