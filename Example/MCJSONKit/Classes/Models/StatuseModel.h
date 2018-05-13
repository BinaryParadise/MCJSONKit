//
//  StatuseModel.h
//  iOSExample
//
//  Created by maintoco on 16/12/20.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import "WeiboModel.h"
#import "UserModel.h"

@interface StatuseModel : WeiboModel

@property (nonatomic, assign) long wid;
@property (nonatomic, assign) long mid;
@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *source;
@property (nonatomic, assign) BOOL favorited;
@property (nonatomic, assign) BOOL truncated;
@property (nonatomic, copy) NSString *thumbnail_pic;
@property (nonatomic, copy) NSString *bmiddle_pic;
@property (nonatomic, copy) NSString *original_pic;
@property (nonatomic, retain) NSDictionary *geo;
@property (nonatomic, retain) UserModel *user;
@property (nonatomic, retain) StatuseModel *retweeted_status;
/**
 转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 表态数
 */
@property (nonatomic, assign) int attitudes_count;
/**
 暂未支持
 */
@property (nonatomic, assign) int mlevel;

/**
 微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
 */
@property (nonatomic, copy) NSDictionary *visible;
@property (nonatomic, copy) NSString *listid;

@end
