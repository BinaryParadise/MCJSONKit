//
//  WeiboModel.m
//  iOSExample
//
//  Created by maintoco on 16/12/20.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import "WeiboModel.h"
#import "MJExtension.h"

#import <MCJSONKit/MCJSONKit.h>

@implementation WeiboModel

+ (void)load {
    [self setPrettyPrinted:YES];
}
    
- (void)setCreated_at:(NSString *)created_at {
    NSDateFormatter *dateFmt = [NSDateFormatter new];
    dateFmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    dateFmt.locale = [NSLocale localeWithLocaleIdentifier:@"en-US"];
    
    NSDate *date = [dateFmt dateFromString:created_at];
    _created_at = @(date.timeIntervalSince1970).stringValue;
}

#pragma mark - 封装-JSONCore

+ (instancetype)jsonObjectFromData:(id)data {
    return [self mc_objectFromKeyValues:data];
}

+ (NSArray *)arrayOfModelsFromKeyValues:(id)keyValues {
    return [self mc_arrayOfModelsFromKeyValues:keyValues];
}

+ (NSSet *)allowedPropertyNames {
    return nil;
}

+ (NSDictionary *)keyMappingDictionary {
    return nil;
}

+ (NSDictionary *)typeMappingDictionary {
    return nil;
}

+ (NSSet *)ignoreSet {
    return nil;
}

- (NSDictionary *)toDictionary {
    return [self mc_toDictionary];
}

- (NSString *)toJSONString {
    return [self mc_JSONString];
}

#pragma mark JSONCoreConfig

+ (NSSet *)mc_allowedPropertiesSet {
    return [self allowedPropertyNames];
}

+ (NSDictionary *)mc_keyMappingDictionary {
    return [self keyMappingDictionary];
}

+ (NSDictionary *)mc_typeMappingDictionary {
    return [self typeMappingDictionary];
}

+ (NSSet *)mc_ignorePropertiesSet {
    return [self ignoreSet];
}

#pragma mark - 封装-MJExtension
/*
+ (instancetype)jsonObjectFromData:(id)data {
    return [self mj_objectWithKeyValues:data];
}

+ (NSArray *)arrayOfModelsFromDictionaries:(NSArray *)array {
    return [self mj_objectArrayWithKeyValuesArray:array];
}

+ (NSArray *)allowedPropertyNames {
    return nil;
}

+ (NSDictionary *)keyMappingDictionary {
    return nil;
}

+ (NSDictionary *)typeMappingDictionary {
    return nil;
}

+ (NSSet *)ignoreSet {
    return nil;
}

- (NSDictionary *)toDictionary {
    return [self mj_keyValues];
}

- (NSString *)toJSONString {
    return [self mj_JSONString];
}

+ (NSArray *)mj_ignoredPropertyNames {
    return [self ignoreSet].allObjects;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return [self keyMappingDictionary];
}

+ (NSDictionary *)mj_objectClassInArray {
    return [self typeMappingDictionary];
}

+ (NSArray *)mj_allowedPropertyNames {
    return [self allowedPropertyNames];
}*/

@end
