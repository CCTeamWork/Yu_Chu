//
//  MSUCommentModel.h
//  Yu
//
//  Created by yl20027 on 2017/11/13.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MSUCommentDetailModel;
@class MSURelyDetailModel;
@class MSUDataModel;

@interface MSUCommentModel : NSObject

@property (nonatomic , copy) NSString *code;

@property (nonatomic , strong) MSUDataModel *data;

@property (nonatomic , copy) NSString *message;

@property (nonatomic , copy) NSString *success;

@end

@interface MSUDataModel : NSObject


@property (nonatomic , copy) NSArray<MSUCommentDetailModel *> *dataList;
@property (nonatomic , copy) NSString *nextPage;
@property (nonatomic , copy) NSString *pageCount;
@property (nonatomic , copy) NSString *pageIndex;
@property (nonatomic , copy) NSString *pageSize;
@property (nonatomic , copy) NSString *prevPage;
@property (nonatomic , copy) NSString *total;

@end



@interface MSUCommentDetailModel : NSObject

@property (nonatomic , copy) NSString *averageCcore;
@property (nonatomic , copy) NSString *content;
@property (nonatomic , copy) NSString *contentAfter;
@property (nonatomic , copy) NSString *createdTime;
@property (nonatomic , copy) NSString *dishId;

@property (nonatomic , copy) NSString *hasImg;
@property (nonatomic , copy) NSString *comment_id;
@property (nonatomic , copy) NSString *isAnonymous;
@property (nonatomic , copy) NSString *isPraise;
@property (nonatomic , copy) NSString *isShow;

@property (nonatomic , copy) NSString *memberId;
@property (nonatomic , copy) NSString *nickname;
@property (nonatomic , copy) NSString *nopass;
@property (nonatomic , copy) NSString *orderId;

@property (nonatomic , copy) NSString *portrait;
@property (nonatomic , copy) NSString *praiseNum;
@property (nonatomic , copy) NSString *reply;
@property (nonatomic , copy) NSString *replyTime;

@property (nonatomic , copy) NSString *score;
@property (nonatomic , copy) NSString *shopId;
@property (nonatomic , copy) NSString *tag;
@property (nonatomic , copy) NSArray<MSURelyDetailModel *> *commentImgsList;

@end

@interface MSURelyDetailModel : NSObject

@end
