//
//  SimpleModel.h
//  iOSExample
//
//  Created by bonana on 2017/5/6.
//  Copyright © 2017年 maintoco. All rights reserved.
//

#import "WeiboModel.h"

@interface SimpleModel : WeiboModel

@property (nonatomic, assign) bool boolValue;  //TB
@property (nonatomic, assign) char charValue;  //Tc
@property (nonatomic, assign) unsigned char unsignedCharValue;  //TC
@property (nonatomic, assign) short shortValue; //Ts
@property (nonatomic, assign) unsigned short unsignedShortValue; //TS
@property (nonatomic, assign) int intValue; //Ti
@property (nonatomic, assign) unsigned int unsignedIntValue; //TI
@property (nonatomic, assign) long longValue;  //Tl
@property (nonatomic, assign) unsigned long unsignedLongValue;  //TL
@property (nonatomic, assign) long long longLongValue;  //Tq
@property (nonatomic, assign) unsigned long long unsignedLongLongValue;  //TQ
@property (nonatomic, assign) float floatValue; //Tf
@property (nonatomic, assign) double doubleValue;  //Td
@property (nonatomic, assign) long double longdbValue;  //Td (Objective-C does not support the long double type. @encode(long double) returns d, which is the same encoding as for double.)

@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, copy) NSString *string;
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSArray<SimpleModel *> *simpleArray;
@property (nonatomic, strong) SimpleModel *nestObj;

@end
