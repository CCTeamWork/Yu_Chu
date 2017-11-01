//
//  NSDate+CL.h
//  CLWeeklyCalendarView
//
//  Created by Caesar on 10/12/2014.
//  Copyright (c) 2014 Caesar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CL)
/** 几天后的NSDate*/
- (NSDate *)addDays:(NSInteger)day;
/**以周几为一周的开始日期 当前Date所在的一周的开始日期*/
- (NSDate *)getWeekStartDate: (NSInteger)weekStartIndex;
/**获取当天 是周几的缩写（前三个字母）*/
- (NSString *)getDayOfWeekShortString;
/**得到当天是这个月的排序*/
- (NSString *)getDateOfMonth;
/**比较两个NSDate的大小*/
- (BOOL)isSameDateWith: (NSDate *)dt;
/**是否是今天*/
- (BOOL)isDateToday;
/**是否在两者之间*/
- (BOOL)isWithinDate: (NSDate *)earlierDate toDate:(NSDate *)laterDate;
/**是否是过去的Date*/
- (BOOL)isPastDate;
@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
