//
//  RealTimeBlurViewController.m
//  Demo
//
//  Created by caiiiac on 15/7/31.
//  Copyright (c) 2015年 sun3d. All rights reserved.
//

#import "RealTimeBlurViewController.h"
#import <XHRealTimeBlur/XHRealTimeBlur.h>
#import "UIImage+ImageEffects.h"

@interface RealTimeBlurViewController ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) int index;
@property (nonatomic, copy) NSArray *imgArray;

@property (nonatomic, strong) CALayer *imgLayer;

@property (nonatomic, strong) UIView *loginView;

@property (nonatomic, strong) CIContext *context;

@end

@implementation RealTimeBlurViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initView
{
    self.navigationController.navigationBar.translucent = YES;
    _imgArray = @[@"1.png",@"2.png",@"3.png",@"4.png"];
    _index = 0;
    
    _imgLayer = [CALayer layer];
    _imgLayer.frame = self.view.frame;
    
    [self.view.layer addSublayer:_imgLayer];
    _imgLayer.contents = (__bridge id)([[UIImage imageNamed:_imgArray[_index]] applyBlurWithRadius:10 tintColor:[UIColor colorWithWhite:0.23 alpha:0.53] saturationDeltaFactor:1.8 maskImage:nil].CGImage);
    
   _context = [CIContext contextWithOptions:nil];
    
    
    _loginView = [[UIView alloc] initWithFrame:self.view.bounds];
    _loginView.backgroundColor = [UIColor clearColor];
 
//    [_loginView showRealTimeBlurWithBlurStyle:XHBlurStyleBlackGradient];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 60, 20);
    btn.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 100);
    
    [self.view addSubview:_loginView];
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewDidAppear:(BOOL)animated
{
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(_timerAction:) userInfo:nil repeats:YES];
    
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    
    self.navigationController.navigationBar.translucent = NO;
    [_timer invalidate];
    [super viewDidDisappear:animated];
}

- (void)_timerAction:(id)timer
{

    CABasicAnimation *contentsAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
    contentsAnimation.fromValue = (__bridge id)([[UIImage imageNamed:_imgArray[_index]] applyBlurWithRadius:10 tintColor:[UIColor colorWithWhite:0.23 alpha:0.53] saturationDeltaFactor:1.8 maskImage:nil].CGImage);
    contentsAnimation.toValue = (__bridge id)([[UIImage imageNamed:_imgArray[_index+1>=_imgArray.count?0:_index+1]] applyBlurWithRadius:10 tintColor:[UIColor colorWithWhite:0.23 alpha:0.53] saturationDeltaFactor:1.8 maskImage:nil].CGImage);
    contentsAnimation.duration = 2.f;
    
    _index = _index+1 >= _imgArray.count ? 0 :_index+1;
    _imgLayer.contents = (__bridge id)([[UIImage imageNamed:_imgArray[_index]] applyBlurWithRadius:10 tintColor:[UIColor colorWithWhite:0.23 alpha:0.53] saturationDeltaFactor:1.8 maskImage:nil].CGImage);
    
    [_imgLayer addAnimation:contentsAnimation forKey:nil];
    

}
@end
