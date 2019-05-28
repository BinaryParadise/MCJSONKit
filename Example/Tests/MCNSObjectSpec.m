//
//  MCNSObjectSpec.m
//  MCJSONKit_Tests
//
//  Created by Rake Yang on 2018/5/13.
//  Copyright © 2018年 BinaryParadise. All rights reserved.
//

#import "WeiboResult.h"

SpecBegin(MCNSObjectSpec)

describe(@"NSObject+MCJSONKit", ^{
    context(@"transform NSDictionary to Model", ^{
        MCLogDebug(@"%@",[NSBundle bundleForClass:self.class].bundlePath);
        __block WeiboResult *result;
        beforeAll(^{
            NSDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:JSONFileData(kFriendsTimelineFile1) options:NSJSONReadingMutableContainers error:nil];
            result = [WeiboResult jsonObjectFromData:jsonObj];
        });
        
        it(@"nil", ^{
            expect([WeiboResult jsonObjectFromData:nil]).will.beNil();
        });
        
        it(@"NSString", ^{
            expect([WeiboResult jsonObjectFromData:@"{}"]).willNot.beNil();
        });
        
        it(@"error NSString", ^{
            expect([WeiboResult jsonObjectFromData:[@"{x}" dataUsingEncoding:NSUTF8StringEncoding]]).will.beNil();
        });
        
        it(@"data type assert", ^{
            expect(result).willNot.beNil();
            expect(result.next_cursor).equal(0);
            expect(result.statuses.count).willNot.equal(0);
            expect(result.since_id).equal(4238558845532583);
        });
        
        it(@"prettyPrinted", ^{
            WeiboResult.prettyPrinted = NO;
            NSString *stored = result.mc_JSONString;
            expect(stored).willNot.contain(@"\n");
            WeiboResult.prettyPrinted = YES;
            stored = result.mc_JSONString;
            expect(stored).contain(@"\n");
            
        });
        
        it(@"NSArray", ^{
            expect([result.statuses toDictionaryArray]).willNot.beNil();
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
            expect(result).willNot.beNil();
            expect(result.since_id).equal(0);
        });
        
        afterAll(^{
            result = nil;
        });
    });
    
    context(@"transform to ModelArray", ^{
        __block NSArray<StatuseModel *> *array;
        
        it(@"from NSData", ^{
            array = [StatuseModel arrayOfModelsFromKeyValues:JSONFileData(kFriendsTimelineFile2)];
            expect(array).willNot.beNil();
            expect(array.count).equal(20);
        });
        
        it(@"from NSString", ^{
            NSString *jsonStr = [[NSString alloc] initWithData:JSONFileData(kFriendsTimelineFile2) encoding:NSUTF8StringEncoding];
            array = [StatuseModel arrayOfModelsFromKeyValues:jsonStr];
            expect(array.firstObject.wid).willNot.equal(0);
            expect(array.firstObject.user.verified_type).equal(0);
            expect(array).willNot.beNil();
            expect(array.count).equal(20);
        });
        
        it(@"from nil", ^{
            array = [StatuseModel arrayOfModelsFromKeyValues:nil];
            expect(array).will.beNil();
        });
        
        it(@"from null", ^{
            array = [StatuseModel arrayOfModelsFromKeyValues:[NSNull null]];
            expect(array).will.beNil();
        });
        
        it(@"from error data", ^{
            array = [StatuseModel arrayOfModelsFromKeyValues:@"[,]"];
            expect(array).will.beNil();
        });
        
        it(@"transform NSDate", ^{
            NSString *jsonStr = [[NSString alloc] initWithData:JSONFileData(kJSONConfigFile) encoding:NSUTF8StringEncoding];
            WeiboResult1 *result = [WeiboResult1 jsonObjectFromData:jsonStr];
            expect(result).willNot.beNil();
            expect(result.since_id).equal(0);
            expect(result.statuses.count).equal(20);
            expect(result.updateTime.timeIntervalSince1970).equal(1526183950);
            expect(result.timeStr.timeIntervalSince1970).equal(1526183950);
            expect(result.mc_JSONString).contain(@"1526183950");
        });
        
        it(@"error to jsonString", ^{
            
            NSString *number = @"1526183950000";
            expect(number.mc_JSONString).will.beNil();
        });
    });
});

SpecEnd
