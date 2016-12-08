//
//  JSONCore.m
//  COJSONCore
//
//  Created by odyang on 16/12/6.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import <objc/runtime.h>

#import "JSONCore.h"
#import "JSONCoreProperty.h"

static NSArray *allowedJSONTypes;//允许的对象类型
static NSDictionary *allowedPrimitiveTypes;//允许的基础类型
static const char *kClassPropertiesKey;

@implementation JSONCore

+ (void)load {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        @autoreleasepool {
            allowedJSONTypes = @[[NSString class],
                                 [NSNumber class],
                                 [NSDecimalNumber class],
                                 [NSDate class],
                                 [NSArray class],
                                 [NSMutableArray class],
                                 [NSDictionary class],
                                 [NSMutableString class],
                                 [NSMutableDictionary class],
                                 [NSSet class],
                                 [NSMutableSet class]];
            
            allowedPrimitiveTypes = @{@"Tc":@[@"0",@"charValue"],
                                      @"TC":@[@"1",@"unsignedCharValue"],
                                      @"Ts":@[@"2",@"shortValue"],
                                      @"TS":@[@"3",@"unsignedShortValue"],
                                      @"Ti":@[@"4",@"intValue"],
                                      @"TI":@[@"5",@"unsignedIntValue"],
                                      @"Tl":@[@"6",@"longValue"],
                                      @"TL":@[@"7",@"unsignedLongValue"],
                                      @"Tq":@[@"8",@"longLongValue"],
                                      @"TQ":@[@"9",@"unsignedLongLongValue"],
                                      @"Tf":@[@"10",@"floatValue"],
                                      @"Td":@[@"11",@"doubleValue"],
                                      @"TB":@[@"12",@"boolValue"]};
        }
        
    });
    
}

+ (instancetype)objectFromJSONString:(NSString *)jsonString {
    JSONCore *jsonCore = [[self.class alloc] init];
    [jsonCore setValuesWithJSONString:jsonString];
    return jsonCore;
}

+ (instancetype)objectFromDictionary:(NSDictionary *)dict {
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        JSONCore *jsonCore = [[self.class alloc] init];
        [jsonCore setValuesWithDictionary:dict];
        return jsonCore;
    }
    return nil;
}

+ (NSArray *)arrayOfModelsFromDictionaries:(NSArray *)array {
    if (array && [array isKindOfClass:[NSArray class]]) {
        NSMutableArray *marr = [NSMutableArray arrayWithCapacity:array.count];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JSONCore *jsonCore = [[self.class alloc] init];
            [jsonCore setValuesWithDictionary:obj];
            [marr addObject:jsonCore];
        }];
        return [marr copy];
    }
    return nil;
}

- (void)setValuesWithJSONString:(NSString *)jsonString {
    NSError *error;
    NSDictionary<NSString *,id> *dict = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error];
    [self setValuesWithDictionary:dict];
}

- (void)setValuesWithDictionary:(NSDictionary *)dict {
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary<NSString *,JSONCoreProperty *> *mdict = [self allProperties];
        [mdict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, JSONCoreProperty * _Nonnull obj, BOOL * _Nonnull stop) {
            if ([obj.jsonKey rangeOfString:@"."].location == NSNotFound) {
                [self setValue:dict[obj.jsonKey] forProperty:obj];
            }else {
                id value = [dict valueForKeyPath:obj.jsonKey];
                if (![value isKindOfClass:[NSNull class]]) {
                    [self setValue:value forProperty:obj];
                }
            }
        }];
    }
}


/**
 设置属性值
 */
- (void)setValue:(id)value forProperty:(JSONCoreProperty *)property {
    if (property) {
        if (property.type == JSONCorePropertyTypeObject) {
            if ([value isKindOfClass:[NSNull class]]) {
                return;
            }
            if ([allowedJSONTypes containsObject:property.typeClass]) {
                //系统默认对象
                if ([value isKindOfClass:property.typeClass]) {
                    if (property.itemClass) {
                        //自定义对象数组
                        id obj = [property.itemClass arrayOfModelsFromDictionaries:value];
                        [self setValue:obj forKey:property.name];
                    }else {
                        id newValue = value;
                        if (property.isMutable) {
                            if ([value respondsToSelector:@selector(mutableCopy)]) {
                                newValue = [value mutableCopy];
                            }
                        }
                        [self setValue:newValue forKey:property.name];
                    }
                }else {
                    if ([value isKindOfClass:[NSNumber class]]) {
                        if ([property.typeClass isSubclassOfClass:[NSString class]]) {
                            //属性是NSString，但是值类型为NSNumber
                            [self setValue:[value stringValue] forKey:property.name];
                        }else if ([property.typeClass isSubclassOfClass:[NSDate class]]) {
                            //属性是NSDate，但是值类型为NSNumber
                            double timeInterval = [value doubleValue];
                            if (timeInterval > 10000000000) {//时间戳为毫秒
                                timeInterval = timeInterval/1000.0;
                            }
                            [self setValue:[NSDate dateWithTimeIntervalSince1970:timeInterval] forKey:property.name];
                        }
                    }else {
                        if ([value isKindOfClass:[NSString class]]) {
                            if ([property.typeClass isSubclassOfClass:[NSDate class]]) {
                                //属性是NSDate，但是值类型为NSString
                                double timeInterval = [value doubleValue];
                                if (timeInterval > 10000000000) {//时间戳为毫秒
                                    timeInterval = timeInterval/1000.0;
                                }
                                [self setValue:[NSDate dateWithTimeIntervalSince1970:timeInterval] forKey:property.name];
                            }
                        }
                    }
                }
            }else {
                //自定义对象
                id obj = [property.typeClass objectFromDictionary:value];
                [self setValue:obj forKey:property.name];
            }
        }else {
            NSNumber *number = value;
            if ([number isKindOfClass:[NSNumber class]]) {
                [self setValue:[number valueForKey:property.keyPath] forKey:property.name];
            }
        }
    }
}

- (id)valueForProperty:(JSONCoreProperty *)property {
    if (property) {
        id value = [self valueForKey:property.name];
        if (property.type == JSONCorePropertyTypeObject) {
            if ([allowedJSONTypes containsObject:property.typeClass]) {
                //系统默认对象
                if ([value isKindOfClass:property.typeClass]) {
                    if (property.itemClass) {
                        //自定义对象数组
                        NSMutableArray *marr = [NSMutableArray array];
                        [value enumerateObjectsUsingBlock:^(JSONCore *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            [marr addObject:[obj toDictionary]];
                        }];
                        return [marr copy];
                    }else if ([value isKindOfClass:[NSDate class]]) {
                        return @([(NSDate *)value timeIntervalSince1970]);
                    }
                    else {
                        return value;
                    }
                }
            }else {
                //自定义对象
                if ([value isKindOfClass:[JSONCore class]]) {
                    return [value toDictionary];
                }
            }
        }else {
            return value;
        }
    }
    return nil;
}

/**
 对象的属性集合
 */
- (NSMutableDictionary *)allProperties {
    NSMutableDictionary *mdict = objc_getAssociatedObject(self.class, &kClassPropertiesKey);
    if (mdict) {
        return mdict;
    }
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList(self.class, &outCount);
    mdict = [NSMutableDictionary dictionary];
    
    NSScanner *scanner;
    NSSet *ignoreSet = [self ignoreDictionary];
    NSDictionary *keyMapping = [self keyMappingDictionary];
    NSDictionary *typeMapping = [self typeMappingDictionary];
    for (unsigned int i = 0; i<outCount; i++) {
        objc_property_t property = properties[i];
        //属性名
        const char *propertyName = property_getName(property);
        if ([ignoreSet containsObject:[NSString stringWithUTF8String:propertyName]]) {
            continue;
        }
        
        //特性
        const char *attrs = property_getAttributes(property);
        NSString* propertyAttributes = @(attrs);
        NSArray<NSString *> *attributeItems = [propertyAttributes componentsSeparatedByString:@","];
        
        //忽略只读属性
        if ([attributeItems containsObject:@"R"]) {
            continue;
        }
        
        //忽略long double(C类型)
        if ([attributeItems.firstObject isEqualToString:@"TD"]) {
            continue;
        }
        
        NSString *typeStr = attributeItems.firstObject;
        JSONCoreProperty *coprop = [JSONCoreProperty new];
        coprop.name = [NSString stringWithUTF8String:propertyName];
        
        if (keyMapping && [keyMapping.allKeys containsObject:coprop.name]) {
            coprop.jsonKey = keyMapping[coprop.name];
        }else {
            coprop.jsonKey = coprop.name;
        }
        
        if ([allowedPrimitiveTypes.allKeys containsObject:typeStr]) {
            coprop.type = [allowedPrimitiveTypes[typeStr][0] intValue];
            coprop.keyPath = allowedPrimitiveTypes[typeStr][1];
        }else {
            scanner = [NSScanner scannerWithString:propertyAttributes];
            [scanner scanUpToString:@"T" intoString:nil];
            [scanner scanString:@"T" intoString:nil];
            NSString *typeCls;
            if ([scanner scanString:@"@\"" intoString:&typeCls]) {
                [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\"<"]
                                        intoString:&typeCls];
                coprop.typeClass = NSClassFromString(typeCls);
                coprop.isMutable = [typeCls rangeOfString:@"Mutable"].location!=NSNotFound;
                coprop.type = JSONCorePropertyTypeObject;
                //NSLog(@"%s - %@",propertyName,propertyAttributes);
            }
            
            if (typeMapping && [typeMapping.allKeys containsObject:coprop.name]) {
                coprop.itemClass = typeMapping[coprop.name];
            }
        }
        
        [mdict setObject:coprop forKey:coprop.name.lowercaseString];
    }
    objc_setAssociatedObject(self.class, &kClassPropertiesKey, mdict, OBJC_ASSOCIATION_RETAIN);
    return mdict;
}

- (NSSet *)ignoreDictionary {
    return nil;
}

- (NSDictionary *)keyMappingDictionary {
    return nil;
}

- (NSDictionary *)typeMappingDictionary {
    return nil;
}

- (NSDictionary *)toDictionary {
    NSDictionary<NSString *,JSONCoreProperty *> *dict = [self allProperties];
    NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, JSONCoreProperty * _Nonnull obj, BOOL * _Nonnull stop) {
        id value = [self valueForProperty:obj];
        if (value) {
            [mdict setObject:value forKey:obj.jsonKey];
        }else {
            [mdict setObject:[NSNull null] forKey:obj.jsonKey];
        }
    }];
    return mdict;
}

- (NSString *)toJSONString {
    NSDictionary *dict =[self toDictionary];
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    if (!error) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

@end
