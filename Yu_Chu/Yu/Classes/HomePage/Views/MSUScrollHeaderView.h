//
//  MSUScrollHeaderView.h
//  Yu
//
//  Created by 何龙飞 on 2017/11/2.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUScrollHeaderView : UIView

/// 滚动视图
@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) UIPageControl *pageControl;

/// 图片内容
@property (nonatomic , strong) UIImageView *imaView;

@end
