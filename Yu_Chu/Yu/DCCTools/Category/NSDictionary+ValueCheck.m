//
//  UINavigationController+NSDictionary.m
//  wifidistrict
//
//  Created by ArcRain on 10/28/14.
//  Copyright (c) 2014 Hangzhou QuXun Technology Co., Ltd. All rights reserved.
//

#import "NSDictionary+ValueCheck.h"

#if ! __has_feature(objc_arc)
#error this file is ARC only. Either turn on ARC for the project or use -fobjc-arc flag
#endif

@implementation NSDictionary (ValueCheck)

- (id)valueWithNilForKey:(NSString *)key
{
    id value = [self valueForKey:key];
    if ([value isKindOfClass:[NSNull class]]) {
        return nil;
    }
    else {
        return value;
    }
}

@end


@implementation NSMutableDictionary (Helper)

- (void)setObjectSafe:(id)object forKey:(NSString*)key {
    if (nil ==  object || nil == key) return ;
    
    [self setObject:object forKey:key];
}
- (void)setValuseSafe:(id)object forKey:(NSString*)key {
    if (nil ==  object || nil == key) return ;
    
    [self setValue:object forKey:key];
}
@end

@implementation NSArray (Helper)

- (id)objectAtIndexSafe:(NSUInteger)index {
    id ret = nil;
    @try {
        ret = [self objectAtIndex:index];
    }
    @catch (NSException *exception) {
        ret = nil;
    }
    @finally {
        return ret;
    }
}

@end

@implementation NSDictionary (JSON)

- (NSString*)stringForKey:(id)key {
    id value = [self objectForKey:key];
    
    if ([value isKindOfClass:[NSString class]]) return value;
    if ([value isKindOfClass:[NSNumber class]]) return [(NSNumber*)value stringValue];
    
    return nil;
}

- (NSArray*)arrayForKey:(id)key {
    id value = [self objectForKey:key];
    
    if (![value isKindOfClass:[NSArray class]]) return nil;
    
    return value;
}

- (NSInteger)intForKey:(id)key {
    id value = [self objectForKey:key];
    
    if ([value isKindOfClass:[NSNumber class]]) return [value intValue];
    
    if ([value isKindOfClass:[NSString class]]) return [value intValue];
    
    return 0;
}

- (float)floatForKey:(id)key {
    id value = [self objectForKey:key];
    
    if ([value isKindOfClass:[NSNumber class]]) return [value floatValue];
    
    if ([value isKindOfClass:[NSString class]]) return [value floatValue];
    
    return 0;
}

- (NSNumber*)numberForKey:(id)key {
    id value = [self objectForKey:key];
    
    if ([value isKindOfClass:[NSNumber class]]) return value;
    
    if ([value isKindOfClass:[NSString class]]) return [NSNumber numberWithFloat:[value floatValue]];
    
    return nil;
}

#pragma mark - 私有方法
//将NSDictionary中的Null类型的项目转化成@""
+(NSDictionary *)nullDic:(NSDictionary *)myDic
{
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++)
    {
        id obj = [myDic objectForKey:keyArr[i]];
        
        obj = [self changeType:obj];
        
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}

//将NSDictionary中的Null类型的项目转化成@""
+(NSArray *)nullArr:(NSArray *)myArr
{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++)
    {
        id obj = myArr[i];
        
        obj = [self changeType:obj];
        
        [resArr addObject:obj];
    }
    return resArr;
}

//将NSString类型的原路返回
+(NSString *)stringToString:(NSString *)string
{
    return string;
}

//将Null类型的项目转化成@""
+(NSString *)nullToString
{
    return @"";
}

#pragma mark - 公有方法
//类型识别:将所有的NSNull类型转化成@""
+(id)changeType:(id)myObj
{
    if ([myObj isKindOfClass:[NSDictionary class]])
    {
        return [self nullDic:myObj];
    }
    else if([myObj isKindOfClass:[NSArray class]])
    {
        return [self nullArr:myObj];
    }
    else if([myObj isKindOfClass:[NSString class]])
    {
        return [self stringToString:myObj];
    }
    else if([myObj isKindOfClass:[NSNull class]])
    {
        return [self nullToString];
    }
    else if([myObj isKindOfClass:[NSNumber class]])
    {
        NSNumber *num = myObj;
        NSInteger lab = num.integerValue;
        return [NSNumber numberWithInteger:lab];
    }   
    else
    {
        return myObj;
    }
}

@end
