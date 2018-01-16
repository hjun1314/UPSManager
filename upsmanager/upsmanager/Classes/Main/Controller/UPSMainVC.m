//
//  UPSMainVC.m
//  UPSManager
//
//  Created by hjun on 2018/1/10.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "UPSMainVC.h"
#import "UPSHeader.h"
#import "UPSCustormAnnotationView.h"
#import "UPSCustomCalloutView.h"
#import "UPSLoginCompanyModel.h"
@interface UPSMainVC ()<MAMapViewDelegate>
@property (nonatomic,strong)MAMapView *mapView;

@end

@implementation UPSMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self addMapView];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    NSMutableArray *tempArr = [NSMutableArray array];
//    for (int i = 0; i < self.loginCompanyArr.count; i++) {
//        UPSLoginCompanyModel *model = [UPSLoginCompanyModel mj_objectWithKeyValues:self.loginCompanyArr[i]];
//        pointAnnotation.coordinate = CLLocationCoordinate2DMake(model.latitude, model.longitude);
//        [tempArr addObject:model];
//
//    }
    for (UPSLoginCompanyModel *model in self.loginCompanyArr) {
         MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
         pointAnnotation.coordinate = CLLocationCoordinate2DMake(model.latitude, model.longitude);
     
        [tempArr addObject:pointAnnotation];
    }
    [_mapView addAnnotations:tempArr];
    
    
    
}
- (void)setNav{
    self.navigationItem.title = @"全国UPS状态";
    self.navigationItem.hidesBackButton = YES;

   
}
- (void)addMapView{
    ///初始化地图
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
//    _mapView.showsUserLocation = YES;
//    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    ///把地图添加至view
    self.mapView = mapView;
    self.mapView.delegate = self;
    [self.view addSubview:mapView];
}

- (void)setupBtn{
   
}


#pragma mark- MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        UPSCustormAnnotationView *annotationView = (UPSCustormAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[UPSCustormAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"location"];
        
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
