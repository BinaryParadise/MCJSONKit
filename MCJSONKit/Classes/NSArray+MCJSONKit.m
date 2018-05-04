//
//  NSArray+MCJSONKit.m
//  MCJSONKit
//
//  Created by mylcode on 2018/3/20.
//  Copyright © MC-Studio CO., LTD. All rights reserved.
//

#import "NSArray+MCJSONKit.h"
#import "NSObject+MCJSONKit.h"

@implementation NSArray (MCJSONKit)

- (NSArray<NSDictionary *> *)toDictionaryArray {
    NSMutableArray *marr = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [marr addObject:[obj mc_toDictionary]];
    }];
    return [marr copy];
}

@end
