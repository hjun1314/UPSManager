//
//  UPSShowUPSDetailModel.h
//  upsmanager
//
//  Created by hjun on 2018/1/22.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>
///显示UPS基础信息模型
@interface UPSShowUPSDetailModel : NSObject
///ups型号
@property (nonatomic,copy)NSString *upsModel;
///ups版本号
@property (nonatomic,copy)NSString *version;
///容量
@property (nonatomic,assign)int capability;
///输出功率
@property (nonatomic,assign)int configOutputPower;
///输入电压
@property (nonatomic,assign)int configInputVolt;
///输出电压
@property (nonatomic,assign)int configOutputVolt;
///输入频率
@property (nonatomic,assign)int configInputFreq;
///输出频率
@property (nonatomic,assign)int configOutputFreq;









@end
