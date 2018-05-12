//
//  WeiboResult.m
//  MCJSONKit_Example
//
//  Created by mylcode on 2018/5/12.
//  Copyright © 2018年 MC-Studio. All rights reserved.
//

#import "WeiboResult.h"

@implementation WeiboResult

+ (NSDictionary *)typeMappingDictionary {
    return @{@"statuses": [StatuseModel class]};
}

@end
