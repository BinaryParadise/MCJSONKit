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
        });
    });

SpecEnd
