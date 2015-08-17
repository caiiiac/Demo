//
//  SpeedAndTimeOffsetViewController.m
//  Demo
//
//  Created by caiiiac on 15/7/17.
//  Copyright (c) 2015年 sun3d. All rights reserved.
//

#import "SpeedAndTimeOffsetViewController.h"

@interface SpeedAndTimeOffsetViewController ()

@property (weak, nonatomic) IBOutlet UIView *myView;
@property (nonatomic, strong) CALayer *myLayer;
@end

@implementation SpeedAndTimeOffsetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    _myLayer = [CALayer layer];
    _myLayer.frame = _myView.bounds;
    _myLayer.backgroundColor = [UIColor orangeColor].CGColor;
    
    [_myView.layer addSublayer:_myLayer];

    
    CABasicAnimation *changeColor =  [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    
    changeColor.fromValue = (id)[UIColor orangeColor].CGColor;
    
    changeColor.toValue   = (id)[UIColor blueColor].CGColor;
    
    changeColor.duration  = 1.0; // For convenience
    
    [_myLayer addAnimation:changeColor forKey:@"Change color"];
    
    _myLayer.speed = 0.0; // Pause the animation
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sliderChanged:(UISlider *)sender {
    
    _myLayer.timeOffset = sender.value;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
