//
//  WeiboContentCell.m
//  iOSExample
//
//  Created by maintoco on 16/12/21.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import "WeiboContentCell.h"

@interface WeiboContentCell ()

@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) UILabel *lblName;
@property (nonatomic, retain) UILabel *lblContent;
@property (nonatomic, retain) UILabel *lblReposts;
@property (nonatomic, retain) UILabel *lblComments;
@property (nonatomic, retain) UILabel *lblAttitudes;
@property (nonatomic, retain) UIView *separateView;

@end

@implementation WeiboContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (UIImageView *)headImageView {
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 16, 32, 32)];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headImageView;
}

- (UILabel *)lblName {
    if (_lblName == nil) {
        _lblName = [[UILabel alloc] initWithFrame:CGRectMake(_headImageView.right+8, 16, self.width-(_headImageView.right+8+16), 20)];
        _lblName.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:_lblName];
    }
    return _lblName;
}

- (UIView *)separateView {
    if (_separateView == nil) {
        _separateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 8)];
        _separateView.backgroundColor = [UIColor lightTextColor];
        [self.contentView addSubview:_separateView];
    }
    return _separateView;
}

- (void)initView {
    [self.contentView addSubview:self.headImageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.lblName.text = _statuse.user.screen_name;
    self.separateView.top = self.height-8;
    self.separateView.width = self.width;
}

@end
