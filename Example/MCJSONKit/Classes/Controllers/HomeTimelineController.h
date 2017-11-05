//
//  HomeTimelineController.h
//  iOSExample
//
//  Created by vmpc on 16/12/20.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import <UIKit/UIKit.h>

#define weak(obj) __weak typeof(obj) ws = obj

typedef NS_ENUM(NSUInteger, FetchDataType) {
    FetchDataTypeFirst = 0,
    FetchDataTypePullDown = 1 << 1,
    FetchDataTypePullUp = 1 << 2,
};

/**
 主页控制器：登录用户以及所关注用户的最新微博
 */
@interface HomeTimelineController : UIViewController

@end
