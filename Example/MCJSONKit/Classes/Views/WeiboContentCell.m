//
//  WeiboContentCell.m
//  iOSExample
//
//  Created by maintoco on 16/12/21.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import "WeiboContentCell.h"

#define BNColorSeparate HEXCOLOR(0xeaeaea)

@interface WeiboContentCell ()

@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) UILabel *lblName;
@property (nonatomic, strong) UILabel *lblTime;
@property (nonatomic, strong) UILabel *lblSource;
@property (nonatomic, retain) UILabel *lblContent;

/**
 转发
 */
@property (nonatomic, retain) UILabel *lblReposts;

/**
 评论
 */
@property (nonatomic, retain) UILabel *lblComments;

/**
 点赞
 */
@property (nonatomic, retain) UILabel *lblAttitudes;
@property (nonatomic, retain) UIView *separateView;
@property (nonatomic, strong) UIView *separateLineBottom;

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
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kInsets, kInsets, 40, 40)];
        //_headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.clipsToBounds = YES;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = _headImageView.height/2;
        [self.contentView addSubview:_headImageView];
    }
    return _headImageView;
}

- (UILabel *)lblName {
    if (!_lblName) {
        _lblName = [[UILabel alloc] initWithFrame:CGRectMake(_headImageView.right+8, kInsets, self.width-(_headImageView.right+8+kInsets), 20)];
        _lblName.font = [UIFont systemFontOfSize:15.0];
        _lblName.textColor = HEXCOLOR(0xeb7350);
        [self.contentView addSubview:_lblName];
    }
    return _lblName;
}

- (UILabel *)lblTime {
    if (!_lblTime) {
        _lblTime = [[UILabel alloc] initWithFrame:CGRectMake(_lblName.left, _lblName.bottom+4, 0, 20)];
        _lblTime.textColor = [UIColor lightGrayColor];
        _lblTime.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_lblTime];
    }
    return _lblTime;
}

- (UILabel *)lblSource {
    if (!_lblSource) {
        _lblSource = [[UILabel alloc] initWithFrame:self.lblTime.frame];
        _lblSource.textColor = _lblTime.textColor;
        _lblSource.font = _lblTime.font;
        [self.contentView addSubview:_lblSource];
    }
    return _lblSource;
}

- (UIView *)separateView {
    if (_separateView == nil) {
        _separateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
        _separateView.backgroundColor = BNColorSeparate;
        [self.contentView addSubview:_separateView];
    }
    return _separateView;
}

- (void)initView {
    self.headImageView.hidden = NO;
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *separateLineTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    separateLineTop.backgroundColor = BNColorSeparate;
    [self.contentView addSubview:separateLineTop];
    
    _lblContent = [[UILabel alloc] initWithFrame:CGRectMake(kInsets, _headImageView.bottom+kInsets, ScreenWidth-kInsets*2, 0)];
    _lblContent.font = [UIFont systemFontOfSize:16];
    _lblContent.numberOfLines = 5;
    _lblContent.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:_lblContent];
    
    _lblReposts = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth/3, 30)];
    _lblReposts.textColor = [UIColor lightGrayColor];
    _lblReposts.textAlignment = NSTextAlignmentCenter;
    _lblReposts.font = [UIFont systemFontOfSize:13];
    UIView *separateLine0 = [[UIView alloc] initWithFrame:CGRectMake(_lblReposts.width-0.5, 7, 0.5, 16)];
    separateLine0.backgroundColor = BNColorSeparate;
    [_lblReposts addSubview:separateLine0];
    [self.contentView addSubview:_lblReposts];
    
    _lblComments = [[UILabel alloc] initWithFrame:CGRectMake(_lblReposts.right, 0, ScreenWidth/3, 30)];
    _lblComments.textColor = [UIColor lightGrayColor];
    _lblComments.textAlignment = NSTextAlignmentCenter;
    _lblComments.font = [UIFont systemFontOfSize:13];
    UIView *separateLine1 = [[UIView alloc] initWithFrame:separateLine0.frame];
    separateLine1.backgroundColor = BNColorSeparate;
    [_lblComments addSubview:separateLine1];
    [self.contentView addSubview:_lblComments];
    
    _lblAttitudes = [[UILabel alloc] initWithFrame:CGRectMake(_lblComments.right, 0, ScreenWidth/3, 30)];
    _lblAttitudes.textColor = [UIColor lightGrayColor];
    _lblAttitudes.textAlignment = NSTextAlignmentCenter;
    _lblAttitudes.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_lblAttitudes];
    
    _separateLineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    _separateLineBottom.backgroundColor = BNColorSeparate;
    [self.contentView addSubview:_separateLineBottom];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_statuse.user.avatar_hd] placeholderImage:nil options:SDWebImageRetryFailed];
    self.lblName.text = _statuse.user.screen_name;
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:_statuse.created_at.doubleValue];
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    dateFmt.dateFormat = @"M-d HH:mm";
    self.lblTime.text = [dateFmt stringFromDate:createDate];
    [self.lblTime sizeToFit];
    
    NSString *source = [_statuse.source stringByReplacingOccurrencesOfString:@"<a href=(.*?)>" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, _statuse.source.length)];
    source = [source stringByReplacingOccurrencesOfString:@"</a>" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0,source.length)];
    self.lblSource.text = [@"来自" stringByAppendingString:source];
    [self.lblSource sizeToFit];
    self.lblSource.left = _lblTime.right+4;
    
    self.lblContent.text = _statuse.text;
    self.lblContent.height = [_lblContent sizeThatFits:CGSizeMake(_lblContent.width, MAXFLOAT)].height;
    
    self.separateView.top = self.lblContent.bottom+kInsets;
    
    _lblReposts.top = _separateView.bottom;
    _lblComments.top = _separateView.bottom;
    _lblAttitudes.top = _separateView.bottom;
    
    _lblReposts.text = [NSString stringWithFormat:@"%d",_statuse.reposts_count];
    _lblComments.text = [NSString stringWithFormat:@"%d",_statuse.comments_count];
    _lblAttitudes.text = [NSString stringWithFormat:@"%d",_statuse.attitudes_count];
    
    _separateLineBottom.top = self.height-0.5;
}

+ (CGFloat)getCellHeithWithObject:(StatuseModel *)statuse {
    CGFloat cellHeight = kInsets+40+kInsets+kInsets+0.5+30+0.5;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    CGFloat contentHeight = [statuse.text boundingRectWithSize:CGSizeMake(ScreenWidth-kInsets, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSParagraphStyleAttributeName:paragraphStyle} context:nil].size.height;
    return cellHeight+contentHeight;
}

@end
