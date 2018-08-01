//
//  UserModel.m
//  iOSExample
//
//  Created by maintoco on 16/12/20.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (NSDictionary *)keyMappingDictionary {
    return @{MYPropMapper(province):@"id",MYPropMapper(desc):@"description"};
}

- (NSSet *)ignoreDictionary {
    return [NSSet setWithObject:MYPropMapper(verified_type)];
}

@end
