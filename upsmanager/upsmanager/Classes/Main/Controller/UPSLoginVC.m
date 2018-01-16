//
//  UPSLoginVC.m
//  upsmanager
//
//  Created by hjun on 2018/1/11.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "UPSLoginVC.h"
#import "UPSLoginView.h"
#import "UPSHeader.h"
#import "UPSMainVC.h"
#import "UPSLoginCompanyModel.h"
@interface UPSLoginVC ()
@property (nonatomic,strong)UPSLoginView *loginView;

@end

@implementation UPSLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UPSLoginView *loginView = [[UPSLoginView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenW, kScreenH - SafeAreaTopHeight)];
    self.loginView = loginView;
    [self.view addSubview:loginView];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickLoginViewSureBtn) name:@"didClickSureBtn" object:nil];
    self.navigationItem.title = @"账号登录";
    
}
- (void)clickLoginViewSureBtn{
    ///http://192.168.1.147:12345/ups-manager/adminUserLogin
     NSDictionary *params = @{@"username":self.loginView.userTextField.text,@"password":self.loginView.passwordTextField.text,@"registrationId":[UPSTool getGeTuiCid]};
    [[UPSHttpNetWorkTool sharedApi]POST:@"adminUserLogin" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *dataM = responseObject[@"data"][@"loginCompany"];
        NSLog(@"登录成功%@",responseObject);
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dict in dataM) {
            UPSLoginCompanyModel *model = [UPSLoginCompanyModel mj_objectWithKeyValues:dict];
            [tempArr addObject:model];
        }
        UPSMainVC *main = [[UPSMainVC alloc]init];
        main.loginCompanyArr = tempArr;
        [self.navigationController pushViewController:main animated:YES];
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
