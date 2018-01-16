//
//  UPSHeader.h
//  upsmanager
//
//  Created by hjun on 2018/1/11.
//  Copyright © 2018年 hjun. All rights reserved.
//

#ifndef UPSHeader_h
#define UPSHeader_h

#define NUMBERS @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

#define iphone6P (kScreenW == 414,kScreenH == 736)
#define iphone6 (kScreenW == 375,kScreenH == 667)
#define iphone5 (kScreenW == 320,kScreenH == 568)
#define iphone4 (kScreenW == 320,kScreenH == 480)
#define iphoneX (kScreenW == 375,kScreenH == 812)
///RGB十进制
#define UICOLOR_RGB(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
// RGB颜色(16进制)
#define RGB_HEX(rgbValue) \
[UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((CGFloat)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define SafeAreaTopHeight (kScreenH == 812.0 ? 88 : 64)
#define SafeAreaTabbarHeight (kScreenH == 812.0 ? 83 : 49)

#import "UIView+ZUtility.h"
#import "UPSHttpNetWorkTool.h"
#import "UPSTool.h"


#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <Masonry.h>
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "FMDB.h"
#import <UserNotifications/UserNotifications.h>
#import "JPUSHService.h"

#define API_BaseURL @"http://192.168.1.147:12345/ups-manager/"


#endif /* UPSHeader_h */

