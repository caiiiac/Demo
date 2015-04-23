//
//  InfiniteLoopViewController.m
//  Demo
//
//  Created by caiiiac on 15-3-20.
//  Copyright (c) 2015年 sun3d. All rights reserved.
//
#define SCREEN_WIDTH self.view.bounds.size.width
#define SCREEN_HEIGHT self.view.bounds.size.height - 64

#import "InfiniteLoopViewController.h"

@interface InfiniteLoopViewController ()
<UIScrollViewDelegate>


@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, strong) UIImageView *rightImageView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) NSMutableArray *imageData;

@property (nonatomic, assign) NSInteger currentImageIndex;

@property (nonatomic, assign) NSInteger imageCount;

@end

@implementation InfiniteLoopViewController

- (void)loadViews
{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"imageList" ofType:@"plist"];
    _imageData = [NSMutableArray arrayWithContentsOfFile:path];
    
    _imageCount = _imageData.count;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:_scrollView];
    
    _scrollView.delegate = self;
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, SCREEN_HEIGHT);
    [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
    
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    
    
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",_imageData[_imageCount-1]]];
    _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _centerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",_imageData[0]]];
    _centerImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2 * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _rightImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",_imageData[1]]];
    _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [_scrollView addSubview:_leftImageView];
    [_scrollView addSubview:_centerImageView];
    [_scrollView addSubview:_rightImageView];
    
    
    _currentImageIndex = 0;
    
    
    _pageControl = [[UIPageControl alloc] init];
    CGSize size = [_pageControl sizeForNumberOfPages:_imageCount];
    _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    _pageControl.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-100 + 64);
    _pageControl.numberOfPages = _imageCount;
    _pageControl.currentPage = _currentImageIndex;
    
    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:193/255.0 green:219/255.0 blue:249/255.0 alpha:1.0];
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0 green:150/255.0 blue:1 alpha:1];
    [self.view addSubview:_pageControl];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 滚动事件
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self reloadImage];
    
    [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
    _pageControl.currentPage = _currentImageIndex;
    
}

#pragma mark - 重新加载图片
- (void) reloadImage
{
    NSInteger leftImageIndex,rightImageIndex;
    CGPoint offset = [_scrollView contentOffset];
    
    //向左滑动
    if (offset.x > SCREEN_WIDTH) {
        NSLog(@"向左  %f",offset.x);
        _currentImageIndex = (_currentImageIndex + 1) % _imageCount;
    }
    //向右滑动
    else if (offset.x < SCREEN_WIDTH)
    {
        NSLog(@"向右  %f",offset.x);
        _currentImageIndex = (_currentImageIndex + _imageCount - 1) % _imageCount;
    }
    
    _centerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",_imageData[_currentImageIndex]]];
    
    leftImageIndex = (_currentImageIndex + _imageCount -1) % _imageCount;
    rightImageIndex = (_currentImageIndex + 1) % _imageCount;
    
    _leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",_imageData[leftImageIndex]]];
    _rightImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",_imageData[rightImageIndex]]];
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
