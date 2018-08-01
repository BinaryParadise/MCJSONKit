//
//  MCJSONKitDefine.h
//  MCJSONKit
//
//  Created by lingjing on 2018/6/4.
//  Copyright © 2018年 MC-Stuido. All rights reserved.
//

#import <MCFoundation/MCFoundation.h>

/*
 属性映射，正确校验 MCProperty(name) 展开后等同于 = @"name"
*/

/**
 属性映射，正确性校验
 用法：MCProperty()

 @param name 属性名称
 @return 返回OC字符串@"name"
 */
#define MCProperty(name) @keypath(self, name)
