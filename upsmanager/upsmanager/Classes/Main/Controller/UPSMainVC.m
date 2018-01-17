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
#import "UPSCompanyDetailModel.h"
@interface UPSMainVC ()<MAMapViewDelegate>
@property (nonatomic,strong)MAMapView *mapView;

@end

@implementation UPSMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self addMapView];
    [self setupBtn];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    NSMutableArray *tempArr = [NSMutableArray array];

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
    self.mapView.zoomLevel = 5;
    [self.view addSubview:mapView];
}

- (void)setupBtn{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, kScreenH - 30, 30, 20)];
    [btn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, kScreenH - 30, 44, 20)];
    [rightBtn setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(clcikRightBtn) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)clickBtn{
    ///http://192.168.1.147:12345/ups-manager/companyDetails
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    UPSLoginCompanyModel *model = [UPSLoginCompanyModel sharedUPSLoginCompanyModel];
    params[@"token"] = [UPSTool getToken];
    params[@"username"] = @"test";
    params[@"companyId"] = @(1);

    for (UPSLoginCompanyModel *model in self.loginCompanyArr) {

    }
    [[UPSHttpNetWorkTool sharedApi]POST:@"companyDetails" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"公司详细内容成功%@",responseObject);
        NSMutableArray *dataM = responseObject[@"data"];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dict in dataM) {
            UPSCompanyDetailModel *model = [UPSCompanyDetailModel mj_objectWithKeyValues:dict];
            [tempArr addObject:model];
        }
      
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    NSLog(@"dasdas");
}
- (void)clcikRightBtn{
    ///http://192.168.1.147:12345/ups-manager/upsBaseParameter
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = [UPSTool getToken];
    params[@"username"] = @"武汉大学";
    params[@"upsId"] = @(1);
    [[UPSHttpNetWorkTool sharedApi]POST:@"upsBaseParameter" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"显示UPS基础信息%@",responseObject);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {

    }];
    NSLog(@"dassssss");
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
        [annotationView sendDataArray:self.loginCompanyArr];
        
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
