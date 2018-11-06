//
//  CLNoteView.m
//  TestNote
//
//  Created by 陈林 on 2018/11/6.
//  Copyright © 2018年 陈林. All rights reserved.
//

#import "CLNoteView.h"

@interface CLNoteView ()

@property (nonatomic, strong)UIBezierPath *path;

@property (nonatomic, strong)UIImageView *singleNoteIV;
@property (nonatomic, strong)UIImageView *doubleNoteIV1;
@property (nonatomic, strong)UIImageView *doubleNoteIV2;

@property (nonatomic, strong)UIImageView *circleIV;

@property (nonatomic, assign)BOOL isAnimating;

@end

@implementation CLNoteView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.circleIV];
        
        [self addSubview:self.singleNoteIV];
        [self addSubview:self.doubleNoteIV1];
        [self addSubview:self.doubleNoteIV2];
        
        self.singleNoteIV.center = CGPointMake(self.frame.size.width, self.frame.size.height);
        self.doubleNoteIV1.center = CGPointMake(self.frame.size.width, self.frame.size.height);
        self.doubleNoteIV2.center = CGPointMake(self.frame.size.width, self.frame.size.height);
        
        [self addAnimation];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.isAnimating) {
        [self pauseAnimation];
    }else {
        [self resumeAnimation];
    }
}

- (void)resumeAnimation {
    self.isAnimating = YES;
    
    CFTimeInterval singleNoteIVPausedTime = [self.singleNoteIV.layer timeOffset];
    self.singleNoteIV.layer.speed = 1.0;
    self.singleNoteIV.layer.beginTime = 0.0;
    CFTimeInterval singleNoteIVTimeSincePause = [self.singleNoteIV.layer convertTime:CACurrentMediaTime() fromLayer:nil] - singleNoteIVPausedTime;
    self.singleNoteIV.layer.beginTime = singleNoteIVTimeSincePause;
    
    CFTimeInterval doubleNoteIV1PausedTime = [self.doubleNoteIV1.layer timeOffset];
    self.doubleNoteIV1.layer.speed = 1.0;
    self.doubleNoteIV1.layer.beginTime = 0.0;
    CFTimeInterval doubleNoteIV1TimeSincePause = [self.doubleNoteIV1.layer convertTime:CACurrentMediaTime() fromLayer:nil] - doubleNoteIV1PausedTime;
    self.doubleNoteIV1.layer.beginTime = doubleNoteIV1TimeSincePause;
    
    CFTimeInterval doubleNoteIV2PausedTime = [self.doubleNoteIV2.layer timeOffset];
    self.doubleNoteIV2.layer.speed = 1.0;
    self.doubleNoteIV2.layer.beginTime = 0.0;
    CFTimeInterval doubleNoteIV2TimeSincePause = [self.doubleNoteIV2.layer convertTime:CACurrentMediaTime() fromLayer:nil] - doubleNoteIV2PausedTime;
    self.doubleNoteIV2.layer.beginTime = doubleNoteIV2TimeSincePause;
    
    CFTimeInterval circleIVPausedTime = [self.circleIV.layer timeOffset];
    self.circleIV.layer.speed = 1.0;
    self.circleIV.layer.beginTime = 0.0;
    CFTimeInterval circleIVTimeSincePause = [self.circleIV.layer convertTime:CACurrentMediaTime() fromLayer:nil] - circleIVPausedTime;
    self.circleIV.layer.beginTime = circleIVTimeSincePause;
}

- (void)pauseAnimation {
    self.isAnimating = NO;
    
    CFTimeInterval singleNoteIVPausedTime = [self.singleNoteIV.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.singleNoteIV.layer.speed = 0.0;
    self.singleNoteIV.layer.timeOffset = singleNoteIVPausedTime;
    
    CFTimeInterval doubleNoteIV1PausedTime = [self.doubleNoteIV1.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.doubleNoteIV1.layer.speed = 0.0;
    self.doubleNoteIV1.layer.timeOffset = doubleNoteIV1PausedTime;
    
    CFTimeInterval doubleNoteIV2PausedTime = [self.doubleNoteIV2.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.doubleNoteIV2.layer.speed = 0.0;
    self.doubleNoteIV2.layer.timeOffset = doubleNoteIV2PausedTime;
    
    CFTimeInterval circleIVPausedTime = [self.circleIV.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.circleIV.layer.speed = 0.0;
    self.circleIV.layer.timeOffset = circleIVPausedTime;
}

- (void)addAnimation {
    self.isAnimating = YES;
    
    CGFloat kAnimationDuration = 3.0f;
    
    CABasicAnimation *scaleAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAni.fromValue = [NSNumber numberWithFloat:1.0f];
    scaleAni.toValue = [NSNumber numberWithFloat:2.0f];
    scaleAni.duration = kAnimationDuration;
    
    CABasicAnimation *rotationAni1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAni1.fromValue = [NSNumber numberWithFloat:0.0f];
    rotationAni1.toValue = [NSNumber numberWithFloat:M_PI * 0.25f];
    rotationAni1.duration = kAnimationDuration*1.2;
    rotationAni1.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *rotationAni2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAni2.fromValue = [NSNumber numberWithFloat:0.0f];
    rotationAni2.toValue = [NSNumber numberWithFloat:M_PI * -0.25f];
    rotationAni2.duration = kAnimationDuration*1.4;
    rotationAni2.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *opacityAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAni.fromValue = [NSNumber numberWithFloat:0.0];
    opacityAni.toValue = [NSNumber numberWithFloat:1.0];
    opacityAni.duration = kAnimationDuration*0.5;
    opacityAni.fillMode = kCAFillModeForwards;
    opacityAni.autoreverses = YES;
    opacityAni.repeatCount = FLT_MAX;
    opacityAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAKeyframeAnimation *positionAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAni.path = self.path.CGPath;
    positionAni.duration = kAnimationDuration;
    positionAni.repeatCount = FLT_MAX;
    positionAni.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *group1 = [CAAnimationGroup animation];
    group1.duration = kAnimationDuration;
    group1.removedOnCompletion = NO;
    group1.repeatCount = FLT_MAX;
    group1.fillMode = kCAFillModeForwards;
    [group1 setAnimations:@[scaleAni, rotationAni1, opacityAni, positionAni]];
    
    CAAnimationGroup *group2 = [CAAnimationGroup animation];
    group2.duration = kAnimationDuration;
    group2.removedOnCompletion = NO;
    group2.repeatCount = FLT_MAX;
    group2.fillMode = kCAFillModeForwards;
    [group2 setAnimations:@[scaleAni, rotationAni2, opacityAni, positionAni]];
    
    [self.singleNoteIV.layer addAnimation:group1 forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kAnimationDuration/3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.doubleNoteIV1.layer addAnimation:group1 forKey:nil];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kAnimationDuration/3.0*2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.doubleNoteIV2.layer addAnimation:group2 forKey:nil];

    });
    
    CABasicAnimation *rotationAni3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAni3.fromValue = [NSNumber numberWithFloat:0.0f];
    rotationAni3.toValue = [NSNumber numberWithFloat:M_PI * 2.0f];
    rotationAni3.duration = kAnimationDuration;
    rotationAni3.fillMode = kCAFillModeForwards;
    rotationAni3.repeatCount = FLT_MAX;
    rotationAni3.removedOnCompletion = NO;
    
    [self.circleIV.layer addAnimation:rotationAni3 forKey:nil];
}

- (UIImageView *)singleNoteIV {
    if (!_singleNoteIV) {
        _singleNoteIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _singleNoteIV.image = [UIImage imageNamed:@"single_note"];
        _singleNoteIV.alpha = 0;
    }
    return _singleNoteIV;
}

- (UIImageView *)doubleNoteIV1 {
    if (!_doubleNoteIV1) {
        _doubleNoteIV1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _doubleNoteIV1.image = [UIImage imageNamed:@"double_note"];
        _doubleNoteIV1.alpha = 0;
    }
    return _doubleNoteIV1;
}

- (UIImageView *)doubleNoteIV2 {
    if (!_doubleNoteIV2) {
        _doubleNoteIV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _doubleNoteIV2.image = [UIImage imageNamed:@"double_note"];
        _doubleNoteIV2.alpha = 0;
    }
    return _doubleNoteIV2;
}

- (UIBezierPath *)path {
    if (!_path) {
        _path = [UIBezierPath bezierPath];
        // 首先设置一个起始点
        CGPoint startPoint = CGPointMake(self.frame.size.width, self.frame.size.height);
        // 以起始点为路径的起点
        [_path moveToPoint:startPoint];
        // 设置一个终点
        CGPoint endPoint = CGPointMake(20, 0);
        // 设置第一个控制点
        CGPoint controlPoint1 = CGPointMake(0, self.frame.size.height);
        // 添加三次贝塞尔曲线
        [_path addQuadCurveToPoint:endPoint controlPoint:controlPoint1];
    }
    return _path;
}

- (UIImageView *)circleIV {
    if (!_circleIV) {
        _circleIV = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-40, self.frame.size.height-40-10, 40, 40)];
        _circleIV.layer.cornerRadius = 20;
        _circleIV.layer.masksToBounds = YES;
        _circleIV.image = [UIImage imageNamed:@"erduo"];
    }
    return _circleIV;
}

@end
