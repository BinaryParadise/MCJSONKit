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

#pragma mark - JSONCore

/*
+ (instancetype)objectFromJSONString:(NSString *)jsonString {
    return [self.class co_objectFromJSONString:jsonString];
}
+ (instancetype)objectFromDictionary:(NSDictionary *)dict {
    return [self.class co_objectFromDictionary:dict];
}
+ (NSArray *)arrayOfModelsFromDictionaries:(NSArray *)array {
    return [self.class co_arrayOfModelsFromDictionaries:array];
}

- (NSDictionary *)keyMappingDictionary {
    return [self co_keyMappingDictionary];
}

- (NSDictionary *)typeMappingDictionary {
    return [self co_typeMappingDictionary];
}

- (NSSet *)ignoreDictionary {
    return [self co_ignoreDictionary];
}

- (NSDictionary *)toDictionary {
    return [self co_toDictionary];
}

- (NSString *)toJSONString {
    return [self co_toJSONString];
}*/

#pragma mark - MJExtension

+ (void)load {
    //忽略属性
    [self.class mj_setupIgnoredPropertyNames:^NSArray *{
        return [self.class ignoreSet].allObjects;
    }];
    //属性名对应JSON中的key
    [self.class mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return [self.class keyMappingDictionary];
    }];
    //数组中需要转换的模型类
    [self.class mj_setupObjectClassInArray:^NSDictionary *{
        return [self.class typeMappingDictionary];
    }];
}

+ (instancetype)objectFromJSONString:(NSString *)jsonString {
    id obj = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    return [self.class mj_objectWithKeyValues:obj];
}
+ (instancetype)objectFromDictionary:(NSDictionary *)dict {
    return [self.class mj_objectWithKeyValues:dict];
}
+ (NSArray *)arrayOfModelsFromDictionaries:(NSArray *)array {
    return [self.class mj_objectArrayWithKeyValuesArray:array];
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


@end
