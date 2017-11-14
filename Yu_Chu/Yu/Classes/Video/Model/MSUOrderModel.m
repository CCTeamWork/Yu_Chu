//
//  MSUOrderModel.m
//  Yu
//
//  Created by yl20027 on 2017/11/14.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUOrderModel.h"

@implementation MSUOrderModel


@end


@implementation MSUDataOrderModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"dataList":[MSUListModel class]};
}

@end

@implementation MSUListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"_id":@"id"};
}

@end
