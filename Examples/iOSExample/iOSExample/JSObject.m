//
//  JSObject.m
//  iOSExample
//
//  Created by bonana on 2017/3/19.
//  Copyright © 2017年 maintoco. All rights reserved.
//

#import "JSObject.h"

@implementation JSObject

- (void)setCreated_at:(NSString *)created_at {
    NSDateFormatter *dateFmt = [NSDateFormatter new];
    dateFmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    dateFmt.locale = [NSLocale localeWithLocaleIdentifier:@"en-US"];
    
    NSDate *date = [dateFmt dateFromString:created_at];
    _created_at = @(date.timeIntervalSince1970).stringValue;
}

@end
