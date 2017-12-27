//
//  WeiboContentCell.h
//  iOSExample
//
//  Created by mylcode on 16/12/21.
//  Copyright © 2016年 MC-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MCUIKit/MCView.h>
#import "StatuseModel.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"

#define kInsets 12.0    //距离屏幕间距

@interface WeiboContentCell : UITableViewCell

@property (nonatomic, retain) StatuseModel *statuse;

+ (CGFloat)getCellHeithWithObject:(StatuseModel *)statuse;

@end
