//
//  DCCOrderModel.h
//  Yu
//
//  Created by duanchongchong on 2017/11/13.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCCGoodsModel.h"

@interface DCCOrderModel : NSObject

@property (nonatomic, copy) NSString *shopId;

@property (nonatomic, copy) NSString *shopName;

@property (nonatomic, copy) NSString *logo;

@property (nonatomic, copy) NSString *orderSn;

@property (nonatomic, copy) NSString *realityAmount;

@property (nonatomic, copy) NSString *totalAmount;

@property (nonatomic, copy) NSString *addressId;

@property (nonatomic, copy) NSString *countryName;

@property (nonatomic, copy) NSString *provinceName;

@property (nonatomic, copy) NSString *city_name;

@property (nonatomic, copy) NSString *districtName;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *expireTime;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *createdTime;

@property (nonatomic, strong) NSArray <DCCGoodsModel *>*goods;

@end
