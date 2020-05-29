//
//  NSArray+MakeNumbers.m
//  Ball
//
//  Created by Face on 2020/5/25.
//  Copyright © 2020 Face. All rights reserved.
//

#import "NSArray+BTNumbers.h"

@implementation NSArray (BTNumbers)
+ (NSArray<NSNumber*>*)arrayWithFromValue:(NSInteger)fromValue
                                  toValue:(NSInteger)toValue
                                 maxValue:(NSInteger)maxValue{
    if (toValue < fromValue) {
        toValue += maxValue;
    }
    NSMutableArray * arr = [NSMutableArray new];
    for (NSInteger i = fromValue; i<=toValue; i++) {
        NSNumber * num = [NSNumber numberWithInteger:i%maxValue];
        [arr addObject:num];
    }
    return arr.copy;
}

+ (NSArray<NSNumber *> *)arrayWithArc4randomFromValue:(NSInteger)fromValue toValue:(NSInteger)toValue count:(NSInteger)count{
    NSMutableArray * arr = [NSMutableArray new];
    for (NSInteger index = fromValue; index<count; index++) {
        NSNumber * num = [NSNumber numberWithInteger:(arc4random() % toValue)];
        [arr addObject:num];
    }
    return arr.copy;
}

@end
