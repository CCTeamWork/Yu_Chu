//
//  TimerHandler.m
//  HSGProject
//
//  Created by Mn_Su on 16/8/30.
//  Copyright © 2016年 HSG. All rights reserved.
//

#import "MSUTimerHandler.h"

@implementation MSUTimerHandler

//开启定时器
+ (void)openTimerEveryTime:(NSTimeInterval)time eventHandler:(void (^)(dispatch_source_t timer))block {
    __block NSTimeInterval evetyTime =time;
    __block dispatch_source_t newTimer;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    newTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(newTimer, dispatch_walltime(NULL,0), evetyTime * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(newTimer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            block(newTimer);
        });
    });
    dispatch_resume(newTimer);
}

//倒计时
+ (void)countdownSecond:(NSInteger)second eventHandler:(void (^)(dispatch_source_t timer, NSInteger surplusTime))block {
    __block NSInteger timeout =second; //倒计时时间
    __block dispatch_source_t newTimer;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    newTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(newTimer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(newTimer, ^{
        if(timeout<=0) {
            //取消定时器
            dispatch_source_cancel(newTimer); newTimer =nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                block(newTimer, timeout);
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(newTimer, (long)timeout);
                timeout--;
            });
        }
    });
    dispatch_resume(newTimer);
}

/*
 ** 转换时间戳为字符串
 */
+ (NSString *)exchangeTimefromTimeTamp:(NSString *)timetamp{
    //    NSTimeInterval time = [timetamp doubleValue] + 28800;//因为时差问题要加8小时 == 28800 sec
    NSTimeInterval time = [timetamp doubleValue];
    
    NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:time];
    
    //    NSLog(@"date:%@",[detailDate description]);
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:detailDate];
    return currentDateStr;
}

/*
 ** 转换时间戳为秒数做倒计时
 */
+ (NSInteger)countDownFromTimeTamp:(NSString *)timetamp{
    //拿到当前系统时间（毫秒）
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [date timeIntervalSince1970] * 1000;
    NSString *timeStr = [NSString stringWithFormat:@"%.0f",time];
    
    //服务器传递参数时间戳字符串 减去 当前系统时间戳字符串
    NSInteger surplusTime = [timetamp integerValue] - [timeStr integerValue];
    return surplusTime;
}

/*
 **字符串(2015-06-25 17:04)转date
 */
+ (NSDate *)stringWithDate:(NSString*)dateString format:(NSString*)format {
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:format];     //@"yyyy-MM-dd HH:mm:ss" 设定时间格式,这里可以设置成自己需要的格式
    NSDate *date =[dateFormat dateFromString:dateString];
    return date;
}

/*
 **date转字符串
 */
+(NSString *)dateWithString:(NSDate *)date format:(NSString*)format {
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:format];    //@"yyyy-MM-dd HH:mm:ss" 设定时间格式,这里可以设置成自己需要的格式
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

/*
 * 播放视频伴音  name:文件名.类型(name.mp4)
 */
/*
 + (void)playJudgeVoiceWithName:(NSString*)name {
 NSArray *strArray =[name componentsSeparatedByString:@"."];
 NSString *resultPath =[[NSBundle mainBundle]pathForResource:[strArray firstObject] ofType:[strArray lastObject]];
 NIMNetCallAudioFileMixTask *audio = [[NIMNetCallAudioFileMixTask alloc] initWithFileURL:[NSURL URLWithString:resultPath]];;
 [[NIMAVChatSDK sharedSDK].netCallManager startAudioMix:audio];
 }
 */

@end




