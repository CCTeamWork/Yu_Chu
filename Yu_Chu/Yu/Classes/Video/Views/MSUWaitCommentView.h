//
//  MSUWaitCommentView.h
//  Yu
//
//  Created by 何龙飞 on 2017/11/6.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MSUWaitCommentViewDelegate <NSObject>

- (void)commentClick;

@end

@interface MSUWaitCommentView : UIView

@property (nonatomic , weak) id<MSUWaitCommentViewDelegate> delegate;


@property (nonatomic , strong) UITableView *bootomTableView;


@end
