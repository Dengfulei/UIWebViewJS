//
//  DFLProgressLayer.m
//  UIWebViewJS
//
//  Created by 杭州移领 on 2017/4/20.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import "DFLProgressLayer.h"
@interface DFLProgressLayer ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) CGFloat stepWidth;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;


@end
const static NSTimeInterval progressInterVal = 0.01;
@implementation DFLProgressLayer

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super init];
    if (self) {
        self.frame = frame;
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.stepWidth = 0.0001;
    self.lineWidth = 2;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, self.frame.size.height)];
    [bezierPath addLineToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width, self.frame.size.height)];
    self.path = bezierPath.CGPath;
    _progressColor = [UIColor whiteColor];
    self.strokeColor = [UIColor greenColor].CGColor;
    self.strokeEnd = 0;
    

}

- (void)initTimer {
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:progressInterVal target:self selector:@selector(changeProgress:) userInfo:nil repeats:YES];
        [self.timer fire];
    }
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)closeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)changeProgress:(NSTimer *)timer {
    self.strokeEnd += self.stepWidth;;
    NSLog(@"%f",self.strokeEnd);
    if (self.strokeEnd > 0.8) {
        self.stepWidth = 0.0002;
    }
}

- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    self.strokeColor = progressColor.CGColor;
}



- (void)startLoadProgressLayer {
    [self initTimer];
}

- (void)finishedLoadProgressLayer {
    self.strokeEnd = 1.0;
    [self closeTimer];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.strokeEnd = 0;
        self.stepWidth = 0.0001;
        [self removeFromSuperlayer];
    });
}

@end
