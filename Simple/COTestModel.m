//
//  COTestModel.m
//  COJSONCore
//
//  Created by odyang on 16/12/6.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import "COTestModel.h"

@implementation COTestModel

- (NSDictionary *)keyMappingDictionary {
    return @{@"model":@"info"};
}

- (NSDictionary *)typeMappingDictionary {
    return @{@"list":[COTestModelObject class]};
}

@end

@implementation COTestModelObject

- (NSDictionary *)keyMappingDictionary {
    return @{@"keyName":@"dict.key"};
}

@end
