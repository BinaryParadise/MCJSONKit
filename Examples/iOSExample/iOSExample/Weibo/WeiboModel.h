//
//  WeiboModel.h
//  iOSExample
//
//  Created by maintoco on 16/12/20.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSObject.h"

@interface WeiboModel : JSObject


/**
 通过字典创建模型
 
 @param data 许可类型<NSData,NSDictionary,NSString>
 @return 新创建模型对象
 
 */
+ (instancetype)jsonObjectFromData:(id)data;
+ (NSArray *)arrayOfModelsFromDictionaries:(NSArray *)array;

/**
 允许的属性名
 */
+ (NSArray *)allowedPropertyNames;

/**
 key关联字段
 
 @return key:对象属性 value:keyPath
 */
+ (NSDictionary *)keyMappingDictionary;


/**
 类型关联字典
 
 @return key:对象属性   value:类型class
 */
+ (NSDictionary *)typeMappingDictionary;


/**
 忽略,不做处理的属性
 */
+ (NSSet *)ignoreSet;

- (NSDictionary *)toDictionary;
- (NSString *)toJSONString;

@end
