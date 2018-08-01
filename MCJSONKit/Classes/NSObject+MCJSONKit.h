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
@interface NSObject (MCJSONKit)

/**
 JSON数据是否格式化输出，默认为NO
 */
@property (class, nonatomic, assign) BOOL prettyPrinted;

/**
 通过字典创建模型

 @param keyValues 许可类型<NSData,NSDictionary,NSString>
 @return 新创建模型对象
 */
+ (instancetype)mc_objectFromKeyValues:(id)keyValues;

/**
 通过字典数组来创建一个模型数组
 @param keyValues 许可类型<NSData,NSArray,NSString>
 */
+ (NSArray *)mc_arrayOfModelsFromKeyValues:(id)keyValues;

- (NSDictionary *)mc_toDictionary;
- (NSString *)mc_JSONString;

@end

/**
 关联配置
 */
@interface NSObject (JSONCoreConfig)

/**
 允许的属性集合，重写后则mc_ignorePropertiesSet失效
 */
- (NSSet *)mc_allowedPropertiesSet;

/**
 忽略的属性集合
 */
- (NSSet *)mc_ignorePropertiesSet;

/**
 key关联字段
 
 @return key:对象属性 value:keyPath
 */
- (NSDictionary *)mc_keyMappingDictionary;

/**
 类型关联字典
 
 @return key:对象属性   value:类型class
 */
- (NSDictionary *)mc_typeMappingDictionary;

@end
