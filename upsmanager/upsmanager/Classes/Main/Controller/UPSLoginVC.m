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
#import "UPSToken.h"
@interface UPSLoginVC ()
@property (nonatomic,strong)UPSLoginView *loginView;

@end

@implementation UPSLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UPSLoginView *loginView = [[UPSLoginView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenW, kScreenH - SafeAreaTopHeight)];
    self.loginView = loginView;
    self.loginView.backgroundColor = UICOLOR_RGB(110, 188, 230, 0.6);
    [self.view addSubview:loginView];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickLoginViewSureBtn) name:@"didClickSureBtn" object:nil];
    self.navigationItem.title = @"账号登录";
    
}
- (void)clickLoginViewSureBtn{
    if (self.loginView.userTextField.text.length == 0 || self.loginView.passwordTextField.text.length == 0) {
//        self.loginView.loginButton.enabled = NO;
    }else {
        [self loadLoginData];
    }

    
}

- (void)loadLoginData{
    ///http://192.168.1.147:12345/ups-manager/adminUserLogin
    [SVProgressHUD showWithStatus:@"正在登陆"];
    [SVProgressHUD setBackgroundColor:UICOLOR_RGB(0, 0, 0, 0.3)];
    NSDictionary *params = @{@"username":self.loginView.userTextField.text,@"password":self.loginView.passwordTextField.text,@"registrationId":[UPSTool getGeTuiCid]};
    [[UPSHttpNetWorkTool sharedApi]POST:@"adminUserLogin" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *dataM = responseObject[@"data"][@"loginCompany"];
        NSDictionary *tokenM = responseObject[@"data"];
        NSLog(@"登录成功%@",responseObject);
        UPSToken *token = [UPSToken mj_objectWithKeyValues:tokenM];
        [UPSTool saveToken:token.token];
        [UPSTool saveUserName:self.loginView.userTextField.text];
        [UPSTool savePassWord:self.loginView.passwordTextField.text];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dict in dataM) {
            UPSLoginCompanyModel *model = [UPSLoginCompanyModel mj_objectWithKeyValues:dict];
            [tempArr addObject:model];
        }
        UPSMainVC *main = [[UPSMainVC alloc]init];
        main.loginCompanyArr = tempArr;
        [self.navigationController pushViewController:main animated:YES];
        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"账号或密码错误，请重新登录"];
        
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
