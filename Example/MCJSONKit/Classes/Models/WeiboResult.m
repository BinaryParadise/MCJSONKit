//
//  WeiboResult.m
//  MCJSONKit_Example
//
//  Created by Rake Yang on 2018/5/12.
//  Copyright © 2018年 MC-Studio. All rights reserved.
//

#import "WeiboResult.h"

@implementation WeiboResult

- (NSDictionary *)typeMappingDictionary {
    return @{MYPropMapper(statuses): [StatuseModel class]};
}

- (NSSet *)ignoreSet {
    return [NSSet setWithObjects:MYPropMapper(next_cursor), nil];
}

@end

@implementation WeiboResult1

- (NSSet *)allowedPropertyNames {
    return [NSSet setWithObjects:MYPropMapper(statuses), MYPropMapper(updateTime), MYPropMapper(timeStr), MYPropMapper(max_id), nil];
}

- (NSSet *)ignoreSet {
    return [NSSet setWithObjects:MYPropMapper(statuses), MYPropMapper(since_id), nil];
}

@end
