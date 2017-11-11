//
//  MSUDetailModel.m
//  Yu
//
//  Created by yl20027 on 2017/11/11.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUDetailModel.h"

@implementation MSUDetailModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"data":[MSUShopDetailModel class]};
}

@end


@implementation MSUShopDetailModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"MSUMenuModel":[MSUMenuModel class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"seller_id":@"id",
             @"intro_msg":@"description"};
}


@end

@implementation MSUMenuModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"seller_id":@"id"};
}


@end
