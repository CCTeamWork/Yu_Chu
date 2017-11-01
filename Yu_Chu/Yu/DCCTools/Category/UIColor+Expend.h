//
//  UIColor+Expend.h
//  XiaoYing
//
//  Created by MengFanBiao on 15/11/17.
//  Copyright © 2015年 MengFanBiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Expend)
/**
 根据String生成颜色
 @param color 要生成颜色的字符串 @"#ffffff"
 */
+ (UIColor*) colorWithHexString:(NSString*)color;
/**
 颜色透明度设为0.5生成新颜色
 @param color 要设置的颜色
 */
+ (UIColor*)colorWithColor:(UIColor *)color;

@end
