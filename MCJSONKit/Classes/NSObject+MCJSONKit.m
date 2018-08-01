//
//  NSObject+JSONCore.m
//  iOSExample
//
//  Created by maintoco on 16/12/21.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import "NSObject+MCJSONKit.h"
#import "MCJSONKitProperty.h"
#import "NSDictionary+MCJSONKit.h"

#import <objc/runtime.h>

#if DEBUG
    #define JKLog(fmt, ...) NSLog((@"[MCJSONKit] " fmt), ##__VA_ARGS__);
#else
    #define JKLog(fmt, ...)
#endif

static NSArray *allowedJSONTypes;//允许的对象类型
//static NSSet *allowedPrimitiveTypes;//允许的基本数据类型
static const char *kClassPropertiesKey;
static BOOL _prettyPrinted;

@implementation NSObject (MCJSONKit)

+ (BOOL)prettyPrinted {
    return _prettyPrinted;
}

+ (void)setPrettyPrinted:(BOOL)prettyPrinted {
    _prettyPrinted = prettyPrinted;
}

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
        }
        
    });
    
}

+ (instancetype)mc_objectFromKeyValues:(id)keyValues {
    if (keyValues == nil || [keyValues isKindOfClass:[NSNull class]]) {
        return nil;
    }
    NSObject *jsonObject;
    if ([keyValues isKindOfClass:[NSString class]]) {
        jsonObject = [[self alloc] init];
        [jsonObject setValuesWithJSONString:keyValues];
    }else if([keyValues isKindOfClass:[NSData class]]) {
        NSError *error;
        id obj = [NSJSONSerialization JSONObjectWithData:keyValues options:kNilOptions error:&error];

        if (error) {
#if DEBUG
            NSLog(@"%@",error);
#endif
        }else {
            jsonObject = [[self alloc] init];
            [jsonObject setValuesWithDictionary:obj];
        }
    }else if([keyValues isKindOfClass:[NSDictionary class]]) {
        jsonObject = [[self alloc] init];
        [jsonObject setValuesWithDictionary:keyValues];
    }
    return jsonObject;
}

+ (NSArray *)mc_arrayOfModelsFromKeyValues:(id)keyValues {
    if (!keyValues || [keyValues isKindOfClass:[NSNull class]]) {
        return nil;
    }
    NSArray *array;
    NSError *error;
    if ([keyValues isKindOfClass:[NSArray class]]) {
        array = keyValues;
    }else if ([keyValues isKindOfClass:[NSString class]]) {
        array = [NSJSONSerialization JSONObjectWithData:[keyValues dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    }else if ([keyValues isKindOfClass:[NSData class]]) {
        array = [NSJSONSerialization JSONObjectWithData:keyValues options:kNilOptions error:&error];
    }
#if DEBUG
    JKLog(@"%@", error)
#endif
    if (!array) {
        return nil;
    }
    NSMutableArray *marr = [NSMutableArray arrayWithCapacity:array.count];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSObject *jsonCore = [[self alloc] init];
        [jsonCore setValuesWithDictionary:obj];
        [marr addObject:jsonCore];
    }];
    return [marr copy];
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
    if ([value isKindOfClass:[NSNull class]]) {
        //NSNull不做处理
        return;
    }
    if (value && property) {
        if (property.typeClass) {
            if ([allowedJSONTypes containsObject:property.typeClass]) {
                //系统内置对象
                if ([value isKindOfClass:property.typeClass]) {
                    if (property.itemClass) {
                        //自定义对象数组
                        id obj = [property.itemClass mc_arrayOfModelsFromKeyValues:value];
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
                            NSTimeInterval timeInterval = [value doubleValue];
                            if (timeInterval > 10000000000) {//时间戳为毫秒
                                timeInterval = floor(timeInterval/1000.0);
                            }
                            [self setValue:[NSDate dateWithTimeIntervalSince1970:timeInterval] forKey:property.name];
                        }
                    }else {
                        if ([value isKindOfClass:[NSString class]]) {
                            if ([property.typeClass isSubclassOfClass:[NSDate class]]) {
                                //属性是NSDate，但是值类型为NSString
                                double timeInterval = [value doubleValue];
                                if (timeInterval > 10000000000) {//时间戳为毫秒
                                    timeInterval = floor(timeInterval/1000.0);
                                }
                                [self setValue:[NSDate dateWithTimeIntervalSince1970:timeInterval] forKey:property.name];
                            }
                        }
                    }
                }
            }else {
                //自定义对象
                id obj = [property.typeClass mc_objectFromKeyValues:value];
                [self setValue:obj forKey:property.name];
            }
        }else {
            [self setValue:value forKey:property.name];
        }
    }
}

- (id)valueForProperty:(JSONCoreProperty *)property {
    if (property) {
        id value = [self valueForKey:property.name];
        if (property.typeClass) {
            if ([allowedJSONTypes containsObject:property.typeClass]) {
                //系统默认对象
                if ([value isKindOfClass:property.typeClass]) {
                    if (property.itemClass) {
                        //自定义对象数组
                        NSMutableArray *marr = [NSMutableArray array];
                        [value enumerateObjectsUsingBlock:^(NSObject *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            [marr addObject:[obj mc_toDictionary]];
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
                if ([value isKindOfClass:[NSObject class]]) {
                    return [value mc_toDictionary];
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
    mdict = [NSMutableDictionary dictionary];
    
    void(^fetchProperties)(Class) = ^(Class cls) {
        unsigned int outCount;
        objc_property_t *properties = class_copyPropertyList(cls, &outCount);
        
        NSScanner *scanner;
        NSObject *jsonObj = [[cls alloc] init];
        NSSet *ignoreSet = [jsonObj mc_ignorePropertiesSet];
        NSDictionary *keyMapping = [jsonObj mc_keyMappingDictionary];
        NSDictionary *typeMapping = [jsonObj mc_typeMappingDictionary];
        NSSet *allowSet = [jsonObj mc_allowedPropertiesSet];
        for (unsigned int i = 0; i<outCount; i++) {
            objc_property_t property = properties[i];
            //属性名称
            NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
            if (allowSet) {
                if (![allowSet containsObject:propertyName]) {
                    //未加入到允许集合则忽略
                    continue;
                }
            } else {
                if ([ignoreSet containsObject:propertyName]) {
                    //忽略属性
                    continue;
                }
            }
            
            //特性
            const char *attrs = property_getAttributes(property);
            NSString* propertyAttributes = @(attrs);
            NSArray<NSString *> *attributeItems = [propertyAttributes componentsSeparatedByString:@","];
            
            //忽略readonly属性
            if ([attributeItems containsObject:@"R"]) {
                continue;
            }
            
            //忽略long double(C类型,Objective-C不支持，等价于double类型)
            if ([attributeItems.firstObject isEqualToString:@"TD"]) {
                continue;
            }
            
            //类型说明
            JSONCoreProperty *coprop = [JSONCoreProperty new];
            coprop.name = propertyName;
            
            //自定义映射
            if (keyMapping && [keyMapping.allKeys containsObject:coprop.name]) {
                coprop.jsonKey = keyMapping[coprop.name];
            }else {
                coprop.jsonKey = coprop.name;
            }
            
            if ([propertyAttributes hasPrefix:@"T@"]) {
                /*
                 对象的类型说明
                 //系统类型
                 T@"NSNumber",&,N,V_propertyName
                 T@"NSDate",&,N,V_propertyName
                 T@"NSString",C,N,V_propertyName
                 T@"NSDictionary",&,N,V_propertyName
                 T@"NSString",C,N,V_propertyName
                 //自定义对象
                 T@"CustomObject",&,N,V_propertyName
                 */
                scanner = [NSScanner scannerWithString:propertyAttributes];
                NSString *typeCls;
                if ([scanner scanString:@"T@\"" intoString:&typeCls]) {
                    [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\"<"]
                                            intoString:&typeCls];
                    coprop.typeClass = NSClassFromString(typeCls);
                    coprop.isMutable = [typeCls rangeOfString:@"Mutable"].location!=NSNotFound;
                    //NSLog(@"%s - %@",propertyName,propertyAttributes);
                }
            }else {
                //基本类型
                //NSLog(@"%@",propertyAttributes);
            }
            
            if (typeMapping && [typeMapping.allKeys containsObject:coprop.name]) {
                coprop.itemClass = typeMapping[coprop.name];
            }
            
            [mdict setObject:coprop forKey:coprop.name.lowercaseString];
        }
    };
    
    if (![self isMemberOfClass:[NSObject class]]) {
        Class cls = self.class;
        fetchProperties(cls);
        while (cls.superclass != [NSObject class]) {
            cls = cls.superclass;
            fetchProperties(cls);
        }
    }
    
    objc_setAssociatedObject(self.class, &kClassPropertiesKey, mdict, OBJC_ASSOCIATION_RETAIN);
    return mdict;
}

- (NSDictionary *)mc_toDictionary {
    NSAssert(![self isKindOfClass:[NSArray class]], @"Can't convert NSArray to NSDictionary");
    id jsonObj = [self _jsonObjectWithData:self];
    if (jsonObj) {
        return jsonObj;
    }
    
    NSDictionary<NSString *,JSONCoreProperty *> *dict = [self allProperties];
    NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, JSONCoreProperty * _Nonnull obj, BOOL * _Nonnull stop) {
        void(^setValueBlock)(id) = ^(id value) {
            if (value) {
                [mdict setValue:value forKeyPath:obj.jsonKey];
            }else {
                [mdict setValue:[NSNull null] forKeyPath:obj.jsonKey];
            }
        };
        id value = [self valueForProperty:obj];
        if ([obj.jsonKey rangeOfString:@"."].location == NSNotFound) {
            setValueBlock(value);
        }else {
            [mdict mc_setValue:value forKeyPath:obj.jsonKey];
        }
        
    }];
    return mdict;
}

- (NSString *)mc_JSONString {
    NSDictionary *dict = [self mc_toDictionary];
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:[self.class prettyPrinted]?NSJSONWritingPrettyPrinted:kNilOptions error:&error];
    if (!error && dict.count > 0) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

#pragma mark - JSONObject

/**
 @param data NSString or NSData
 */
- (id)_jsonObjectWithData:(id)data {
    if ([data isKindOfClass:[NSDictionary class]] || [data isKindOfClass:[NSArray class]]) {
        return (id)self;
    } else if ([data isKindOfClass:[NSString class]]) {
        return [self _jsonObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding]];
    } else if ([data isKindOfClass:[NSData class]]) {
        return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    }
    return nil;
}

@end

@implementation NSObject (JSONCoreConfig)

- (NSSet *)mc_allowedPropertiesSet {
    return nil;
}

- (NSSet *)mc_ignorePropertiesSet {
    return nil;
}

- (NSDictionary *)mc_keyMappingDictionary {
    return nil;
}

- (NSDictionary *)mc_typeMappingDictionary {
    return nil;
}

@end
