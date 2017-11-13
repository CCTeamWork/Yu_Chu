//
//  TimerHandler.h
//  HSGProject
//
//  Created by Mn_Su on 16/8/30.
//  Copyright © 2016年 HSG. All rights reserved.
//

#import <Foundation/Foundation.h>

///定时器(Timer)
@interface MSUTimerHandler : NSObject

/**
 *  开启定时器[销毁定时器调用:dispatch_source_cancel(timer)]
 *
 *  @param time  多久执行一次
 *  @param block 返回定时器对象;
)
 */
+ (void)openTimerEveryTime:(NSTimeInterval)time eventHandler:(void (^)(dispatch_source_t timer))block;

/**
 *  倒计时
 *
 *  @param time  倒多久
 *  @param block 返回定时器对象和剩余的时间
 */
+ (void)countdownSecond:(NSInteger)second eventHandler:(void (^)(dispatch_source_t timer, NSInteger surplusTime))block;


/*
 **转换时间戳为字符串
 */
+ (NSString *)exchangeTimefromTimeTamp:(NSString *)timetamp;

/*
 **转换时间戳为秒数做倒计时
 */
+ (NSInteger)countDownFromTimeTamp:(NSString *)timetamp;

/*
 **date转字符串
 */
+(NSString *)dateWithString:(NSDate *)date format:(NSString*)format;

/*
 **字符串(2015-06-25 17:04)转date
 */
+ (NSDate *)stringWithDate:(NSString*)dateString format:(NSString*)format;

/*
 * 播放视频伴音  name:文件名.类型(name.mp4)
 */

//+ (void)playJudgeVoiceWithName:(NSString*)name;

@end
