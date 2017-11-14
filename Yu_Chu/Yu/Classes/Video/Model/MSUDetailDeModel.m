//
//  MSUDetailDeModel.m
//  Yu
//
//  Created by yl20027 on 2017/11/14.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUDetailDeModel.h"

@implementation MSUDetailDeModel



@end

@implementation MSUDataDetailOrModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"goods":[MSUGoodsDetailModel class]};
}

@end


@implementation MSUGoodsDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"_id":@"id"};
}

@end
