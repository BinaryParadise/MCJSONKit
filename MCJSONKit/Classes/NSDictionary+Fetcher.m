//
//  NSDictionary+Fetcher.m
//  MCJSONKit
//
//  Created by Rake Yang on 2019/6/29.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "NSDictionary+Fetcher.h"

@implementation NSDictionary (ScriptNative)

- (void)mc_valueForKey:(NSString *)key
                string:(void (^)(NSString *val))string
                number:(void (^)(NSNumber *val))number
                array:(void (^)(NSArray *val))array
                dictionary:(void (^)(NSDictionary *val))dictionary
                  null:(void (^)(id val))null {
    if ([key isKindOfClass:[NSNull class]] || key.length <= 0) {
        return;
    }
    id value = self[key];
    if ([value isKindOfClass:[NSString class]]) {
        string(value);
    } else if ([value isKindOfClass:[NSNumber class]]) {
        !number?:number(value);
    } else if ([value isKindOfClass:[NSArray class]]) {
        !array?:array(value);
    } else if ([value isKindOfClass:[NSDictionary class]]) {
        !dictionary?:dictionary(value);
    } else if ([value isKindOfClass:[NSNull class]]) {
        !null?:null(nil);
    } else {
        !null?:null(value);
    }
}

- (NSString *)mc_stringForKey:(NSString *)key {
    __block NSString *retValue;
    [self mc_valueForKey:key string:^(NSString *val) {
        retValue = val;
    } number:^(NSNumber *val) {
        retValue = val.stringValue;
    } array:nil dictionary:nil null:nil];
    return retValue;
}

- (BOOL)mc_boolForKey:(NSString *)key {
    __block BOOL retValue = NO;
    [self mc_valueForKey:key string:^(NSString *val) {
        retValue = val.boolValue;
    } number:^(NSNumber *val) {
        retValue = val.boolValue;
    } array:nil dictionary:nil null:nil];
    return retValue;
}

- (NSNumber *)mc_numberForKey:(NSString *)key {
    __block NSNumber *retValue;
    [self mc_valueForKey:key string:^(NSString *val) {
        retValue = @(val.doubleValue);
    } number:^(NSNumber *val) {
        retValue = val;
    } array:nil dictionary:nil null:nil];
    return retValue;
}

- (int)mc_intForKey:(NSString *)key {
    __block int retValue = 0;
    [self mc_valueForKey:key string:^(NSString *val) {
        retValue = val.intValue;
    } number:^(NSNumber *val) {
        retValue = val.intValue;
    } array:nil dictionary:nil null:nil];
    return retValue;
}

- (long)mc_longForKey:(NSString *)key {
    return [self mc_longlongForKey:key];
}

- (long long)mc_longlongForKey:(NSString *)key {
    __block long retValue = 0;
    [self mc_valueForKey:key string:^(NSString *val) {
        retValue = val.longLongValue;
    } number:^(NSNumber *val) {
        retValue = val.longLongValue;
    } array:nil dictionary:nil null:nil];
    return retValue;
}

- (float)mc_floatForKey:(NSString *)key {
    __block float retValue = 0.0;
    [self mc_valueForKey:key string:^(NSString *val) {
        retValue = val.floatValue;
    } number:^(NSNumber *val) {
        retValue = val.floatValue;
    } array:nil dictionary:nil null:nil];
    return retValue;
}

- (double)mc_doubleForKey:(NSString *)key {
    __block double retValue = 0;
    [self mc_valueForKey:key string:^(NSString *val) {
        retValue = val.doubleValue;
    } number:^(NSNumber *val) {
        retValue = val.doubleValue;
    } array:nil dictionary:nil null:nil];
    return retValue;
}

- (NSArray *)mc_arrayForKey:(NSString *)key {
    __block NSArray *retValue;
    [self mc_valueForKey:key string:nil number:nil array:^(NSArray *val) {
        retValue = val;
    } dictionary:nil null:nil];
    return retValue;
}

- (NSDictionary *)mc_dictionaryForKey:(NSString *)key {
    __block NSDictionary *retValue;
    [self mc_valueForKey:key string:nil number:nil array:nil dictionary:^(NSDictionary *val) {
        retValue = val;
    } null:nil];
    return retValue;
}

- (id)mc_objectForKey:(NSString *)key {
    __block id retValue;
    [self mc_valueForKey:key string:^(NSString *val) {
        retValue = val;
    } number:^(NSNumber *val) {
        retValue = val;
    } array:^(NSArray *val) {
        retValue = val;
    } dictionary:^(NSDictionary *val) {
        retValue = val;
    } null:^(id val) {
        retValue = val;
    }];
    return retValue;
}

@end
