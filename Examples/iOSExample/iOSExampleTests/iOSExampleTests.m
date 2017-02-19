//
//  iOSExampleTests.m
//  iOSExampleTests
//
//  Created by vmpc on 16/12/20.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "StatuseModel.h"

@interface PodModel : NSObject
@property (nonatomic, assign) int tag;
@property (nonatomic, retain) NSMutableArray *phoneNums;

@end

@implementation PodModel

@end

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
    
    NSMutableArray *rarr = [@[@"01",@"02",@"03",@"04",@"05",@"06"] mutableCopy];
    NSMutableArray *podArr = [NSMutableArray array];
    for (int i=0; i<10; i++) {
        PodModel *model = [PodModel new];
        model.tag = i;
        model.phoneNums = [NSMutableArray array];
        for (int j=0; j<i; j++) {
            [model.phoneNums addObject:[NSString stringWithFormat:@"%02d",j]];
        }
        [podArr addObject:model];
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K in %@",@"phoneNums",rarr];
    NSExpression *left = [NSExpression expressionForKeyPath:@"phoneNums"];
    NSExpression *right = [NSExpression expressionForConstantValue:rarr];
    
    NSComparisonPredicate *compPredicate = [NSComparisonPredicate predicateWithLeftExpression:left rightExpression:right modifier:NSDirectPredicateModifier type:NSInPredicateOperatorType options:0];
    
    NSArray *filteredArr = [podArr filteredArrayUsingPredicate:compPredicate];
        if (filteredArr.count > 0) {
            NSLog(@"%d",0);
        }
    
//    for (PodModel *obj in podArr) {
//        NSArray *filteredArr = [obj.phoneNums filteredArrayUsingPredicate:predicate];
//        if (filteredArr.count > 0) {
//            NSLog(@"%d",obj.tag);
//        }
//    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"public_timeline.json" ofType:nil]];
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    __block int count;
    [self measureBlock:^{
        for (int i=0; i<100; i++) {
            NSArray *result = [StatuseModel arrayOfModelsFromDictionaries:arr];
            count++;
        }
        if (count == 1000) {
            NSLog(@"%d",count);
        }
    }];
}

- (void)testHexColor {
    NSLog(@"%d",0xD5);
}

@end
