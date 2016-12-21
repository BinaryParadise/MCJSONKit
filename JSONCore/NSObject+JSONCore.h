//
//  NSObject+JSONCore.h
//  iOSExample
//
//  Created by maintoco on 16/12/21.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 JSON解析类别
 */
@interface NSObject (JSONCore)

+ (instancetype)objectFromJSONString:(NSString *)jsonString;
+ (instancetype)objectFromDictionary:(NSDictionary *)dict;
+ (NSArray *)arrayOfModelsFromDictionaries:(NSArray *)array;


/**
 key关联字段
 
 @return key:对象属性 value:keyPath
 */
- (NSDictionary *)keyMappingDictionary;


/**
 类型关联字典
 
 @return key:对象属性   value:类型class
 */
- (NSDictionary *)typeMappingDictionary;


/**
 忽略,不做处理的属性
 */
- (NSSet *)ignoreDictionary;

- (NSDictionary *)toDictionary;
- (NSString *)toJSONString;

@end
