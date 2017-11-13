//
//  DCCShopCarModel.h
//  Yu
//
//  Created by duanchongchong on 2017/11/8.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCCGoodsModel.h"

@interface DCCShopCarModel : NSObject
@property (nonatomic, copy) NSString *shopId;

@property (nonatomic, copy) NSString *shopName;

@property (nonatomic, copy) NSString *totalAmount;

@property (nonatomic, copy) NSString *shopLogo;

@property (nonatomic, strong) NSArray <DCCGoodsModel *>*shopCars;

@end
