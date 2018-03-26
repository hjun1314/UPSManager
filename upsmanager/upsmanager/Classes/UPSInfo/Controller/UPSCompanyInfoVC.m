//
//  UPSCompanyInfoVC.m
//  upsmanager
//
//  Created by hjun on 2018/1/17.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "UPSCompanyInfoVC.h"
#import "UPSHeader.h"
#import "UPSCompanyDetailModel.h"
#import "UPSBaseInfoView.h"
#import "GKCover.h"
@interface UPSCompanyInfoVC ()

@end

@implementation UPSCompanyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
}
- (void)setNav{
   
    self.navigationItem.title = @"设备详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"基础信息" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightItem)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBack)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenW, 150)];
    imageView.image = [UIImage imageNamed:@"er"];
    [self.view addSubview:imageView];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)clickBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickRightItem{
    UPSBaseInfoView *info = [[UPSBaseInfoView alloc]init];
    info.gk_size = CGSizeMake(kScreenW *0.7, 215);
    
    [GKCover translucentWindowCenterCoverContent:info animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = [UPSTool getToken];
    params[@"username"] = [UPSTool getUserName];
    params[@"companyId"] = @(1);
    
    
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
}
- (void)loadData{
   
    
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
