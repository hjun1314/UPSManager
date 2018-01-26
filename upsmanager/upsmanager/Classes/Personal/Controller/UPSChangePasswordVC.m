//
//  UPSChangePasswordVC.m
//  upsmanager
//
//  Created by hjun on 2018/1/18.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "UPSChangePasswordVC.h"
#import "UPSChangePassword.h"
#import "UPSHeader.h"
#import "UPSLoginVC.h"
#import "AppDelegate.h"
@interface UPSChangePasswordVC ()
///  是否需要核对原密码
@property (nonatomic,assign) BOOL needOrignalPW;
///  修改密码的 View
@property (nonatomic, strong) UPSChangePassword *changPasswordView;
// 是否来自doc
@property (assign, nonatomic) BOOL comForDoc;
@end

@implementation UPSChangePasswordVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationItem];
    UPSChangePassword *changeView = [[UPSChangePassword alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenW, kScreenH - SafeAreaTopHeight)];
    self.changPasswordView = changeView;
    [self.view addSubview:changeView];
    [self.changPasswordView.completeBtn addTarget:self action:@selector(clickSureBtn) forControlEvents:UIControlEventTouchUpInside];
}


/// 设置返回按钮
- (void)setupNavigationItem {
    
        self.navigationItem.title = @"重置密码";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(popoverViewController)];
}

- (void)popoverViewController{
    [self.navigationController popViewControllerAnimated:YES
     ];
}

- (void)clickSureBtn{
    
    if (self.changPasswordView.passwordFirstField.text.length < 5 || self.changPasswordView.passwordSecondField.text.length < 5) {
        [SVProgressHUD showErrorWithStatus:@"更改的密码长度不能低于5个字符"];
        return;
    }else if (![self.changPasswordView.passwordFirstField.text isEqualToString:self.changPasswordView.passwordSecondField.text]){
        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一致,请重新输入"];
        return;
    }else{
//        [SVProgressHUD showSuccessWithStatus:@"设置密码成功"];
        [self changePassWordLoad];
    }
    
}
- (void)changePassWordLoad{
    //            ///http://192.168.1.147:12345/ups-manager/updateAccountPassword
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                params[@"token"] = [UPSTool getToken];
                params[@"username"] = [UPSTool getUserName];
                params[@"newPassword"] = self.changPasswordView.passwordFirstField.text;
                //            if (self.userName.text.length < 5) {
                //                [SVProgressHUD showErrorWithStatus:@"密码长度不能低于5"];
                //                return ;
                //            }
                [[UPSHttpNetWorkTool sharedApi]POST:@"updateAccountPassword" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
                    NSLog(@"密码更改成功%@",responseObject);
                   
                    [UPSTool savePassWord:self.changPasswordView.passwordSecondField.text];
    
//                    UPSLoginVC *login = [[UPSLoginVC alloc]init];
//                    [self.navigationController pushViewController:login animated:YES];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [(AppDelegate *)[UIApplication sharedApplication].delegate showWindowHome:@"logout"];
                        [SVProgressHUD showSuccessWithStatus:@"密码更改成功"];
                    });
                   
                } fail:^(NSURLSessionDataTask *task, NSError *error) {
    
                }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
