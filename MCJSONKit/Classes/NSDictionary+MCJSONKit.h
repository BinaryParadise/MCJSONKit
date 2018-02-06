//
//  NSMutableDictionary+JSONCore.h
//  iOSExample
//
//  Created by maintoco on 16/12/23.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (MCJSONKit)

/**
 通过keyPath设置值,系统的setValue:forKeyPath方法没有上级节点时不能生效

 @param value 值
 @param keyPath 路的径
 */
- (void)mc_setValue:(id)value forKeyPath:(NSString *)keyPath;

@end
