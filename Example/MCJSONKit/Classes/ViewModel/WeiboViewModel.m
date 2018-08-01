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
    MCLogDebug(@"初始化微博SDK-559386746");
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:@"559386746"];
}

- (BOOL)ssoAuthorizeRequest {
    if ([[NSUserDefaults standardUserDefaults] dictionaryForKey:@"WeiboSSOUserInfo"]) {
        return YES;
    }
    MCLogInfo(@"转到授权页");
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = @"https://api.weibo.com/oauth2/default.html";
    request.userInfo = @{@"SSO_From":@"HomeTimelineController"};
    [WeiboSDK sendRequest:request];
    return NO;
}

- (void)requestFriendsTimeline:(void (^)(void))completion {
    [WeiboRequest startRequestWithURL:@"https://api.weibo.com/2/statuses/friends_timeline.json" completion:^(id obj) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingMutableContainers  error:nil];
        self.statuses = [StatuseModel arrayOfModelsFromKeyValues:dict[@"statuses"]];
        MCLogWarn(@"请求完成，成功解析JSON数据%zd", self.statuses.count);
        MCLogInfo(@"JSON数据：\n%@",self.statuses.firstObject.toJSONString);
        if (completion) {
            completion();
        }
    }];
}

@end
