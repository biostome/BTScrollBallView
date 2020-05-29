//
//  NSArray+MakeNumbers.h
//  Ball
//
//  Created by Face on 2020/5/25.
//  Copyright © 2020 Face. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (BTNumbers)

+ (NSArray<NSNumber*>*)arrayWithFromValue:(NSInteger)fromValue
                                  toValue:(NSInteger)toValue
                                 maxValue:(NSInteger)maxValue;

+ (NSArray<NSNumber *> *)arrayWithArc4randomFromValue:(NSInteger)fromValue
                                              toValue:(NSInteger)toValue
                                                count:(NSInteger)count;
@end

NS_ASSUME_NONNULL_END
