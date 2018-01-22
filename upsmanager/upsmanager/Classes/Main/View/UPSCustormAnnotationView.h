//
//  UPSCustormAnnotationView.h
//  upsmanager
//
//  Created by hjun on 2018/1/16.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
@class UPSCustomCalloutView;
@protocol UPSCustormAnnotationViewDelegate<NSObject>
- (void)didClickCustormCalloutViewSureBtn;
@end
@interface UPSCustormAnnotationView : MAAnnotationView

@property (nonatomic,strong)UPSCustomCalloutView *customView;

- (void)sendDataArray:(NSMutableArray *)dataArray;
@property (nonatomic,strong)NSMutableArray *arr;
@property (nonatomic,weak)id <UPSCustormAnnotationViewDelegate>delegate;


@end
