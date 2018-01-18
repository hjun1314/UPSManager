//
//  UPSPersonalVC.m
//  upsmanager
//
//  Created by hjun on 2018/1/17.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "UPSPersonalVC.h"
#import "UPSHeader.h"
#import "UPSLoginVC.h"
#import "UPSChangePassword.h"
#import "UPSChangePasswordVC.h"
@interface UPSPersonalVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
//@property (nonatomic,strong)UITextField *userName;

@end

@implementation UPSPersonalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}
- (void)setup{
    self.navigationItem.title = @"个人中心";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackItem)];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    tableView.dataSource = self;
    tableView.delegate = self;
    
}
- (void)clickBackItem{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"mineCell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
    }
    if (indexPath.row == 0 ) {
        cell.textLabel.text = @"修改密码";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"关于我们";
        
    }else{
        cell.textLabel.text = @"用户注销";
    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 ) {
        
       [UPSTool removePassword];

//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改密码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//            textField.placeholder = @"修改密码";
//            textField.secureTextEntry = YES;
//        }];
//        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            ///http://192.168.1.147:12345/ups-manager/updateAccountPassword
//            NSMutableDictionary *params = [NSMutableDictionary dictionary];
//            params[@"token"] = [UPSTool getToken];
//            params[@"username"] = [UPSTool getUserName];
//            params[@"newPassword"] = alert.textFields[0].text;
//            //            if (self.userName.text.length < 5) {
//            //                [SVProgressHUD showErrorWithStatus:@"密码长度不能低于5"];
//            //                return ;
//            //            }
//            [[UPSHttpNetWorkTool sharedApi]POST:@"updateAccountPassword" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
//                NSLog(@"密码更改成功%@",responseObject);
//                [UPSTool savePassWord:alert.textFields[0].text];
////                [UPSTool removePassword];
//
//                UPSLoginVC *login = [[UPSLoginVC alloc]init];
//                [self.navigationController pushViewController:login animated:YES];
//            } fail:^(NSURLSessionDataTask *task, NSError *error) {
//
//            }];
//
//        }]];
//
//        [self.navigationController presentViewController:alert animated:YES completion:nil];
        UPSChangePasswordVC *changeVC = [[UPSChangePasswordVC alloc]init];
        [self.navigationController pushViewController:changeVC animated:YES];
        
    }else if (indexPath.row == 1){
        
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否注销" message:@"确定注销?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            ///http://192.168.1.147:12345/ups-manager/logout
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"token"] = [UPSTool getToken];
            params[@"username"] = [UPSTool getUserName];
            [[UPSHttpNetWorkTool sharedApi]POST:@"logout" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
                UPSLoginVC *login = [[UPSLoginVC alloc]init];
                [self.navigationController pushViewController:login animated:YES];
                NSLog(@"注销成功%@",responseObject);
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
            
            
        }];
        
        [alert addAction:cancel];
        [alert addAction:sure];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
}

#pragma mark - textfieldDelegate

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    NSCharacterSet *cs;
//    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS]invertedSet];
//     NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    if (self.userName == textField) {
//        if (toBeString.length < 5) {
//        }
//    }
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
