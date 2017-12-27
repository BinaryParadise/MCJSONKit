//
//  WeiboRequest.m
//  iOSExample
//
//  Created by maintoco on 16/12/20.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import "WeiboRequest.h"

@implementation WeiboRequest

+ (void)startRequestWithURL:(NSString *)url completion:(void (^)(id))completion {
    NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"WeiboSSOUserInfo"];
    NSString *newURL = [url stringByAppendingFormat:@"?access_token=%@",userInfo[@"access_token"]];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:newURL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil && completion) {
            completion(data);
        }
    }];
    MCLogInfo(@"开始请求微博数据");
    [dataTask resume];
}

@end
