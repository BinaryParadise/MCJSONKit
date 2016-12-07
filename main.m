//
//  main.m
//  COJSONCore
//
//  Created by odyang on 16/12/6.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "COTestModel.h"

#define QUOTE(...) #__VA_ARGS__
const char *jsonStrTest = QUOTE(
{
    "p_char": 60,
    "pbyte": 95,
    "pbool": 0,
    "pshort": 255,
    "p_int": 268,
    "p_long": 889868,
    "p_longlong": 846843,
    "p_ulong": 1686565,
    "p_ulonglong": 687686,
    "p_float": 20.3,
    "p_double": 20.3,
    "longdabou": 20.3,
    "p_integer": -268,
    "p_uinteger": 968,
    "p_cbool": 1,
    "info": {
        "str": "string",
        "mstr": "this is mutablestring",
        "number": 10,
        "arr": [20.3],
        "marr": [],
        "dict": {"key":"value"},
        "mdict": {},
        "set":[],
        "mset":[]
    },
    "list":
    [
         {
             "str": "string",
             "mstr": "this is 3",
             "number": 10,
             "arr": [20.3],
             "marr": [],
             "dict": {"key":"value"},
             "mdict": {}
         },
         {
             "str": "string",
             "mstr": "this is 23",
             "number": 10,
             "arr": [30.3],
             "marr": [],
             "dict": {"key":"value"},
             "mdict": {}
         }
    ]
}
                                );
#undef QUOTE

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *json = [NSString stringWithUTF8String:jsonStrTest];
        COTestModel *testModel = [COTestModel objectFromJSONString:json];
        [testModel.model.mstr appendString:@"this is append string"];
        NSString *jsonStr = testModel.toJSONString;
        NSLog(@"%@",jsonStr);
    }
    return 0;
}
