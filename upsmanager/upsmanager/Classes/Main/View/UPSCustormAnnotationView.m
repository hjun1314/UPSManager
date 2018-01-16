//
//  UPSCustormAnnotationView.m
//  upsmanager
//
//  Created by hjun on 2018/1/16.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "UPSCustormAnnotationView.h"
#import "UPSCustomCalloutView.h"
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
        
       
        
        [self addSubview:self.customView];
    }
    else
    {
        [self.customView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}


@end
