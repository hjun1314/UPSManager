//
//  UPSMainVC.m
//  UPSManager
//
//  Created by hjun on 2018/1/10.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "UPSMainVC.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
@interface UPSMainVC ()
@property (nonatomic,strong)MAMapView *mapView;

@end

@implementation UPSMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMapView];
}
- (void)addMapView{
    
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    MAMapView *_mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    ///把地图添加至view
    [self.view addSubview:_mapView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
