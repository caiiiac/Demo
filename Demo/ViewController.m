//
//  ViewController.m
//  Demo
//
//  Created by caiiiac on 15-3-20.
//  Copyright (c) 2015年 sun3d. All rights reserved.
//

#import "ViewController.h"
#import "AMapViewController.h"
#import "InfiniteLoopViewController.h"
#import "DepthOfFieldEffectViewController.h"
#import "QrCodeViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "CIMPMoviePlayerViewController.h"
#import "ThreadOperationGCDViewController.h"
#import "SpeedAndTimeOffsetViewController.h"
#import "RealTimeBlurViewController.h"

@interface ViewController ()
<UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *arrayData;
@property (nonatomic, strong) NSArray *arrayNameVC;


//播放视频控件
@property (retain, nonatomic) CIMPMoviePlayerViewController *moviePlay;
@end

@implementation ViewController

- (void)loadViews
{
    _arrayData = [NSArray arrayWithObjects:
                  @"高德地图",
                  @"无限循环图片",
                  @"景深效果",
                  @"二维码",
                  @"屏幕控制",
                  @"多线程",
                  @"控制动画时间",
                  @"背景模糊",nil];
    
    _arrayNameVC = [NSArray arrayWithObjects:
                    @"amap",
                    @"InfiniteLoop",
                    @"DepthOfFieldEffect",
                    @"QrCode",
                    @"视频自动横屏",
                    @"NSThread;NSOperation;GCD",
                    @"SpeedAndTimeOffset",
                    @"RealTimeBlur",nil];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Demo";
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self loadViews];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellID = @"cell";
    
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = _arrayData[indexPath.row];
    cell.detailTextLabel.text = _arrayNameVC[indexPath.row];
    
    cell.textLabel.font = [UIFont fontWithName:@"Hiragino Sans GB" size:20];
//    Hiragino Mincho ProN Hiragino Kaku Gothic ProN
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        AMapViewController *amapVC = [[AMapViewController alloc] init];
        amapVC.title = @"高德地图";
        [self.navigationController pushViewController:amapVC animated:YES];
    }
    else if (indexPath.row == 1)
    {
        InfiniteLoopViewController *infiniteLoopVC = [[InfiniteLoopViewController alloc] init];
        infiniteLoopVC.title = @"无限循环图片";
        [self.navigationController pushViewController:infiniteLoopVC animated:YES];
    }
    else if (indexPath.row == 2)
    {
        DepthOfFieldEffectViewController *dofeVC = [[DepthOfFieldEffectViewController alloc] init];
        dofeVC.title = @"景深效果";
        [self.navigationController pushViewController:dofeVC animated:YES];
    }
    else if (indexPath.row == 3)
    {
        QrCodeViewController *qrVC = [[QrCodeViewController alloc] init];
        qrVC.title = @"二维码";
        
        [self.navigationController pushViewController:qrVC animated:YES];
    }
    else if (indexPath.row == 4)
    {
        NSString *name = @"lar.mp4";
        NSURL *path = [[NSBundle mainBundle] URLForResource:[name stringByDeletingPathExtension] withExtension:name.pathExtension];
        _moviePlay = [[CIMPMoviePlayerViewController alloc] initWithContentURL:path];
        _moviePlay.moviePlayer.controlStyle = MPMovieControlStyleDefault;
//        _moviePlay.view.frame = self.view.bounds;
        
//        [self.moviePlay.moviePlayer prepareToPlay];
//        self.moviePlay.moviePlayer.shouldAutoplay = YES;
//        self.moviePlay.moviePlayer.fullscreen = YES;
//        _moviePlay.moviePlayer.view.backgroundColor = [UIColor yellowColor];
        
//        [self presentViewController:self.moviePlay animated:YES completion:nil];
        [self presentMoviePlayerViewControllerAnimated:_moviePlay];
        
        
    }
    else if (indexPath.row == 5)
    {
        ThreadOperationGCDViewController *togVC = [[ThreadOperationGCDViewController alloc] init];
        togVC.title = @"多线程";
        [self.navigationController pushViewController:togVC animated:YES];
    }
    else if (indexPath.row == 6)
    {
        SpeedAndTimeOffsetViewController *speedVC = [[SpeedAndTimeOffsetViewController alloc] init];
        speedVC.title = @"控制动画时间";
        [self.navigationController pushViewController:speedVC animated:YES];
    }
    else if (indexPath.row == 7)
    {
        RealTimeBlurViewController *realTimerBlur = [[RealTimeBlurViewController alloc] init];
        realTimerBlur.title = @"背景模糊";
        [self.navigationController pushViewController:realTimerBlur animated:YES];
    }
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
@end
