//
//  WeiboViewModel.m
//  iOSExample
//
//  Created by maintoco on 16/12/20.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import "WeiboViewModel.h"
#import "WeiboSDK.h"
#import "WeiboRequest.h"

@implementation WeiboViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initViewModel];
    }
    return self;
}

/**
 初始化
 */
- (void)initViewModel {
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:@"559386746"];
}

- (BOOL)ssoAuthorizeRequest {
    if ([[NSUserDefaults standardUserDefaults] dictionaryForKey:@"WeiboSSOUserInfo"]) {
        return YES;
    }
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = @"https://api.weibo.com/oauth2/default.html";
    request.userInfo = @{@"SSO_From":@"HomeTimelineController"};
    [WeiboSDK sendRequest:request];
    return NO;
}

- (void)requestFriendsTimeline:(void (^)())completion {
    [WeiboRequest startRequestWithURL:@"https://api.weibo.com/2/statuses/friends_timeline.json" completion:^(id obj) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingMutableContainers  error:nil];
       self.statuses = [StatuseModel arrayOfModelsFromDictionaries:dict[@"statuses"]];
        NSLog(@"%@",self.statuses.firstObject.toJSONString);
        if (completion) {
            completion();
        }
    }];
}

@end
