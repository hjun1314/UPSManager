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
#import "UPSPersonalVC.h"
#import "UPSShowUPSDetailModel.h"
#import "UPSCompanyInfoVC.h"
@interface UPSMainVC ()<MAMapViewDelegate,UPSCustormAnnotationViewDelegate>
@property (nonatomic,strong)MAMapView *mapView;

@property (nonatomic,assign)long upsID;

@property (nonatomic,strong)NSMutableArray *annotionArray;


@end

@implementation UPSMainVC
///测试sourcetree上传
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self addMapView];
    [self setupBtn];
    ///http://192.168.1.147:12345/ups-manager/getAllCompany
    ///获取所有公司
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = [UPSTool getToken];
    params[@"username"] = [UPSTool getUserName];
    [[UPSHttpNetWorkTool sharedApi]POST:@"getAllCompany" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"全国公司分布%@",responseObject);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    NSMutableArray *tempArr = [NSMutableArray array];

    for (UPSLoginCompanyModel *model in self.loginCompanyArr) {
         MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
         pointAnnotation.coordinate = CLLocationCoordinate2DMake(model.latitude, model.longitude);
        self.upsID = model.id;
        [tempArr addObject:pointAnnotation];
    }
    [_mapView addAnnotations:tempArr];
    self.annotionArray = tempArr;
    
    
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
    self.mapView.zoomLevel = 4;
    [self.view addSubview:mapView];
}

- (void)setupBtn{
    UIButton *equipmentBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kScreenH - SafeAreaTabbarHeight, 32, 32)];
    [self.view addSubview:equipmentBtn];
    [equipmentBtn addTarget:self action:@selector(clickEquipmentBtn) forControlEvents:UIControlEventTouchUpInside];
    [equipmentBtn setBackgroundImage:[UIImage imageNamed:@"ups"] forState:UIControlStateNormal];
    
    UIButton *personalBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenW - 52, kScreenH - SafeAreaTabbarHeight, 32, 32)];
    [self.view addSubview:personalBtn];
    [personalBtn addTarget:self action:@selector(clcikPersonalBtn) forControlEvents:UIControlEventTouchUpInside];
    [personalBtn setBackgroundImage:[UIImage imageNamed:@"owner_un"] forState:UIControlStateNormal];
    
}
- (void)clickEquipmentBtn{
    ///http://192.168.1.147:12345/ups-manager/companyDetails
    UPSCompanyInfoVC *infoVC = [[UPSCompanyInfoVC alloc]init];
    [self.navigationController pushViewController:infoVC animated:YES];
    
}
- (void)clcikPersonalBtn{
    UPSPersonalVC *person = [[UPSPersonalVC alloc]init];
    [self.navigationController pushViewController:person animated:YES];
   ///http://192.168.1.147:12345/ups-manager/upsBaseParameter
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"token"] = [UPSTool getToken];
    params[@"username"] = [UPSTool getUserName];
    params[@"upsId"] = @(1);
    [[UPSHttpNetWorkTool sharedApi]POST:@"upsBaseParameter" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dictM = responseObject[@"data"];
        NSLog(@"显示ups基础信息成功%@",responseObject);
        NSMutableArray *tempArr = [NSMutableArray array];
        UPSShowUPSDetailModel *model = [UPSShowUPSDetailModel mj_objectWithKeyValues:dictM];
        [tempArr addObject:model];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
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
        annotationView.delegate = self;
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}
#pragma mark- 查看详情点击按钮
- (void)didClickCustormCalloutViewSureBtn{
    NSLog(@"点击了查看详情按钮");
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    for (int i = 0; i < self.annotionArray.count; i++) {
        if (view.annotation.coordinate.longitude == ((MAPointAnnotation *)self.annotionArray[i]).coordinate.longitude) {
            NSLog(@".......%.4f",view.annotation.coordinate.longitude);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
