//
//  MSUDetailDeModel.h
//  Yu
//
//  Created by yl20027 on 2017/11/14.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MSUDataDetailOrModel;
@class MSUGoodsDetailModel;

@interface MSUDetailDeModel : NSObject

@property (nonatomic , copy) NSString *code;

@property (nonatomic , strong) MSUDataDetailOrModel *data;

@property (nonatomic , copy) NSString *message;

@property (nonatomic , copy) NSString *success;

@end

@interface MSUDataDetailOrModel : NSObject



@property (nonatomic , copy) NSString *avatar;
@property (nonatomic , copy) NSString *_id;
@property (nonatomic , copy) NSString *shopId;
@property (nonatomic , copy) NSString *shopName;
@property (nonatomic , copy) NSString *shopLogo;
@property (nonatomic , copy) NSString *memberId;
@property (nonatomic , copy) NSString *nickname;
@property (nonatomic , copy) NSString *orderSn;
@property (nonatomic , copy) NSString *realityAmount;
@property (nonatomic , copy) NSString *totalAmount;
@property (nonatomic , copy) NSString *shipmentFee;
@property (nonatomic , copy) NSString *shipmentType;
@property (nonatomic , copy) NSString *addressId;
@property (nonatomic , copy) NSString *consignee;
@property (nonatomic , copy) NSString *mobile;
@property (nonatomic , copy) NSString *country;
@property (nonatomic , copy) NSString *province;
@property (nonatomic , copy) NSString *city;
@property (nonatomic , copy) NSString *district;
@property (nonatomic , copy) NSString *countryName;
@property (nonatomic , copy) NSString *provinceName;
@property (nonatomic , copy) NSString *cityName;
@property (nonatomic , copy) NSString *districtName;
@property (nonatomic , copy) NSString *address;
@property (nonatomic , copy) NSString *zipcode;
@property (nonatomic , copy) NSString *tradeSn;
@property (nonatomic , copy) NSString *remarks;
@property (nonatomic , copy) NSString *paymentType;

@property (nonatomic , copy) NSString *status;
@property (nonatomic , copy) NSString *commentStatus;
@property (nonatomic , copy) NSString *extendDays;
@property (nonatomic , copy) NSString *isValid;
@property (nonatomic , copy) NSString *statusRemark;
@property (nonatomic , copy) NSString *explain;
@property (nonatomic , copy) NSString *allowRefund;
@property (nonatomic , copy) NSString *extendInfo;
@property (nonatomic , copy) NSString *payTime;
@property (nonatomic , copy) NSString *finishedTime;
@property (nonatomic , copy) NSString *shipmentsTime;
@property (nonatomic , copy) NSString *isDeleted;
@property (nonatomic , copy) NSString *couponAmount;
@property (nonatomic , copy) NSString *createdTime;
@property (nonatomic , copy) NSString *expireTime;
@property (nonatomic , copy) NSString *dinnerTime;
@property (nonatomic , copy) NSArray<MSUGoodsDetailModel *> *goods;
@property (nonatomic , copy) NSString *hnumber;

@end

@interface MSUGoodsDetailModel : NSObject

@property (nonatomic , copy) NSString *_id;
@property (nonatomic , copy) NSString *orderId;
@property (nonatomic , copy) NSString *memberId;
@property (nonatomic , copy) NSString *dishId;
@property (nonatomic , copy) NSString *dishName;
@property (nonatomic , copy) NSString *dishImg;
@property (nonatomic , copy) NSString *num;
@property (nonatomic , copy) NSString *price;
@property (nonatomic , copy) NSString *payPrice;
@property (nonatomic , copy) NSString *props;
@property (nonatomic , copy) NSString *pinkage;
@property (nonatomic , copy) NSString *postage;
@property (nonatomic , copy) NSString *addFee;
@property (nonatomic , copy) NSString *status;
@property (nonatomic , copy) NSString *addtime;

@end
