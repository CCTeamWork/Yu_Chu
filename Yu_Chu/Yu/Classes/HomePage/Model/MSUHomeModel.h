//
//  MSUHomeModel.h
//  Yu
//
//  Created by yl20027 on 2017/11/11.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MSUHomeDataModel;


@interface MSUHomeModel : NSObject

@property (nonatomic , copy) NSString *code;

@property (nonatomic , strong) NSArray<MSUHomeDataModel *> *data;

@property (nonatomic , copy) NSString *message;

@property (nonatomic , copy) NSString *success;

@end


@interface MSUHomeDataModel : NSObject

@property (nonatomic , copy) NSString *address;
@property (nonatomic , copy) NSString *addtime;
@property (nonatomic , copy) NSString *cateId;
@property (nonatomic , copy) NSString *coverImage;
@property (nonatomic , copy) NSString *intro_msg;
@property (nonatomic , copy) NSString *dishClassName;
@property (nonatomic , copy) NSString *dishName;
@property (nonatomic , copy) NSString *dishPrice;
@property (nonatomic , copy) NSString *distance;
@property (nonatomic , copy) NSString *enabled;
@property (nonatomic , copy) NSString *seller_id;
@property (nonatomic , copy) NSString *idCard;
@property (nonatomic , copy) NSString *isAuth;
@property (nonatomic , copy) NSString *isDelete;
@property (nonatomic , copy) NSString *isOpen;
@property (nonatomic , copy) NSString *isQualification;
@property (nonatomic , copy) NSString *latitude;
@property (nonatomic , copy) NSString *logo;
@property (nonatomic , copy) NSString *longitude;
@property (nonatomic , copy) NSString *minSendFee;
@property (nonatomic , copy) NSString *mobile;
@property (nonatomic , copy) NSString *name;
@property (nonatomic , copy) NSString *openTime;
@property (nonatomic , copy) NSString *orderEnd;
@property (nonatomic , copy) NSString *orderStart;
@property (nonatomic , copy) NSString *remarks;
@property (nonatomic , copy) NSString *shipmentFee;
@property (nonatomic , copy) NSString *shopId;

@end
