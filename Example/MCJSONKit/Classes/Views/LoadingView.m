//
//  LoadingView.m
//  iOSExample
//
//  Created by maintoco on 16/12/22.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import "LoadingView.h"

@interface CircleLayer : CALayer

/**
 进度
 */
@property (nonatomic, assign) CGFloat progress;
/**
 内容颜色,默认为#FFFFFF,90%
 */
@property (nullable) CGColorRef contentColor;

@end

@implementation CircleLayer

- (void)drawInContext:(CGContextRef)ctx {
    //半径
    CGFloat radius = self.bounds.size.width/2;
    CGFloat lineWith = 1.0;//线宽
    CGContextSetLineWidth(ctx, lineWith);
    CGContextMoveToPoint(ctx, radius, 0);
    
    //底层遮罩
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius startAngle:-M_PI_2 endAngle:M_PI * 1.5 clockwise:YES];
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 0.2);
    CGContextAddPath(ctx, shadowPath.CGPath);
    CGContextFillPath(ctx);
    
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 0.9);
    CGContextSetRGBFillColor(ctx, 1, 1, 1, 0.9);
    
    //外圈
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius-lineWith/2 startAngle:-M_PI_2 endAngle:M_PI * 1.5 clockwise:YES];
    CGContextAddPath(ctx, bezierPath.CGPath);
    CGContextStrokePath(ctx);
    //内圆
    UIBezierPath *bezierPathIn = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius-(lineWith/2+2.75) startAngle:-M_PI_2 endAngle:M_PI * 1.5 * self.progress clockwise:YES];
    [bezierPathIn addLineToPoint:CGPointMake(radius, radius)];
    CGContextAddPath(ctx, bezierPathIn.CGPath);
    CGContextFillPath(ctx);
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"progress"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

@end

@interface LoadingView () <CAAnimationDelegate>

@property (nonatomic, retain) CircleLayer *circleLayer;

@end

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (CGSizeEqualToSize(frame.size, CGSizeZero)) {
        frame.size = CGSizeMake(48, 48);
    }
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)setProgress:(CGFloat)progress {
    progress = MIN(progress, 1);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progress"];
    animation.duration = 5.0 * fabs(progress-_progress);
    animation.fromValue = @(_progress);
    animation.toValue = @(progress);
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    [self.circleLayer addAnimation:animation forKey:@"progressAni"];
    
    _progress = progress;
}

- (CircleLayer *)circleLayer {
    if (_circleLayer == nil) {
        _circleLayer = [CircleLayer layer];
        _circleLayer.frame = self.bounds;
        _circleLayer.contentsScale = [UIScreen mainScreen].scale;
        [self.layer addSublayer:_circleLayer];
    }
    return _circleLayer;
}

- (void)initView {
    self.progress = 0;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.circleLayer.progress = self.progress;
}

- (void)setHidden:(BOOL)hidden {
    if (hidden) {
        [self.circleLayer removeAllAnimations];
    }
    [super setHidden:hidden];
}

@end
