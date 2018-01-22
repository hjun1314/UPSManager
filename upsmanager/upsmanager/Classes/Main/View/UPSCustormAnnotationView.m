//
//  UPSCustormAnnotationView.m
//  upsmanager
//
//  Created by hjun on 2018/1/16.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "UPSCustormAnnotationView.h"
#import "UPSCustomCalloutView.h"
#import "UPSLoginCompanyModel.h"
#define kCalloutWidth       120.0
#define kCalloutHeight      110.0

@implementation UPSCustormAnnotationView

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.customView == nil)
        {
            self.customView = [[UPSCustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.customView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.customView.bounds) / 2.f + self.calloutOffset.y);
        }
        for (int i = 0; i < self.arr.count; i++)
        {        UPSLoginCompanyModel *model = self.arr[i];
            
            if (model.latitude == self.annotation.coordinate.latitude && model.longitude == self.annotation.coordinate.longitude) {
                _customView.nameLabel.text = model.name;
                _customView.normalLabel.text = [NSString stringWithFormat:@"%d",model.normalCount];
                _customView.unknownLabel.text = [NSString stringWithFormat:@"%d",model.unkownCount];
                _customView.faultLabel.text = [NSString stringWithFormat:@"%d",model.communicationErrorCount];
                [_customView.sureBtn addTarget:self action:@selector(clickSureBtn) forControlEvents:UIControlEventTouchUpInside];
            }
            
            
        }
        [self addSubview:self.customView];
    }
    else
    {
        [self.customView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

- (void)sendDataArray:(NSMutableArray *)dataArray{
    
    self.arr = dataArray;
    
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        CGPoint tempoint = [self.customView.sureBtn convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.customView.sureBtn.bounds, tempoint))
        {
            view = self.customView.sureBtn;
        }
    }
    return view;
}
- (void)clickSureBtn{
    if ([self.delegate respondsToSelector:@selector(didClickCustormCalloutViewSureBtn)]) {
        [self.delegate didClickCustormCalloutViewSureBtn];
    }
}
@end
