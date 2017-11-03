//
//  NSString+Extension.h
//  HXCamouflageCalculator
//
//  Created by 黄轩 on 16/10/11.
//  Copyright © 2016年 黄轩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSString (Extension)

+ (CGFloat)calculateRowWidth:(NSString *)string andFont:(CGFloat)fontSize andHeight:(CGFloat)fontHeight;

///** 时间戳转NSDate  */
+ (NSDate *)changeTimeStringFormatWithtimeStamp:(NSString *)string;

/**
   把时间戳字符串转成特定的格式字符串
  @param formatterString 是要转的时间格式 例如：yyyy-MM-dd HH-mm
 */
- (NSString *)timeForSpeciallFormatter:(NSString *)formatterString;

/**
 更改时间格式 昨天、今天、具体日期
 @param timeString 要更改的时间 时间戳格式
 @param formatterString 转换的格式 除了今天、昨天的其他格式 如：@"yyyy-MM-dd"
 */
+ (NSString *)time:(NSString *)timeString formatter:(NSString *)formatterString;

// 整理请求下来的时间字符串
//  时间戳  转  1996-8-24 21:00
+ (NSString *)changeTimeStringFormatWithStringyyyyMMddHHmm:(NSString *)string;

//  时间戳  转  8-24
+ (NSString *)changeTimeStringFormatWithStringMMdd:(NSString *)string;

//  时间戳  转  1996年8月
+ (NSString *)changeTimeStringFormatWithStringyyyyYearMMMonths:(NSString *)string;

//  时间戳  转  8月24日
+ (NSString *)changeTimeStringFormatWithStringMMMonthsddDay:(NSString *)string;

/** 时间戳  转  星期几 Sunday Friday*/
+ (NSString *)changeTimeStringFormatWithStringeeee:(NSString *)string;

/** 时间戳 转yyyyMM月dd日*/
+ (NSString *)changeTimeStringFormatWithStringyyyyYearMMMonthsddDay:(NSString *)string;

//  时间戳  转  1996.8
+ (NSString *)changeTimeStringFormatWithStringyyyyPointMM:(NSString *)string;

//去掉无意义的0
+ (NSString *)stringDisposeWithFloatStringValue:(NSString *)floatStringValue;

+ (NSString *)stringDisposeWithFloatValue:(float)floatNum;

//千分位格式化数据
+ (NSString *)ittemThousandPointsFromNumString:(NSString *)numString;

//计算字符串的CGSize
- (CGSize)ex_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

+ (CGFloat)heightForString:(NSString * _Nullable)value spacing:(CGFloat)number fontSize:(CGFloat)fontSize andWidth:(CGFloat)width;

#pragma mark 正则验证
+ (BOOL)validateCellPhoneNumber:(NSString *_Nullable)cellNum;
/** 判断密码格式是否正确 */
+ (BOOL)judgePassWordLegal:(NSString *)pass;
//邮箱
+ (BOOL) validateEmail:(NSString *_Nullable)email;
//昵称
+ (BOOL) validateNickname:(NSString *_Nullable)nickname;
//身份证号
+ (BOOL) validateIdentityCard: (NSString *_Nullable)identityCard;
- (NSString *)urlEncode;

//判断日期前后
+(BOOL)intervalWithTime:(NSString *)time1 andTime:(NSString *)time2;

NS_ASSUME_NONNULL_END
@end
