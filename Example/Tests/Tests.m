//
//  MCJSONKitTests.m
//  MCJSONKitTests
//
//  Created by mylcode on 11/04/2017.
//  Copyright (c) 2017 mylcode. All rights reserved.
//

@import XCTest;
@import MCJSONKit;

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testString
{
    NSDictionary *dict = [@"{\"name\":\"iPhone\"}" mc_toDictionary];
    XCTAssertNotNil(dict, @"NSString to dictionary faield.");
}

- (void)testData {
    NSDictionary *dict = [[@"{\"name\":\"iPhone\"}" dataUsingEncoding:NSUTF8StringEncoding] mc_toDictionary];
    XCTAssertNotNil(dict, @"NSString to dictionary faield.");
}

- (void)testDictionary {
    NSDictionary *dict = [@"{\"name\":\"iPhone\"}" mc_toDictionary];
    XCTAssertNotNil(dict, @"NSString to dictionary faield.");
}

@end

