//
//  NSMutableDictionary+JSONCore.m
//  iOSExample
//
//  Created by maintoco on 16/12/23.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import "NSMutableDictionary+JSONCore.h"

@implementation NSMutableDictionary (JSONCore)

- (void)co_setValue:(id)value forKeyPath:(NSString *)keyPath {
    __block NSMutableDictionary *mdict = self;
    NSArray<NSString *> *allKeys = [keyPath componentsSeparatedByString:@"."];
    [allKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < allKeys.count-1) {
            if (![mdict.allKeys containsObject:obj]) {
                [mdict setValue:[NSMutableDictionary dictionary] forKey:obj];
            }
            mdict = mdict[obj];
        }else {
            [mdict setValue:value?value:[NSNull null] forKey:obj];
        }
    }];
}

@end
