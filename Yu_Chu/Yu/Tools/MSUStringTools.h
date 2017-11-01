//
//  MSUStringTools.h
//  测试
//
//  Created by Zhuge_Su on 2017/7/3.
//  Copyright © 2017年 Zhuge_Su. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MSUStringTools : NSObject

/* 移除字符串中的空格和换行 */
+ (NSString *)removeSpaceAndNewline:(NSString *)str;

/* 将阿拉伯数字转换成汉文数字 */
+ (NSString *)translationToStringWithArabicNum:(NSInteger)arabicNum;

/* 将日期转换成古月份 */
+ (NSString *)translationChineseWithArabicNum:(NSInteger)arabicNum;

/* 判断字符串中是否有中文 */
+ (BOOL)isContainChinese:(NSString *)str;

/* 富文本 修改局部字段颜色 */
+ (NSMutableAttributedString*)changeLabelWithText:(NSString*)needText AndFromOrigiFont:(CGFloat)origi toChangeFont:(CGFloat)change AndFromOrigiLoca:(NSInteger)loca WithBeforePart:(NSInteger)part;

/* 在已有字符串中 修改 输入字符 颜色和大小 */
+ (NSMutableAttributedString *)makeKeyWordAttributedWithSubText:(NSString *)subText inOrigiText:(NSString *)origiText font:(CGFloat)font color:(UIColor *)color;

/* 在已有富文本字符串中 修改 输入字符 颜色和大小 */
+ (NSMutableAttributedString *)makeAttrubuteKeyWordAttributedWithSubText:(NSString *)subText inOrigiText:(NSMutableAttributedString *)origiText font:(CGFloat)font color:(UIColor *)color;

/* 动态获取 String 宽 */
+ (CGSize)danamicGetWidthFromText:(NSString *)text WithFont:(CGFloat)font;

/* 动态获取 String 高 */
+ (CGRect)danamicGetHeightFromText:(NSString *)text WithWidth:(CGFloat)width font:(CGFloat)font;

/* 判断两个数组是否相同 */
+ (BOOL)judgeTheSameOfArrA:(NSMutableArray *)arrA WithArrB:(NSMutableArray *)arrB;

/* 压缩图片到指定尺寸  */
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size;

/* 压缩图片到指定大小  */
+ (NSData *)compressOriginalImage:(UIImage *)image withScale:(NSInteger)scale;

@end
