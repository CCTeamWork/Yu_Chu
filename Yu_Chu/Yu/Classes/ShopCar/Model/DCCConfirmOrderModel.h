//
//  DCCConfirmOrderModel.h
//  Yu
//
//  Created by duanchongchong on 2017/11/9.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCCGoodsModel.h"

@interface DCCConfirmOrderModel : NSObject

@property (nonatomic, copy) NSString *hnumber;

@property (nonatomic, copy) NSString *shopId;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *shopName;

@property (nonatomic, copy) NSString *orderSn;

@property (nonatomic, copy) NSString *realityAmount;

@property (nonatomic, copy) NSString *totalAmount;

@property (nonatomic, copy) NSString *shipmentFee;

@property (nonatomic, copy) NSString *shipmentType;

@property (nonatomic, copy) NSString *addressId;

@property (nonatomic, copy) NSString *consignee;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *tradeSn;

@property (nonatomic, copy) NSString *remarks;

@property (nonatomic, copy) NSString *paymentType;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *commentStatus;

@property (nonatomic, copy) NSString *extendDays;

@property (nonatomic, copy) NSString *isValid;

@property (nonatomic, copy) NSString *statusRemark;

@property (nonatomic, copy) NSString *couponAmount;

@property (nonatomic, copy) NSString *shipmentsTime;

@property (nonatomic, copy) NSString *extendInfo;

@property (nonatomic, copy) NSString *allowRefund;

@property (nonatomic, strong) NSArray <DCCGoodsModel *>*goods;

@end
