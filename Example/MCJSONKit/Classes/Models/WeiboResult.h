//
//  WeiboResult.h
//  MCJSONKit_Example
//
//  Created by mylcode on 2018/5/12.
//  Copyright © 2018年 MC-Studio. All rights reserved.
//

#import "WeiboModel.h"
#import "StatuseModel.h"

@interface WeiboResult : WeiboModel

/**
 最新状态
 */
@property (nonatomic, copy) NSArray<StatuseModel *> *statuses;

/**
 广告列表
 */
@property (nonatomic, copy) NSArray *advertises;

/**
 since_id
 */
@property (nonatomic, assign) long since_id;

@property (nonatomic, assign) NSInteger uve_blank;

@end
