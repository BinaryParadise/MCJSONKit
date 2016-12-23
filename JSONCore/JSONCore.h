//
//  JSONCore.h
//  COJSONCore
//
//  Created by odyang on 16/12/6.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 JSON转换类
 */
@interface JSONCore : NSObject

+ (instancetype)co_objectFromJSONString:(NSString *)jsonString;
+ (instancetype)co_objectFromDictionary:(NSDictionary *)dict;
+ (NSArray *)co_arrayOfModelsFromDictionaries:(NSArray *)array;


/**
 key关联字段

 @return key:对象属性 value:keyPath
 */
- (NSDictionary *)co_keyMappingDictionary;


/**
 类型关联字典

 @return key:对象属性   value:类型class
 */
- (NSDictionary *)co_typeMappingDictionary;


/**
 忽略,不做处理的属性
 */
- (NSSet *)co_ignoreDictionary;

- (NSDictionary *)co_toDictionary;
- (NSString *)co_toJSONString;

@end
