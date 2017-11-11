//
//  MSUDetailModel.h
//  Yu
//
//  Created by yl20027 on 2017/11/11.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MSUShopDetailModel;
@class MSUMenuModel;

@interface MSUDetailModel : NSObject

@property (nonatomic , copy) NSString *code;

@property (nonatomic , strong) NSArray<MSUShopDetailModel *> *data;

@property (nonatomic , copy) NSString *message;

@property (nonatomic , copy) NSString *success;

@end



@interface MSUShopDetailModel : NSObject

@property (nonatomic , copy) NSString *createdTime;
@property (nonatomic , copy) NSString *intro_msg;
@property (nonatomic , copy) NSString *dishClassName;
@property (nonatomic , copy) NSString *seller_id;
@property (nonatomic , copy) NSString *indexOrder;
@property (nonatomic , copy) NSString *isDelete;
@property (nonatomic , copy) NSString *shopId;
@property (nonatomic , strong) NSArray<MSUMenuModel *> *dishList;

@end

@interface MSUMenuModel : NSObject

@property (nonatomic , copy) NSString *coverImage;
@property (nonatomic , copy) NSString *createdTime;
@property (nonatomic , copy) NSString *dishClassId;
@property (nonatomic , copy) NSString *dishDisc;
@property (nonatomic , copy) NSString *dishName;
@property (nonatomic , copy) NSString *dishPrice;
@property (nonatomic , copy) NSString *dishStatus;
@property (nonatomic , copy) NSString *dishStock;
@property (nonatomic , copy) NSString *seller_id;
@property (nonatomic , copy) NSString *isShowHome;
@property (nonatomic , copy) NSString *mainDishName;
@property (nonatomic , copy) NSString *shopId;
@property (nonatomic , copy) NSString *sideDishName;
@property (nonatomic , copy) NSString *stapleFood;

@end
