//
//  MCTypeTransformTest.m
//  MCJSONKitTests
//
//  Created by Rake Yang on 11/04/2017.
//  Copyright (c) 2017 mylcode. All rights reserved.
//

//json和对象互相转换

SpecBegin(Tests)

    describe(@"json <> object", ^{
        
        context(@"json <> NSString <> NSDictionary", ^{
            NSString *jsonStr = @"{\"name\":\"iPhone\"}";
            it(@"NSString to NSDictionary", ^{
                expect(jsonStr.mc_toDictionary).willNot.beNil();
                expect(jsonStr.mc_toDictionary).will.beKindOf(NSDictionary.class);
            });
            
            it(@"NSData to NSDictionary", ^{
                NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                expect(data.mc_toDictionary).willNot.beNil();
                expect(data.mc_toDictionary).will.beKindOf(NSDictionary.class);
            });
            
            it(@"NSDictionary to NSString", ^{
                NSDictionary *dict = @{@"name": @"iPhone", @"extend":[NSNull null]};
                NSString *jsonStr = dict.mc_JSONString;
                expect(jsonStr).willNot.beNil();
                expect(jsonStr).will.beKindOf(NSString.class);
                expect(jsonStr).contain(@"null");
            });
            
            it(@"NSDictionary Fetcher", ^{
                NSDictionary *dict = @{@"bool": @"1", @"str": @"hello world", @"num": @(55689), @"arr": @[@"1", @"2"],@"obj": [NSObject new], @"null": [NSNull null], @"double": @(0.569), @"flt": @"0.569", @"dict": @{@"k":@"v"}};
                expect([dict mc_stringForKey:[NSNull null]]).will.beNil();
                expect([dict mc_stringForKey:@""]).will.beNil();
                expect([dict mc_stringForKey:nil]).will.beNil();
                expect([dict mc_stringForKey:@"str"]).equal(@"hello world");
                expect([dict mc_stringForKey:@"null"]).will.beNil();
                expect([dict mc_stringForKey:@"dict"]).will.beNil();
                expect([dict mc_stringForKey:@"arr"]).will.beNil();
                expect([dict mc_stringForKey:@"num"]).equal(@"55689");

                expect([dict mc_boolForKey:@"bool"]).equal(YES);
                expect([dict mc_boolForKey:@"num"]).equal(YES);

                expect([dict mc_numberForKey:@"num"]).equal(@55689);
                expect([dict mc_numberForKey:@"str"]).equal(@0);
                
                expect([dict mc_intForKey:@"num"]).equal(55689);
                expect([dict mc_intForKey:@"bool"]).equal(1);            
                
                expect([dict mc_longForKey:@"num"]).equal(55689);
                expect([dict mc_longForKey:@"str"]).equal(0);
                
                expect([dict mc_longlongForKey:@"num"]).equal(55689);
                expect([dict mc_longlongForKey:@"str"]).equal(0);

                expect([dict mc_floatForKey:@"double"]).equal(0.569);
                expect([dict mc_floatForKey:@"flt"]).equal(0.569);

                expect([dict mc_doubleForKey:@"double"]).equal(0.569);
                expect([dict mc_doubleForKey:@"flt"]).equal(0.569);

                expect([dict mc_arrayForKey:@"arr"]).equal(@[@"1", @"2"]);
                expect([dict mc_dictionaryForKey:@"dict"]).equal(@{@"k":@"v"});
                expect([dict mc_objectForKey:@"null"]).will.beNil();
                expect([dict mc_objectForKey:@"num"]).willNot.beNil();
                expect([dict mc_objectForKey:@"str"]).willNot.beNil();
                expect([dict mc_objectForKey:@"dict"]).willNot.beNil();
                expect([dict mc_objectForKey:@"arr"]).willNot.beNil();
                expect([dict mc_objectForKey:@"obj"]).willNot.beNil();
            });
        });
    });

SpecEnd
