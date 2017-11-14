//
//  MSUOrderModel.h
//  Yu
//
//  Created by yl20027 on 2017/11/14.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MSUDataOrderModel;
@class MSUListModel;

@interface MSUOrderModel : NSObject

@property (nonatomic , copy) NSString *code;

@property (nonatomic , strong) MSUDataOrderModel *data;

@property (nonatomic , copy) NSString *message;

@property (nonatomic , copy) NSString *success;

@end


@interface MSUDataOrderModel : NSObject

@property (nonatomic , copy) NSString *pageIndex;
@property (nonatomic , copy) NSString *pageCount;
@property (nonatomic , copy) NSString *pageSize;
@property (nonatomic , copy) NSString *total;
@property (nonatomic , copy) NSString *nextPage;
@property (nonatomic , copy) NSString *prevPage;
@property (nonatomic , copy) NSArray<MSUListModel *> *dataList;


@end

@interface MSUListModel : NSObject

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
@property (nonatomic , copy) NSString *goods;
@property (nonatomic , copy) NSString *hnumber;

@end
