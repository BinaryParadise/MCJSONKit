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

/**
 JSON数据是否格式化输出，默认为NO
 */
@property (class, nonatomic, assign) BOOL prettyPrinted;

/**
 通过字典创建模型

 @param keyValues 许可类型<NSData,NSDictionary,NSString>
 @return 新创建模型对象
 */
+ (instancetype)co_objectFromKeyValues:(id)keyValues;

/**
 字段数组转模型数组
 */
+ (NSArray *)co_arrayOfModelsFromDictionaries:(NSArray *)array;

- (NSDictionary *)co_toDictionary;
- (NSString *)co_toJSONString;

@end

/**
 关联配置
 */
@interface NSObject (JSONCoreConfig)

/**
 允许的属性名
 */
+ (NSDictionary *)co_allowedPropertyNames;

/**
 忽略,不做处理的属性
 */
+ (NSSet *)co_ignoreDictionary;

/**
 key关联字段
 
 @return key:对象属性 value:keyPath
 */
+ (NSDictionary *)co_keyMappingDictionary;


/**
 类型关联字典
 
 @return key:对象属性   value:类型class
 */
+ (NSDictionary *)co_typeMappingDictionary;

@end
