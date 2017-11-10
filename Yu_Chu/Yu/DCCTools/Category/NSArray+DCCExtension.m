//
//  NSArray+DCCExtension.m
//  Yu
//
//  Created by duanchongchong on 2017/11/9.
//  Copyright © 2017年 何龙飞. All rights reserved.
//

#import "NSArray+DCCExtension.h"
#import <Foundation/Foundation.h>

@implementation NSArray (DCCExtension)

@end


@implementation NSMutableArray (DCCExtension)

-(void)addSafeObject:(id)obj{
    if ([obj isEqual:[NSNull null]]){
        [self addObject:@""];
        return;
    }
    if (!obj) {
        [self addObject:@""];
        return;
    }
    [self addObject:obj];
}
@end
