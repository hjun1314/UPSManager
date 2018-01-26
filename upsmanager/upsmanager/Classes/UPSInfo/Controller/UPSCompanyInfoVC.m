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
@interface UPSCompanyInfoVC ()

@end

@implementation UPSCompanyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
  ///http://192.168.1.147:12345/ups-manager/upsSituation
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenW, 150)];
    imageView.image = [UIImage imageNamed:@"er"];
    [self.view addSubview:imageView];
    [self loadData];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)loadData{
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
