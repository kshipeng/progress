//
//  SPProgressView.h
//  SPProgressView
//
//  Created by 康世朋 on 16/6/7.
//  Copyright © 2016年 SP. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SPProgressStyleDefault,//一般样式：进度条从左至右
    SPProgressStyleLeft,//进度条从右向左
    SPProgressStyleCenter,//默认样式：仿微信视频录制，从两边往中间缩进
    SPProgressStyleCircle,//圆形，仿QQ视频录制进度提醒样式
} SPProgressStyle;

@interface SPProgressView : UIView

@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic, assign) float progress;//0~1之间的数
@property (nonatomic, assign) float progressHeight;
@property (nonatomic, assign) SPProgressStyle progressStyle;
@property (nonatomic, assign) BOOL repeats;//旋转效果

- (void)setProgress:(float)progress animated:(BOOL)animated;

@end
