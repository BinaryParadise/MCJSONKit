//
//  WBUser.h
//  iOSExample
//
//  Created by bonana on 2017/3/17.
//  Copyright © 2017年 maintoco. All rights reserved.
//

#import "WeiboModel.h"

@interface WBUser : NSObject

/**
 用户UID
 */
@property (nonatomic, assign) long uid;

/**
 字符串型的用户UID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 用户昵称
 */
@property (nonatomic, copy) NSString *screen_name;
/**
 友好显示名称
 */
@property (nonatomic, copy) NSString *name;

/**
 用户头像地址（中图），50×50像素
 */
@property (nonatomic, copy) NSString *profile_image_url;
/**
 用户的微号
 */
@property (nonatomic, copy) NSString *weihao;

@end
