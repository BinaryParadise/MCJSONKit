//
//  COTestModel.h
//  COJSONCore
//
//  Created by odyang on 16/12/6.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import "COBaseModel.h"

@class COTestModelObject;

/**
 测试Model
 */
@interface COTestModel : COBaseModel

#pragma mark 基础类型
@property (nonatomic, assign,readonly) char p_char;
@property (nonatomic, assign) Byte pbyte;
@property (nonatomic, assign) BOOL pbool;
@property (nonatomic, assign) short pshort;
@property (nonatomic, assign) int p_int;
@property (nonatomic, assign) long p_long;
@property (nonatomic, assign) long long p_longlong;
@property (nonatomic, assign) unsigned long p_ulong;
@property (nonatomic, assign) unsigned long long p_ulonglong;
@property (nonatomic, assign) float p_float;
@property (nonatomic, assign) double p_double;
@property (nonatomic, assign) long double p_longdouble;
@property (nonatomic, assign) NSInteger p_integer;
@property (nonatomic, assign) NSUInteger p_uinteger;
@property (nonatomic, assign) bool p_cbool;
@property (nonatomic, retain) COTestModelObject *model;
@property (nonatomic, retain) NSArray<COTestModelObject *> *list;

@end

@interface COTestModelObject : COBaseModel

#pragma mark 对象类型
@property (nonatomic, copy) NSString *str;
@property (nonatomic, retain) NSMutableString *mstr;
@property (nonatomic, retain) NSNumber *number;
@property (nonatomic, copy) NSArray *arr;
@property (nonatomic, retain) NSMutableArray *marr;
@property (nonatomic, copy) NSDictionary *dict;
@property (nonatomic, retain) NSMutableDictionary *mdict;
@property (nonatomic, retain) NSSet *set;
@property (nonatomic, retain) NSMutableSet *mset;
@property (nonatomic, copy) NSString *keyName;

@end
