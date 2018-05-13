//
//  MCTypeTransformTest.m
//  MCJSONKitTests
//
//  Created by mylcode on 11/04/2017.
//  Copyright (c) 2017 mylcode. All rights reserved.
//

//json和对象互相转换

SPEC_BEGIN(Tests)

    describe(@"json <> object", ^{
        
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
