//
//  JSONCoreProperty.h
//  COJSONCore
//
//  Created by odyang on 16/12/6.
//  Copyright © 2016年 maintoco. All rights reserved.
//

/*
 Version: 0.1.0
 Date: 2017-05-19
 */

#import <Foundation/Foundation.h>

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
 对象类型<Class>
 */
@property (nonatomic, assign) Class typeClass;

/**
 对应NSArray的元素类型<Class>
 */
@property (nonatomic, assign) Class itemClass;

/**
 是否可变对象<NSMutableArray, NSMutableDictionary, NSMutableSet>
 */
@property (nonatomic, assign) BOOL isMutable;

@end
