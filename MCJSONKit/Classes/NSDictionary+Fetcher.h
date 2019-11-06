//
//  NSDictionary+Fetcher.h
//  MCJSONKit
//
//  Created by Rake Yang on 2019/6/29.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ScriptNative)

- (NSString *)mc_stringForKey:(NSString *)key;

- (NSNumber *)mc_numberForKey:(NSString *)key;

- (BOOL)mc_boolForKey:(NSString *)key;

- (int)mc_intForKey:(NSString *)key;

- (long)mc_longForKey:(NSString *)key;

- (long long)mc_longlongForKey:(NSString *)key;

- (float)mc_floatForKey:(NSString *)key;

- (double)mc_doubleForKey:(NSString *)key;

- (NSArray *)mc_arrayForKey:(NSString *)key;

- (NSDictionary *)mc_dictionaryForKey:(NSString *)key;

@end
