//
//  MSUHomeModel.m
//  Yu
//
//  Created by yl20027 on 2017/11/11.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUHomeModel.h"


@implementation MSUHomeModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"data":[MSUHomeDataModel class]};
}


@end

@implementation MSUHomeDataModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"seller_id":@"id",
             @"intro_msg":@"description"};
}


@end
