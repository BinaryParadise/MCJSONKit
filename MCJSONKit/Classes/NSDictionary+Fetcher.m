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
                  null:(void (^)(NSString *val))null {
    if (key.length <= 0) {
        return;
    }
    id value = self[key];
    if ([value isKindOfClass:[NSString class]]) {
        string(value);
    } else if ([value isKindOfClass:[NSNumber class]]) {
        number(value);
    } else if ([value isKindOfClass:[NSArray class]]) {
        array(value);
    } else if ([value isKindOfClass:[NSDictionary class]]) {
        dictionary(value);
    } else if ([value isKindOfClass:[NSNull class]]) {
        null(value);
    } else {
        null(value);
    }
}

- (NSString *)mc_stringForKey:(NSString *)key {
    __block NSString *retValue;
    [self mc_valueForKey:key string:^(NSString *val) {
        retValue = val;
    } number:^(NSNumber *val) {
        retValue = val.stringValue;
    } array:^(NSArray *val) {
        
    } dictionary:^(NSDictionary *val) {
        
    } null:^(NSString *val) {
        
    }];
    return retValue;
}

- (BOOL)mc_boolForKey:(NSString *)key {
    __block BOOL retValue = NO;
    [self mc_valueForKey:key string:^(NSString *val) {
        retValue = val.boolValue;
    } number:^(NSNumber *val) {
        retValue = val.boolValue;
    } array:^(NSArray *val) {
        
    } dictionary:^(NSDictionary *val) {
        
    } null:^(NSString *val) {
        
    }];
    return retValue;
}

- (NSNumber *)mc_numberForKey:(NSString *)key {
    __block NSNumber *retValue;
    [self mc_valueForKey:key string:^(NSString *val) {
    } number:^(NSNumber *val) {
        retValue = val;
    } array:^(NSArray *val) {
        
    } dictionary:^(NSDictionary *val) {
        
    } null:^(NSString *val) {
        
    }];
    return retValue;
}

- (int)mc_intForKey:(NSString *)key {
    __block int retValue = 0;
    [self mc_valueForKey:key string:^(NSString *val) {
        retValue = val.intValue;
    } number:^(NSNumber *val) {
        retValue = val.intValue;
    } array:^(NSArray *val) {
        
    } dictionary:^(NSDictionary *val) {
        
    } null:^(NSString *val) {
        
    }];
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
    } array:^(NSArray *val) {
        
    } dictionary:^(NSDictionary *val) {
        
    } null:^(NSString *val) {
        
    }];
    return retValue;
}

- (float)mc_floatForKey:(NSString *)key {
    __block float retValue = 0;
    [self mc_valueForKey:key string:^(NSString *val) {
        retValue = val.floatValue;
    } number:^(NSNumber *val) {
        retValue = val.floatValue;
    } array:^(NSArray *val) {
        
    } dictionary:^(NSDictionary *val) {
        
    } null:^(NSString *val) {
        
    }];
    return retValue;
}

- (double)mc_doubleForKey:(NSString *)key {
    __block double retValue = 0;
    [self mc_valueForKey:key string:^(NSString *val) {
        retValue = val.doubleValue;
    } number:^(NSNumber *val) {
        retValue = val.doubleValue;
    } array:^(NSArray *val) {
        
    } dictionary:^(NSDictionary *val) {
        
    } null:^(NSString *val) {
        
    }];
    return retValue;
}

- (NSArray *)mc_arrayForKey:(NSString *)key {
    __block NSArray *retValue;
    [self mc_valueForKey:key string:^(NSString *val) {
    } number:^(NSNumber *val) {
    } array:^(NSArray *val) {
        retValue = val;
    } dictionary:^(NSDictionary *val) {
        
    } null:^(NSString *val) {
        
    }];
    return retValue;
}

- (NSDictionary *)mc_dictionaryForKey:(NSString *)key {
    __block NSDictionary *retValue;
    [self mc_valueForKey:key string:^(NSString *val) {
    } number:^(NSNumber *val) {
    } array:^(NSArray *val) {
        
    } dictionary:^(NSDictionary *val) {
        retValue = val;
    } null:^(NSString *val) {
        
    }];
    return retValue;
}

@end
