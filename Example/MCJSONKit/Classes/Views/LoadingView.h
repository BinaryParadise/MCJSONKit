//
//  LoadingView.h
//  iOSExample
//
//  Created by maintoco on 16/12/22.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCView.h"

/**
 加载试图
 */
@interface LoadingView : MCView

/**
 当前进度
 */
@property (nonatomic,assign) CGFloat progress;

@end
