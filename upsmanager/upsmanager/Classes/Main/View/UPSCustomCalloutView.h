//
//  UPSCustomCalloutView.h
//  upsmanager
//
//  Created by hjun on 2018/1/16.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UPSLoginCompanyModel;
@interface UPSCustomCalloutView : UIView

@property (nonatomic,strong)UILabel *nameLabel;

@property (nonatomic,strong)UILabel *unknownLabel;

@property (nonatomic,strong)UILabel *normalLabel;

@property (nonatomic,strong)UILabel *faultLabel;

@property (nonatomic,strong)UIButton *sureBtn;

@property (nonatomic,strong)UPSLoginCompanyModel *model;

- (void)sendDataArray:(NSMutableArray *)dataArray;

@end
