//
//  UIButton+vertical.h
//  小莱
//
//  Created by jack on 16/7/6.
//  Copyright © 2016年 李丹阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (vertical)

//竖排，图片在上，文字在下
- (void)verticalImageAndTitle:(CGFloat)spacing;

//横排，图片在右，文字在左
- (void)horizontalTitleAndImage:(CGFloat)spacing;

//横排，图片在左，文字在又
- (void)horizontalImageAndTitle:(CGFloat)spacing;

@end
