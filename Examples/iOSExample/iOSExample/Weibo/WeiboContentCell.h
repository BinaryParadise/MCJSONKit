//
//  WeiboContentCell.h
//  iOSExample
//
//  Created by maintoco on 16/12/21.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewExt.h"
#import "StatuseModel.h"

#define kInsets 12.0    //距离屏幕间距

@interface WeiboContentCell : UITableViewCell

@property (nonatomic, retain) StatuseModel *statuse;

+ (CGFloat)getCellHeithWithObject:(StatuseModel *)statuse;

@end
