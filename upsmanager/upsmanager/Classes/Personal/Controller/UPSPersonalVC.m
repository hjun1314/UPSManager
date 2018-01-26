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
#import "AppDelegate.h"
#import "UPSAboutUsVC.h"
@interface UPSPersonalVC ()<UITableViewDelegate,UITableViewDataSource,UIApplicationDelegate>

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
        
//       [UPSTool removePassword];


        UPSChangePasswordVC *changeVC = [[UPSChangePasswordVC alloc]init];
        [self.navigationController pushViewController:changeVC animated:YES];
        
    }else if (indexPath.row == 1){
        
        UPSAboutUsVC *about = [[UPSAboutUsVC alloc]init];
        [self.navigationController pushViewController:about animated:YES];
        ///http://192.168.1.147:12345/ups-manager/upsSituation
//        NSMutableDictionary *params = [NSMutableDictionary dictionary];
//        params[@"token"] = [UPSTool getToken];
//        params[@"username"] = [UPSTool getUserName];
//        params[@"upsId"] = @"1";
//        [[UPSHttpNetWorkTool sharedApi]POST:@"upsSituation" baseURL:API_BaseURL params:params success:^(NSURLSessionDataTask *task, id responseObject) {
//            NSLog(@"获得历史数据成功%@",responseObject);
//        } fail:^(NSURLSessionDataTask *task, NSError *error) {
//
//        }];
        
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
[(AppDelegate *)[UIApplication sharedApplication].delegate showWindowHome:@"logout"];
                [SVProgressHUD showSuccessWithStatus:@"注销成功"];
                NSLog(@"注销成功%@",responseObject);
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
            
            
        }];
        
        [alert addAction:cancel];
        [alert addAction:sure];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
