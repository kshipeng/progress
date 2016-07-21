//
//  ViewController.m
//  SPProgressView
//
//  Created by 康世朋 on 16/7/21.
//  Copyright © 2016年 SP. All rights reserved.
//

#import "ViewController.h"
#import "SPProgressView.h"

@interface ViewController ()
{
    SPProgressView *pro;
    NSTimer *timer;
    CGFloat loop;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    loop = 0;
    self.view.backgroundColor = [UIColor lightGrayColor];
    pro = [[SPProgressView alloc]initWithFrame:CGRectMake(40, 100, 60, 60)];
    
    pro.trackColor = [UIColor redColor];//背景色
    pro.progressColor = [UIColor greenColor];//进度条颜色
    pro.progress = 0.2; //设置进度
    pro.progressHeight = 6;//设置进度条宽度
    pro.progressStyle = SPProgressStyleCircle;//设置样式
    //pro.repeats = YES;//旋转效果，若开启请把下面的timer注释掉
    [self.view addSubview:pro];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(changeProgress) userInfo:nil repeats:YES];
}
- (void)changeProgress {
    NSLog(@">>%f",loop);
    if (loop >= 1) {loop = 0;}
    pro.progress = loop;
    loop += 0.001;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
