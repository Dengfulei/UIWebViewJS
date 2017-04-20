//
//  DFLProgressLayer.h
//  UIWebViewJS
//
//  Created by 杭州移领 on 2017/4/20.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface DFLProgressLayer : CAShapeLayer

@property (nonatomic, strong) UIColor *progressColor;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)startLoadProgressLayer;

- (void)finishedLoadProgressLayer;

@end
