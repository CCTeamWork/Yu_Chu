//
//  NSDictionary+ValueCheck.h
//  wifidistrict
//
//  Created by ArcRain on 10/28/14.
//  Copyright (c) 2014 Hangzhou QuXun Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDictionary (ValueCheck)

- (id)valueWithNilForKey:(NSString *)key;

@end

@interface NSMutableDictionary (Helper)

- (void)setObjectSafe:(id)object forKey:(NSString*)key;
- (void)setValuseSafe:(id)object forKey:(NSString*)key;

@end

@interface NSArray (Helper)

- (id)objectAtIndexSafe:(NSUInteger)index;

@end

@interface NSDictionary (JSON)

- (NSString*)stringForKey:(id)key;
- (NSArray*)arrayForKey:(id)key;
- (NSInteger)intForKey:(id)key;
- (float)floatForKey:(id)key;
- (NSNumber*)numberForKey:(id)key ;
//- (NSDate*)dateForKey:(id)key;


+(id)changeType:(id)myObj; 

@end
