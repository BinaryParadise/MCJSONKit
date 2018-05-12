//
//  MCJSONKitTests.m
//  MCJSONKitTests
//
//  Created by mylcode on 11/04/2017.
//  Copyright (c) 2017 mylcode. All rights reserved.
//

#define JSONFileData(fileName) [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:fileName ofType:nil]]

#import <MCJSONKit/MCJSONKit.h>
#import "WeiboResult.h"

SPEC_BEGIN(Tests)

    describe(@"baseic usage", ^{
        
        context(@"normal json model", ^{
            __block WeiboResult *result;
            beforeAll(^{
                NSDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:JSONFileData(@"friends_timeline.json") options:NSJSONReadingMutableContainers error:nil];
                result = [WeiboResult jsonObjectFromData:jsonObj];
                result = [WeiboResult jsonObjectFromData:JSONFileData(@"friends_timeline.json")];
            });
            
            it(@"nil", ^{
                [[[WeiboResult jsonObjectFromData:nil] should] beNil];
            });
            
            it(@"NSString", ^{
                [[[WeiboResult jsonObjectFromData:@"{}"] shouldNot] beNil];
            });
            
            it(@"error NSString", ^{
                [[[WeiboResult jsonObjectFromData:[@"{x}" dataUsingEncoding:NSUTF8StringEncoding]] should] beNil];
            });
            
            it(@"data type assert", ^{
                [[result shouldNot] beNil];                
                [[theValue(result.statuses.count) shouldNot] equal:@0];
                [[theValue(result.since_id) should] equal:@4238834142630389];
            });
            
            it(@"prettyPrinted", ^{
                WeiboResult.prettyPrinted = NO;
                NSString *stored = result.mc_JSONString;
                [[theValue(stored.length) should] equal:@38335];
                WeiboResult.prettyPrinted = YES;
                stored = result.mc_JSONString;
                [[theValue(stored.length) should] equal:@53698];

            });
            
            it(@"to NSArray", ^{
                [[result.statuses.toDictionaryArray shouldNot] beNil];
            });
            
            afterAll(^{
                result = nil;
            });
        });
        
        context(@"json <> NSString <> NSDictionary", ^{
            NSString *jsonStr = @"{\"name\":\"iPhone\"}";
            it(@"NSString to NSDictionary", ^{
                [[jsonStr.mc_toDictionary shouldNot] beNil];
                [[jsonStr.mc_toDictionary should] beKindOfClass:NSDictionary.class];
            });
            
            it(@"NSData to NSDictionary", ^{
                NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                [[data.mc_toDictionary shouldNot] beNil];
                [[data.mc_toDictionary should] beKindOfClass:NSDictionary.class];
            });
            
            it(@"NSDictionary to NSString", ^{
                NSDictionary *dict = @{@"name": @"iPhone", @"extend":[NSNull null]};
                NSString *jsonStr = dict.mc_JSONString;
                [[jsonStr shouldNot] beNil];
                [[jsonStr should] beKindOfClass:NSString.class];
                [[jsonStr should] containString:@"null"];
            });
        });
    });

SPEC_END
