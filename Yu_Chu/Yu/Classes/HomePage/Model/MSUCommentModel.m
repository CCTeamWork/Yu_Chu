//
//  MSUCommentModel.m
//  Yu
//
//  Created by yl20027 on 2017/11/13.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "MSUCommentModel.h"

@implementation MSUCommentModel



@end

@implementation MSUDataModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"dataList":[MSUCommentDetailModel class]};
}


@end

@implementation MSUCommentDetailModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"commentImgsList":[MSURelyDetailModel class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"comment_id":@"id"};
}


@end


@implementation MSURelyDetailModel



@end


