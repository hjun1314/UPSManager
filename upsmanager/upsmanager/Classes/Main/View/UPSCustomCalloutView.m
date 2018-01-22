//
//  UPSCustomCalloutView.m
//  upsmanager
//
//  Created by hjun on 2018/1/16.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "UPSCustomCalloutView.h"
#import "UPSHeader.h"
#import "UPSLoginCompanyModel.h"
#define kArrorHeight        20

@implementation UPSCustomCalloutView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initViews];
        self.backgroundColor = UICOLOR_RGB(110, 188, 236, 0.8);
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)initViews{
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, self.width - 10, 20)];
//    self.nameLabel.backgroundColor = [UIColor redColor];
    [self addSubview:self.nameLabel];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *normal = [[UILabel alloc]initWithFrame:CGRectMake(5, 30, (self.width - 10) / 3, 20)];
    normal.text = @"正常";
    normal.textColor = [UIColor greenColor];
    [self addSubview:normal];
    
    self.normalLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 55, (self.width - 10) / 3, 20)];
    [self addSubview:self.normalLabel];
    self.normalLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *unknown = [[UILabel alloc]initWithFrame:CGRectMake(5 +(self.width - 10) / 3 , 30, (self.width - 10) / 3, 20)];
    unknown.text = @"未知";
    unknown.textColor = [UIColor grayColor];
    [self addSubview:unknown];
    
    self.unknownLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 +(self.width - 10) / 3 , 55, (self.width - 10) / 3, 20)];
    [self addSubview:self.unknownLabel];
    self.unknownLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *fault = [[UILabel alloc]initWithFrame:CGRectMake(5 +(self.width - 10) / 3 * 2, 30, (self.width - 10) / 3, 20)];
    fault.text = @"异常";
    fault.textColor = [UIColor redColor];
    [self addSubview:fault];
    
    self.faultLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 +(self.width - 10) / 3 * 2, 55, (self.width - 10) / 3, 20)];
    [self addSubview:self.faultLabel];
    self.faultLabel.textAlignment = NSTextAlignmentCenter;
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame = CGRectMake(5, 80, self.width - 10, 30);
//    [self.sureBtn setBackgroundColor:[UIColor orangeColor]];
    [self.sureBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.sureBtn setBackgroundColor:UICOLOR_RGB(33, 152, 216, 1)];
    [self addSubview:self.sureBtn];
   
}





////绘制弹出气泡的背景
//-(void)drawRect:(CGRect)rect{
//
//    //设置阴影
//    self.layer.shadowColor = [[UIColor whiteColor] CGColor];
//    self.layer.shadowOpacity = 1.0;
//    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
//
//
//    //绘图上下文
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 2.0);
//    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8].CGColor);
//    CGRect rrect = self.bounds;
//    CGFloat radius = 6.0;
//    CGFloat minx = CGRectGetMinX(rrect),
//    midx = CGRectGetMidX(rrect),
//    maxx = CGRectGetMaxX(rrect);
//    CGFloat miny = CGRectGetMinY(rrect),
//    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
//
//    //绘制路径
//    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
//    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
//    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
//
//    //绘制圆弧
//    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
//    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
//    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
//    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
//    CGContextClosePath(context);
//    CGContextFillPath(context);
//}



@end
