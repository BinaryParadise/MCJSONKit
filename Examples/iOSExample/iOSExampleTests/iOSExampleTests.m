//
//  iOSExampleTests.m
//  iOSExampleTests
//
//  Created by vmpc on 16/12/20.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "StatuseModel.h"
#import "SimpleModel.h"
#import "NSObject+MJKeyValue.h"

@interface iOSExampleTests : XCTestCase

@end

@implementation iOSExampleTests

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
    
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"simple.json" ofType:nil]];
    NSArray *arr = [SimpleModel arrayOfModelsFromKeyValues:jsonData];
    NSLog(@"%@",arr);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"public_timeline.json" ofType:nil]];
    [self measureBlock:^{
        for (int i=0; i<100; i++) {
            NSArray *result = [StatuseModel arrayOfModelsFromKeyValues:jsonData];
            //NSArray *result = [StatuseModel mj_objectArrayWithKeyValuesArray:jsonData];
        }
    }];
}

- (void)testHexColor {
}

@end
