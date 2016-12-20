//
//  WeiboViewModel.h
//  iOSExample
//
//  Created by maintoco on 16/12/20.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatuseModel.h"

/**
 微博模型视图
 */
@interface WeiboViewModel : NSObject

@property (nonatomic, retain) NSArray<StatuseModel *> *statuses;

- (BOOL)ssoAuthorizeRequest;

/**
 获取当前登录用户及其所关注（授权）用户的最新微博
 */
- (void)requestHomeTimeline:(void (^)())completion;

@end
