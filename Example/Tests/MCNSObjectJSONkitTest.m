//
//  MCNSObjectJSONkitTest.m
//  MCJSONKit_Tests
//
//  Created by mylcode on 2018/5/13.
//  Copyright © 2018年 MC-Studio. All rights reserved.
//

#import "WeiboResult.h"

SPEC_BEGIN(MCNSObjectJSONkitTest)

describe(@"NSObject+MCJSONKit", ^{
    context(@"transform NSDictionary to Model", ^{
        MCLogDebug(@"%@",[NSBundle bundleForClass:self.class].bundlePath);
        __block WeiboResult *result;
        beforeAll(^{
            NSDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:JSONFileData(kFriendsTimelineFile1) options:NSJSONReadingMutableContainers error:nil];
            result = [WeiboResult jsonObjectFromData:jsonObj];
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
            [[theValue(result.since_id) should] equal:@4238558845532583];
        });
        
        it(@"prettyPrinted", ^{
            WeiboResult.prettyPrinted = NO;
            NSString *stored = result.mc_JSONString;
            [[theValue(stored.length) should] equal:@37122];
            WeiboResult.prettyPrinted = YES;
            stored = result.mc_JSONString;
            [[theValue(stored.length) should] equal:@51783];
            
        });
        
        it(@"to NSArray", ^{
            [[result.statuses.toDictionaryArray shouldNot] beNil];
        });
        
        afterAll(^{
            result = nil;
        });
    });
    
    context(@"transform NSData to Model", ^{
        __block WeiboResult1 *result;

        beforeAll(^{
            result = [WeiboResult1 jsonObjectFromData:JSONFileData(kFriendsTimelineFile1)];
        });
        
        it(@"not nil", ^{
            [[result shouldNot] beNil];
            [[theValue(result.since_id) should] equal:@0];
        });
        
        afterAll(^{
            result = nil;
        });
    });
    
    context(@"transform to ModelArray", ^{
        __block NSArray<StatuseModel *> *array;
        
        it(@"from NSData", ^{
            array = [StatuseModel arrayOfModelsFromKeyValues:JSONFileData(kFriendsTimelineFile2)];
            [[array shouldNot] beNil];
            [[theValue(array.count) should] equal:@20];
        });
        
        it(@"from NSString", ^{
            NSString *jsonStr = [[NSString alloc] initWithData:JSONFileData(kFriendsTimelineFile2) encoding:NSUTF8StringEncoding];
            array = [StatuseModel arrayOfModelsFromKeyValues:jsonStr];
            [[array shouldNot] beNil];
            [[theValue(array.count) should] equal:@20];
        });
        
        it(@"from nil", ^{
            array = [StatuseModel arrayOfModelsFromKeyValues:nil];
            [[array should] beNil];
        });
        
        it(@"from null", ^{
            array = [StatuseModel arrayOfModelsFromKeyValues:[NSNull null]];
            [[array should] beNil];
        });
        
        it(@"from error data", ^{
            array = [StatuseModel arrayOfModelsFromKeyValues:@"[,]"];
            [[array should] beNil];
        });
        
        it(@"transform NSDate", ^{
            NSString *jsonStr = [[NSString alloc] initWithData:JSONFileData(kJSONConfigFile) encoding:NSUTF8StringEncoding];
            WeiboResult1 *result = [WeiboResult1 jsonObjectFromData:jsonStr];
            [[result shouldNot] beNil];
            [[theValue(result.statuses.count) should] equal:@20];
            [[theValue(result.updateTime.timeIntervalSince1970) should] equal:@1526183950];
            [[theValue(result.timeStr.timeIntervalSince1970) should] equal:@1526183950];
            [[result.mc_JSONString should] containString:@"1526183950"];
        });
        
        it(@"error to jsonString", ^{
            
            NSNumber *number = @1526183950000;
            [[theValue(number.mc_JSONString) shouldNot] beNil];
        });
    });
});

SPEC_END
