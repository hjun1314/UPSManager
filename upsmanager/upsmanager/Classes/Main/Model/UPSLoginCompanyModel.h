//
//  UPSLoginCompanyModel.h
//  upsmanager
//
//  Created by hjun on 2018/1/16.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UPSHeader.h"
@interface UPSLoginCompanyModel : NSObject
//Singleton_h(UPSLoginCompanyModel)
@property (nonatomic,assign)long id;

@property (nonatomic,copy)NSString *name;

@property (nonatomic,assign)double longitude;

@property (nonatomic,assign)double latitude;

@property (nonatomic,assign)int normalCount;

@property (nonatomic,assign)int unkownCount;

@property (nonatomic,assign)int communicationErrorCount;



@end
