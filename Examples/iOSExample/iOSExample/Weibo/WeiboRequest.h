//
//  WeiboRequest.h
//  iOSExample
//
//  Created by maintoco on 16/12/20.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 微博API调用对象
 */
@interface WeiboRequest : NSObject

+ (void)startRequestWithURL:(NSString *)url completion:(void (^)(id obj))completion;

@end
