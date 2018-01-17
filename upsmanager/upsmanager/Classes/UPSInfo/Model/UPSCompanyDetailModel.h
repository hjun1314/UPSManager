//
//  UPSCompanyDetailModel.h
//  upsmanager
//
//  Created by hjun on 2018/1/17.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPSCompanyDetailModel : NSObject

@property (nonatomic,assign)long id;
///用户定义的名称
@property (nonatomic,copy)NSString *userDefinedUpsName;
///原始名称
@property (nonatomic,copy)NSString *originalUpsName;
///状态
@property (nonatomic,copy)NSString *memo;





@end
