//
//  NSArray+MCJSONKit.h
//  PepperExample
//
//  Created by mylcode on 2018/3/20.
//  Copyright © MC-Studio CO., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (MCJSONKit)

/**
 将模型数组转换为字典数组
 */
- (NSArray<NSDictionary *> *)toDictionaryArray;

@end
