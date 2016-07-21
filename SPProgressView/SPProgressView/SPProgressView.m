//
//  SPProgressView.m
//  SPProgressView
//
//  Created by 康世朋 on 16/6/7.
//  Copyright © 2016年 SP. All rights reserved.
//

#import "SPProgressView.h"

#define S_WIDTH self.frame.size.width

@interface SPProgressView ()
{
    CAShapeLayer *_trackLayer;
    UIBezierPath *_trackPath;
    CAShapeLayer *_progressLayer;
    UIBezierPath *_progressPath;
    
    UIColor *ktrackColor;
    UIColor *kprogressColor;
    float kprogressHeight;
    
    double angle;
    NSTimer *timer;
}
@end

@implementation SPProgressView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        angle = 0.0;

        _trackLayer = [CAShapeLayer new];
        [self.layer addSublayer:_trackLayer];
        _trackLayer.fillColor = nil;
        _trackLayer.frame = self.bounds;
        
        _progressLayer = [CAShapeLayer new];
        [self.layer addSublayer:_progressLayer];
        _progressLayer.fillColor = nil;
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.frame = self.bounds;
        _progressLayer.strokeColor = [UIColor greenColor].CGColor;
        
        _progressStyle = SPProgressStyleCenter;
        self.progressHeight = frame.size.height;
        if (_progressStyle == SPProgressStyleCircle) {
            self.progressHeight = 5;
        }
        kprogressHeight = self.progressHeight;
    }
    return self;
}  

- (void)setTrack {
    switch (_progressStyle) {
        case SPProgressStyleDefault:
            
        case SPProgressStyleLeft:
            
        case SPProgressStyleCenter:
            _trackPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, S_WIDTH, _progressHeight) cornerRadius:0];
            
            break;
        case SPProgressStyleCircle:
            _trackPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:(S_WIDTH - _progressHeight)/ 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];;
            break;
        default:
            break;
    }
    _trackLayer.path = _trackPath.CGPath;
}

- (void)setProgress {
    
    switch (_progressStyle) {
        case SPProgressStyleDefault:
            _progressPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, _progress, _progressHeight) cornerRadius:0];
            break;
        case SPProgressStyleLeft:
            _progressPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(S_WIDTH - _progress, 0, _progress, _progressHeight) cornerRadius:0];
            break;
        case SPProgressStyleCenter:
            _progressPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(_progress, 0, S_WIDTH-_progress*2, _progressHeight) cornerRadius:0];
            break;
        case SPProgressStyleCircle:
            _progressPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:(S_WIDTH - _progressHeight)/ 2 startAngle:- M_PI_2 endAngle:(M_PI * 2) * _progress - M_PI_2 clockwise:YES];
            break;
        default:
            break;
    }
    _progressLayer.path = _progressPath.CGPath;
}

- (void)setProgressHeight:(float)progressHeight {
    _progressHeight = progressHeight;
    kprogressHeight = progressHeight;
    if (_progressStyle == SPProgressStyleCircle) {
        _trackLayer.lineWidth = kprogressHeight;
        _progressLayer.lineWidth = kprogressHeight;
    }
    [self setTrack];
    [self setProgress];
}

- (void)setTrackColor:(UIColor *)trackColor {
    _trackColor = trackColor;
    ktrackColor = trackColor;
    switch (_progressStyle) {
        case SPProgressStyleDefault:
            
        case SPProgressStyleLeft:
            
        case SPProgressStyleCenter:
            _trackLayer.strokeColor = trackColor.CGColor;
            _trackLayer.fillColor = trackColor.CGColor;
            break;
        case SPProgressStyleCircle:
            _trackLayer.strokeColor = trackColor.CGColor;
            _trackLayer.fillColor = nil;
            break;
        default:
            break;
    }
}

- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    kprogressColor = progressColor;
    switch (_progressStyle) {
        case SPProgressStyleDefault:
            
        case SPProgressStyleLeft:
            
        case SPProgressStyleCenter:
            _progressLayer.strokeColor = progressColor.CGColor;
            _progressLayer.fillColor = progressColor.CGColor;
            break;
        case SPProgressStyleCircle:
            _progressLayer.strokeColor = progressColor.CGColor;
            _progressLayer.fillColor = nil;
            
            break;
        default:
            break;
    }
}

- (void)setProgressStyle:(SPProgressStyle)progressStyle {
    _progressStyle = progressStyle;
    switch (_progressStyle) {
        case SPProgressStyleDefault:
            
        case SPProgressStyleLeft:
            
        case SPProgressStyleCenter:
            _trackLayer.strokeColor = ktrackColor.CGColor;
            _trackLayer.fillColor = ktrackColor.CGColor;
            _progressLayer.strokeColor = kprogressColor.CGColor;
            _progressLayer.fillColor = kprogressColor.CGColor;
            break;
        case SPProgressStyleCircle:
            _trackLayer.strokeColor = ktrackColor.CGColor;
            _trackLayer.fillColor = nil;
            _progressLayer.strokeColor = kprogressColor.CGColor;
            _progressLayer.fillColor = nil;
            _trackLayer.lineWidth = kprogressHeight;
            _progressLayer.lineWidth = kprogressHeight;
            break;
        default:
            break;
    }
    [self setTrack];
    [self setProgress];
}

- (void)setProgress:(float)progress {
    [self changeProgress:progress];
    [self setProgress];
}

- (void)changeProgress:(float)progress {
    NSAssert(progress <= 1, @"设置的progress要在0到1之间");
    switch (_progressStyle) {
        case SPProgressStyleDefault:
        case SPProgressStyleLeft:
            _progress = progress*(S_WIDTH);
            break;
        case SPProgressStyleCenter:
            _progress = progress*(S_WIDTH/2);
            break;
        case SPProgressStyleCircle:
            _progress = progress;
            break;
            
        default:
            break;
    }
}

- (void)setProgress:(float)progress animated:(BOOL)animated {
    [self changeProgress:progress];
    [self setProgress];
}

- (void)setRepeats:(BOOL)repeats {
    if (repeats) {
        angle = 0.0;
        self.progressStyle = SPProgressStyleCircle;
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(changeProgress) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    }else {
        [timer invalidate];
        timer = nil;
    }
}

- (void)changeProgress {
    _progressPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:(self.bounds.size.width - _progressHeight)/ 2 startAngle:angle endAngle:(M_PI/2*3)+angle clockwise:YES];
    _progressLayer.path = _progressPath.CGPath;
    angle += (M_PI/90);
    if (angle >= M_PI*2) {
        angle = 0.0;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
