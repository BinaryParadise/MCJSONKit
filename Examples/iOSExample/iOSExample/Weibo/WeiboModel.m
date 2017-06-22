//
//  WeiboModel.m
//  iOSExample
//
//  Created by maintoco on 16/12/20.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import "WeiboModel.h"

#import "NSObject+JSONCore.h"
#import "MJExtension.h"

@implementation WeiboModel

+ (void)load {
    [self setPrettyPrinted:YES];
}

#pragma mark - 封装-JSONCore

+ (instancetype)jsonObjectFromData:(id)data {
    return [self co_objectFromKeyValues:data];
}

+ (NSArray *)arrayOfModelsFromKeyValues:(id)keyValues {
    return [self co_arrayOfModelsFromKeyValues:keyValues];
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
    return [self co_toDictionary];
}

- (NSString *)toJSONString {
    return [self co_toJSONString];
}

#pragma mark JSONCoreConfig

+ (NSDictionary *)co_allowedPropertyNames {
    return nil;
}

+ (NSDictionary *)co_keyMappingDictionary {
    return [self keyMappingDictionary];
}

+ (NSDictionary *)co_typeMappingDictionary {
    return [self typeMappingDictionary];
}

+ (NSSet *)co_ignoreDictionary {
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
