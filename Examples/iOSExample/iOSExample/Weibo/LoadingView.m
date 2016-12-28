//
//  LoadingView.m
//  iOSExample
//
//  Created by maintoco on 16/12/22.
//  Copyright © 2016年 maintoco. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView () <CAAnimationDelegate>

@property (nonatomic, retain) CAShapeLayer *shapeLayer;

@end

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {

    CircleLayer *shapeLayer = [CircleLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.start = 0;
    [self.layer addSublayer:shapeLayer];
    
    CABasicAnimation * ani = [CABasicAnimation animationWithKeyPath:@"start"];
    ani.duration = 1.5;
    ani.fromValue = @(0);
    ani.toValue = @(M_PI * 2);
    ani.removedOnCompletion = NO;
    ani.repeatCount = 100;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    ani.delegate = self;
    [shapeLayer addAnimation:ani forKey:@"progressAni"];
}

- (void)setHidden:(BOOL)hidden {
    if (hidden) {
        [_shapeLayer removeAllAnimations];
        [_shapeLayer removeFromSuperlayer];
    }
    [super setHidden:hidden];
}

@end

@interface CircleLayer ()


@end

@implementation CircleLayer

- (void)drawInContext:(CGContextRef)ctx {
    
    CGFloat radius = self.bounds.size.width/2;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(radius, radius) radius:radius-3 startAngle:self.start endAngle:self.start+M_PI *2 * 0.65 clockwise:YES];
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    path.lineWidth = 2.0;
    CGContextSetRGBStrokeColor(ctx, 0.6, 0.6, 0.6, 0.9);//笔颜色
    CGContextSetLineWidth(ctx, 2.0);//线条宽度
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"start"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

@end
