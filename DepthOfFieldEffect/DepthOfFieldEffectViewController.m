//
//  DepthOfFieldEffectViewController.m
//  Demo
//
//  Created by caiiiac on 15-3-20.
//  Copyright (c) 2015年 sun3d. All rights reserved.
//

#import "DepthOfFieldEffectViewController.h"

@interface DepthOfFieldEffectViewController ()
<UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imgView;
@end

@implementation DepthOfFieldEffectViewController

- (void)loadViews
{
    CGRect frame = self.view.bounds;
    frame.size.height -= 64;
    frame.origin.y -= 30;
    _scrollView = [[UIScrollView alloc] initWithFrame:frame];
    [self.view addSubview:_scrollView];
    
    frame.origin.y = 0;
    
    UIImage *img = [UIImage imageNamed:@"gao_list_large.jpg"];
    CGFloat height = img.size.height*1.0 / img.size.width * frame.size.width * 1.0 ;
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, height)];
    _imgView.image = img;
    [_scrollView addSubview:_imgView];
    
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
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


#pragma mark - UITableViewDelegate
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 22;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    static int i = 0;
    
    if (indexPath.row == 0) {
        
        cell =  [tableView dequeueReusableCellWithIdentifier:@"clean"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"clean"];
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.textLabel.text = [NSString stringWithFormat:@"%d",i];
        }
    }
    i++;
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 130;
    }
    
    return 44;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [self updateOffsets];
    
}

- (void) updateOffsets
{
    CGFloat yOffset = _tableView.contentOffset.y;
    CGFloat threshold = _imgView.image.size.height - [[UIScreen mainScreen] bounds].size.height;
    
    if (yOffset > -threshold && yOffset < 0) {
        _scrollView.contentOffset = CGPointMake(0, floorf(yOffset/2.0));
    }
    else if (yOffset < 0)
    {
        _scrollView.contentOffset = CGPointMake(0, yOffset + floorf(threshold/2.0));
    }
    else
    {
        _scrollView.contentOffset = CGPointMake(0, yOffset);
    }
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
