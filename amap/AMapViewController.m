//
//  AMapViewController.m
//  Demo
//
//  Created by caiiiac on 15-3-20.
//  Copyright (c) 2015年 sun3d. All rights reserved.
//

#import <AMapSearchKit/AMapSearchAPI.h>
#import <MAMapKit/MAMapKit.h>


#import "AMapViewController.h"

@interface AMapViewController ()
<AMapSearchDelegate,
MAMapViewDelegate>

@property (nonatomic, strong) AMapSearchAPI *search;

@property (nonatomic, strong) MAMapView *mapView;

@end

@implementation AMapViewController

- (void)loadViews
{
    //初始化检索对象
    _search = [[AMapSearchAPI alloc] initWithSearchKey:@"b580952d44a40e74cb24cca20037539d" Delegate:self];

    //构造AMapPlaceSearchRequest对象，配置关键字搜索参数
    AMapPlaceSearchRequest *poiRequest = [[AMapPlaceSearchRequest alloc] init];
    poiRequest.searchType = AMapSearchType_PlaceKeyword;
    poiRequest.keywords = @"西湖";
    poiRequest.city = @[@"杭州"];
    poiRequest.requireExtension = YES;

    //发起POI搜索
    [_search AMapPlaceSearch: poiRequest];



    //配置用户Key
    [MAMapServices sharedServices].apiKey = @"b580952d44a40e74cb24cca20037539d";

    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;

    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(30.259031, 120.157114) animated:NO];
    [_mapView setZoomLevel:13 animated:YES];
    [self.view addSubview:_mapView];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 地图代理函数
//实现POI搜索对应的回调函数
- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response
{
    if(response.pois.count == 0)
    {
        return;
    }
    
    //通过AMapPlaceSearchResponse对象处理搜索结果
    NSString *strCount = [NSString stringWithFormat:@"count: %ld",(long)response.count];
    NSString *strSuggestion = [NSString stringWithFormat:@"Suggestion: %@", response.suggestion];
    NSString *strPoi = @"";
    for (AMapPOI *p in response.pois) {
        strPoi = [NSString stringWithFormat:@"%@\nPOI: %@", strPoi, p.description];
        
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(p.location.latitude, p.location.longitude);
        pointAnnotation.title = p.name;
        pointAnnotation.subtitle = p.address;
        
        [_mapView addAnnotation:pointAnnotation];
        
    }
    NSString *result = [NSString stringWithFormat:@"%@ \n %@ \n %@", strCount, strSuggestion, strPoi];
    NSLog(@"Place: %@", result);
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.canShowCallout= YES; //设置气泡可以弹出,默认为 NO annotationView.animatesDrop = YES; //设置标注动画显示,默认为 NO
        annotationView.draggable = YES; //设置标注可以拖动,默认为 NO annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
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
