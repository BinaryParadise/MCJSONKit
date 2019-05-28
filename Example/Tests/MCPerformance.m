//
//  MCPerformance.m
//  MCJSONKit_Tests
//
//  Created by Rake Yang on 2018/5/13.
//  Copyright © 2018年 MC-Studio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WeiboResult.h"

@interface MCPerformance : XCTestCase

@end

@implementation MCPerformance

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    NSData *jsonData = JSONFileData(kFriendsTimelineFile1);
    [self measureBlock:^{
        for (int i=0; i<100; i++) {
            [WeiboResult jsonObjectFromData:jsonData];
        }
    }];
}

- (void)testPerformanceMJExtension {
    // This is an example of a performance test case.
    NSData *jsonData = JSONFileData(kFriendsTimelineFile1);
    [self measureBlock:^{
        for (int i=0; i<100; i++) {
            [WeiboResult jsonObjectFromData:jsonData];
        }
    }];
}

@end
