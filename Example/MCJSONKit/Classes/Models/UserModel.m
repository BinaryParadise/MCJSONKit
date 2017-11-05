//
//  UserModel.m
//  iOSExample
//
//  Created by maintoco on 16/12/20.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (NSDictionary *)keyMappingDictionary {
    return @{@"uid":@"id",@"desc":@"description"};
}

+ (NSSet *)ignoreDictionary {
    return [NSSet setWithObject:@"verified_type"];
}

@end
