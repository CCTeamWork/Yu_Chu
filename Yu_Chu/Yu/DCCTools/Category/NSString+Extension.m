//
//  NSString+Extension.m
//  HXCamouflageCalculator
//
//  Created by 黄轩 on 16/10/11.
//  Copyright © 2016年 黄轩. All rights reserved.
//

#import "NSString+Extension.h"
#import <sys/utsname.h>

@implementation NSString (Extension)

+ (CGFloat)calculateRowWidth:(NSString *)string andFont:(CGFloat)fontSize andHeight:(CGFloat)fontHeight{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};  //指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, fontHeight)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width;
}


/** 时间戳转时间*/
+ (NSDate *)changeTimeStringFormatWithtimeStamp:(NSString *)string{
    NSDate* detaildate=[NSDate dateWithTimeIntervalSince1970:[string doubleValue]/ 1000.0];
    
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString* currentDateStr = [dateFormatter stringFromDate:detaildate];
    
    NSDate *date = [dateFormatter dateFromString:currentDateStr];

    return date;
}

- (NSString *)timeForSpeciallFormatter:(NSString *)formatterString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat=formatterString;
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]/ 1000.0];
    NSString* dateString = [dateFormatter stringFromDate:date];
    return dateString;
}
/**
 更改时间格式 昨天、今天、具体日期
 */
+ (NSString *)time:(NSString *)timeString formatter:(NSString *)formatterString{
    if (timeString.length == 0) {
        return @"";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //时间戳毫秒除1000变成秒
    NSDate* timeDate = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
   // NSDate *timeDate = [dateFormatter dateFromString:timeString];
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today=[[NSDate alloc] init];
    NSDate *yearsterDay =  [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay];
    //假设这是你要比较的date：NSDate *yourDate = ……
    //日历
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:timeDate];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:yearsterDay];
    NSDateComponents* comp4 = [calendar components:unitFlags fromDate:today];
    if ( comp1.year == comp2.year && comp1.month == comp2.month && comp1.day == comp2.day) {
        return @"昨天";
    }
    if (comp1.year == comp4.year && comp1.month == comp4.month && comp1.day == comp4.day)
    {
        return @"今天";
    }
    [dateFormatter setDateFormat:formatterString];
    return [dateFormatter stringFromDate:timeDate];
}

//  时间戳  转  1996-8-24 21:00
+ (NSString *)changeTimeStringFormatWithStringyyyyMMddHHmm:(NSString *)string{
    if (string.length != 0) {
        NSDate *date = [self changeTimeStringFormatWithtimeStamp:string];
        NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
        [dataFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        string = [dataFormatter stringFromDate:date];
        
        return string;
    }
    return @"";
}

//  时间戳  转  8-24
+ (NSString *)changeTimeStringFormatWithStringMMdd:(NSString *)string{
    if (string.length != 0) {
        NSDate *date = [self changeTimeStringFormatWithtimeStamp:string];
        NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
        [dataFormatter setDateFormat:@"MM-dd"];
        string = [dataFormatter stringFromDate:date];
        
        return string;
    }
    return @"";
   
}

//  时间戳  转  1996年8月
+ (NSString *)changeTimeStringFormatWithStringyyyyYearMMMonths:(NSString *)string{
    if (string.length != 0) {
        NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
        [dataFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date = [dataFormatter dateFromString:string];
        
        [dataFormatter setDateFormat:@"yyyy年MM月"];
        
        string = [dataFormatter stringFromDate:date];
        
        return string;
    }
    return @"";
  
}
//  时间戳  转  8月24日
+ (NSString *)changeTimeStringFormatWithStringMMMonthsddDay:(NSString *)string{
    if (string.length != 0) {
        NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
        [dataFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date = [dataFormatter dateFromString:string];
        
        [dataFormatter setDateFormat:@"MM月dd日"];
        string = [dataFormatter stringFromDate:date];
        
        return string;

    }
    return @"";    
}
/** 时间戳  转  星期几 Sunday Friday*/
+ (NSString *)changeTimeStringFormatWithStringeeee:(NSString *)string{
    if (string.length != 0) {
        NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
        [dataFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date = [dataFormatter dateFromString:string];
        
        [dataFormatter setDateFormat:@"eeee"];
        string = [dataFormatter stringFromDate:date];
        
        return string;
        
    }
    return @"";
}
/** 字符串编码*/
- (NSString*)urlEncode
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)[self mutableCopy], NULL, CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/"), kCFStringEncodingUTF8));
}


+ (CGFloat)heightForString:(NSString * _Nullable)value spacing:(CGFloat)number fontSize:(CGFloat)fontSize andWidth:(CGFloat)width
{
    if (value.length <= 0) {
        return 0.0f;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    if (number > 0) {
        [paragraphStyle setLineSpacing:number];//调整行间距
    }
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle};
    
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return ceil(sizeToFit.height);
}

+ (NSString *)stringDisposeWithFloatStringValue:(NSString *)floatStringValue {
    NSString *str = floatStringValue;
    NSUInteger len = str.length;
    for (int i = 0; i < len; i++)
    {
        if (![str  hasSuffix:@"0"])
            break;
        else {
            if ([str rangeOfString:@"."].location != NSNotFound) {
                str = [str substringToIndex:[str length]-1];
            } else {
                break;
            }
        }
    }
    if ([str hasSuffix:@"."])//避免像2.0000这样的被解析成2.
    {
        return [str substringToIndex:[str length]-1];//s.substring(0, len - i - 1);
    }
    else
    {
        return str;
    }
}

//此方法去掉2.0000这样的浮点后面多余的0
//传人一个浮点字符串,需要保留几位小数则保留好后再传
+ (NSString *)stringDisposeWithFloatValue:(float)floatNum {
    
    NSString *str = [NSString stringWithFormat:@"%.2f",floatNum];
    NSUInteger len = str.length;
    for (int i = 0; i < len; i++)
    {
        if (![str  hasSuffix:@"0"])
            break;
        else
            str = [str substringToIndex:[str length]-1];
    }
    if ([str hasSuffix:@"."])//避免像2.0000这样的被解析成2.
    {
        return [str substringToIndex:[str length]-1];//s.substring(0, len - i - 1);
    }
    else
    {
        return str;
    }
}

+ (NSString *)ittemThousandPointsFromNumString:(NSString *)numString {
    NSString *str = numString;
    
    NSString *preStr = @"";
    if ([str rangeOfString:@"-"].location != NSNotFound) {
        str = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
        preStr = @"-";
    }
    
    NSString *lastStr = @"";
    if ([str rangeOfString:@"."].location != NSNotFound) {
        NSArray *array = [str componentsSeparatedByString:@"."];
        if (array.count > 1) {
            str = array[0];
            lastStr = [NSString stringWithFormat:@".%@",array[1]];
        }
    }

    NSUInteger len = [str length];
    NSUInteger x = len % 3;
    NSUInteger y = len / 3;
    NSUInteger dotNumber = y;
    
    if (x == 0) {
        dotNumber -= 1;
        x = 3;
    }
    NSMutableString *rs = [@"" mutableCopy];
    
    [rs appendString:[str substringWithRange:NSMakeRange(0, x)]];
    
    for (int i = 0; i < dotNumber; i++) {
        [rs appendString:@","];
        [rs appendString:[str substringWithRange:NSMakeRange(x + i * 3, 3)]];
    }
    rs = [NSMutableString stringWithFormat:@"%@%@",preStr,rs];
   [rs appendString:lastStr];
   return rs;
}

- (CGSize)ex_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize resultSize;
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(boundingRectWithSize:options:attributes:context:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(boundingRectWithSize:options:attributes:context:)];
        NSDictionary *attributes = @{ NSFontAttributeName:font };
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
        NSStringDrawingContext *context;
        [invocation setArgument:&size atIndex:2];
        [invocation setArgument:&options atIndex:3];
        [invocation setArgument:&attributes atIndex:4];
        [invocation setArgument:&context atIndex:5];
        [invocation invoke];
        CGRect rect;
        [invocation getReturnValue:&rect];
        resultSize = rect.size;
    } else {
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(sizeWithFont:constrainedToSize:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(sizeWithFont:constrainedToSize:)];
        [invocation setArgument:&font atIndex:2];
        [invocation setArgument:&size atIndex:3];
        [invocation invoke];
        [invocation getReturnValue:&resultSize];
    }
    
    return resultSize;
}
+ (BOOL)validateCellPhoneNumber:(NSString *)mobile{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" "withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(170)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

+ (BOOL)judgePassWordLegal:(NSString *)pass{
    BOOL result = false;
    if ([pass length] >= 6){
        // 判断长度大于6位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}

//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}


//车型
+ (BOOL) validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}


//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
//判断日期前后
+(BOOL)intervalWithTime:(NSString *)time1 andTime:(NSString *)time2
{
    
    time1 = [time1 stringByAppendingFormat:@"-01"];
    
    time2 = [time2 stringByAppendingString:@"-01"];
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd"];
    NSDate *d1=[date dateFromString:time1];
    NSDate *d2 = [date dateFromString:time2];
    
    NSTimeInterval secs = [d2 timeIntervalSinceDate:d1];
    
    if (secs < 0) {
        return NO;
    }else{
        return YES;
    }
}
+ (NSString*)iphoneType{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    NSString*platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];

    if([platform isEqualToString:@"iPhone1,1"])return@"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"])return@"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"])return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"])return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"])return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"])return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"])return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"])return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"])return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"])return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"])return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"])return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"])return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"])return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"])return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"])return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"])return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"])return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"])return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"])return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"])return@"iPhone X";
    
    if([platform isEqualToString:@"iPod1,1"])return@"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"])return@"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"])return@"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"])return@"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"])return@"iPod Touch 5G";
    
    if([platform isEqualToString:@"iPad1,1"])return@"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"])return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"])return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"])return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"])return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"])return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"])return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"])return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"])return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"])return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"])return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"])return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"])return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"])return@"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"])return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"])return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"])return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"])return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"])return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"])return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"])return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"])return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"])return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"])return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"])return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"])return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"])return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"])return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"])return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"])return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"])return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"])return@"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"])return@"iPhone Simulator";
    
    return platform;

}
+ (BOOL)judgeIsiPhoneX{
    NSString *typeS = [self iphoneType];
    if ([typeS isEqualToString:@"iPhone X"]) {
        return YES;
    }
    return NO;
}
/** 时间戳 转yyyyMM月dd日*/
+ (NSString *)changeTimeStringFormatWithStringyyyyYearMMMonthsddDay:(NSString *)string{
    if (string.length != 0) {
        NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
        [dataFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date = [dataFormatter dateFromString:string];
        
        [dataFormatter setDateFormat:@"yyyy年MM月dd日"];
        string = [dataFormatter stringFromDate:date];
        
        return string;
    }
    return @"";
}

//  时间戳  转  1996.8
+ (NSString *)changeTimeStringFormatWithStringyyyyPointMM:(NSString *)string{
    if (string.length != 0) {
        NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
        [dataFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date = [dataFormatter dateFromString:string];
        
        [dataFormatter setDateFormat:@"yyyy.MM"];
        
        string = [dataFormatter stringFromDate:date];
        
        return string;
    }
    return @"";
    
}
@end
