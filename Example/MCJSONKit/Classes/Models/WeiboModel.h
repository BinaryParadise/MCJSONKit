//
//  WeiboModel.h
//  iOSExample
//
//  Created by maintoco on 16/12/20.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboModel : NSObject

/**
 创建时间
 */
@property (nonatomic, copy) NSString *created_at;

/**
 通过字典创建模型
 
 @param data 许可类型<NSData,NSDictionary,NSString>
 @return 新创建模型对象
 
 */
+ (instancetype)jsonObjectFromData:(id)data;
+ (NSArray *)arrayOfModelsFromKeyValues:(id)keyValues;

/**
 允许的属性集合，配置后则ignoreSet失效
 */
+ (NSSet *)allowedPropertyNames;

/**
 忽略的属性集合
 */
+ (NSSet *)ignoreSet;

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
- (NSDictionary *)toDictionary;
- (NSString *)toJSONString;

@end
