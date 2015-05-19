//
//  ThreadOperationGCDViewController.m
//  Demo
//
//  Created by caiiiac on 15-5-6.
//  Copyright (c) 2015年 sun3d. All rights reserved.
//

#define ROW_COUNT 4
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10

#import "ThreadOperationGCDViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface KCImageData : NSObject

@property (nonatomic, assign) int index;

@property (nonatomic, strong) NSData *data;

@end

@implementation KCImageData



@end
@interface ThreadOperationGCDViewController ()

@property (nonatomic, strong) NSMutableArray *arrayImgViews;

@end

@implementation ThreadOperationGCDViewController

- (void)loadViews
{
    _arrayImgViews = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i =0; i < ROW_COUNT; i++) {
        for (int j =0; j < COLUMN_COUNT; j++) {
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(j*ROW_WIDTH+(j*CELL_SPACING), i*ROW_HEIGHT+(i*CELL_SPACING), ROW_WIDTH, ROW_HEIGHT)];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            
            [self.view addSubview:imgView];
            [_arrayImgViews addObject:imgView];
        }
    }
    
#pragma mark Thread
    UIButton *btnThread = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnThread.frame = CGRectMake(20, 500, 80, 20);
    [btnThread setTitle:@"Thread" forState:UIControlStateNormal];
    
    [[btnThread rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        //创建多个线程用于填充图片
        for (int i = 0; i < ROW_COUNT * COLUMN_COUNT; ++i) {
            NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadImg:) object:[NSNumber numberWithInt:i]];
            thread.name = [NSString stringWithFormat:@"thread%i",i];
            [thread start];
        }
    }];
    
    [self.view addSubview:btnThread];
}

#pragma mark - 加载图片
-(void)loadImg:(NSNumber *)index{
    //    NSLog(@"%i",i);
    //currentThread方法可以取得当前操作线程
//    NSLog(@"current thread:%@",[NSThread currentThread]);
    
    int i=[index intValue];
    
    //    NSLog(@"%i",i);//未必按顺序输出
    
    NSData *data= [self requestData:i];
    
    KCImageData *imageData=[[KCImageData alloc]init];
    imageData.index=i;
    imageData.data=data;
    [self performSelectorOnMainThread:@selector(updateImage:) withObject:imageData waitUntilDone:YES];
}
#pragma mark 将图片显示到界面
-(void)updateImage:(KCImageData *)imageData{
    UIImage *image=[UIImage imageWithData:imageData.data];
    UIImageView *imageView= _arrayImgViews[imageData.index];
    imageView.image=image;
}

#pragma mark 请求图片数据
-(NSData *)requestData:(int )index{
    //对于多线程操作建议把线程操作放到@autoreleasepool中
    @autoreleasepool {
        
        //对非最后一张图片加载线程休眠2秒
//        if (index!=(ROW_COUNT*COLUMN_COUNT-1))
//            [NSThread sleepForTimeInterval:2.0];

        
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"URL_List" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSURL *url= [NSURL URLWithString:array[index]];
        NSData *data=[NSData dataWithContentsOfURL:url];
        return data;
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
