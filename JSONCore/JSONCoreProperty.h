//
//  JSONCoreProperty.h
//  COJSONCore
//
//  Created by odyang on 16/12/6.
//  Copyright © 2016年 maintoco. All rights reserved.
//

/*
 Version: 0.0.2
 Date: 2017-03-19
 */

#import <Foundation/Foundation.h>

/**
 属性类型
 */
typedef enum : int {
    JSONCorePropertyTypeObject = -1,
    JSONCorePropertyTypeChar = 0,
    JSONCorePropertyTypeUChar = 1,
    JSONCorePropertyTypeShort = 2,
    JSONCorePropertyTypeUShort = 3,
    JSONCorePropertyTypeInt = 4,
    JSONCorePropertyTypeUInt = 5,
    JSONCorePropertyTypeLong = 6,
    JSONCorePropertyTypeLongLong = 7,
    JSONCorePropertyTypeULong = 8,
    JSONCorePropertyTypeULongLong = 9,
    JSONCorePropertyTypeFloat = 10,
    JSONCorePropertyTypeDouble = 11,
    JSONCorePropertyTypeCBool = 12
} JSONCorePropertyType;


/**
 封装类的属性
 */
@interface JSONCoreProperty : NSObject

/**
 属性名称
 */
@property (nonatomic, copy) NSString *name;

/**
 对应JSON属性名称
 */
@property (nonatomic, copy) NSString *jsonKey;

/**
 属性类型
 */
@property (nonatomic, assign) JSONCorePropertyType type;

/**
 NSNumber对应值的KeyPath
 */
@property (nonatomic, copy) NSString *keyPath;

/**
 对象类型<Class>
 */
@property (nonatomic, assign) Class typeClass;

/**
 对应NSArray的元素类型<Class>
 */
@property (nonatomic, assign) Class itemClass;

/**
 是否可变对象
 */
@property (nonatomic, assign) BOOL isMutable;

@end
