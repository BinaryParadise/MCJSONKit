//
//  StatuseModel.m
//  iOSExample
//
//  Created by maintoco on 16/12/20.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import "StatuseModel.h"

@implementation StatuseModel

- (NSDictionary *)keyMappingDictionary {
    return @{@"wid":@"id",@"visible":@"visible.type"};
}

- (void)setCreated_at:(NSString *)created_at {
    NSDateFormatter *dateFmt = [NSDateFormatter new];
    dateFmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    dateFmt.locale = [NSLocale localeWithLocaleIdentifier:@"en-US"];
    
    NSDate *date = [dateFmt dateFromString:created_at];
    _created_at = @(date.timeIntervalSince1970).stringValue;
}

@end
