//
//  YHChartPieLayer.m
//  YHChart
//
//  Created by 林宁宁 on 2020/5/7.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHChartPieLayer.h"

@interface YHChartPieLayer()

/// 该layer渲染添加到的图层
@property (weak, nonatomic) UIView * renderView;

@property (retain, nonatomic) CAShapeLayer * pieLayer;

/// 标签视图
@property (retain, nonatomic) UILabel * annotationView;

@end

@implementation YHChartPieLayer

/// 图层渲染到该 视图上
- (void)randerPieAtView:(UIView *)renderView{
    
    self.renderView = renderView;
    
    [self clean];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        if(self.pieItem.percent){
            [self drawLineByPie:self.pieItem];
        }
    });
}

/// 重新渲染
- (void)reRenderingLayer{
    [self randerPieAtView:self.renderView];
}

- (void)drawLineByPie:(YHPieChartItem *)pie{
    
    [self clean];
    
    CGFloat planeWidth = CGRectGetWidth(self.renderView.frame);
    CGFloat planeHeight = CGRectGetHeight(self.renderView.frame);
    
    CGPoint center = CGPointMake(planeWidth*0.5, planeHeight*0.5);
    CGFloat radius = MIN(planeWidth, planeHeight) * 0.5;
    
    
    CGFloat startAngle = M_PI*2 * pie.startPos;
    CGFloat endAngle = M_PI*2 * pie.endPos;
    
    startAngle = startAngle - M_PI_2;
    endAngle = endAngle - M_PI_2;
    
    UIBezierPath * piePath = [UIBezierPath bezierPath];
    [piePath moveToPoint:center];
    [piePath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [piePath closePath];
    
    self.pieLayer = [CAShapeLayer new];
    self.pieLayer.strokeColor = [UIColor clearColor].CGColor;
    self.pieLayer.lineWidth = 0;
    self.pieLayer.fillColor = pie.filleColor.CGColor;
    self.pieLayer.path = piePath.CGPath;
    
    [self.renderView.layer addSublayer:self.pieLayer];
    
    /// 该弧度上点的坐标
    CGPoint(^CircleCorCenter)(CGFloat angle) = ^CGPoint(CGFloat angle) {
        CGFloat x2 = radius*cosf(angle*M_PI/180);
        CGFloat y2 = radius*sinf(angle*M_PI/180);
        return CGPointMake(center.x+x2, center.y-y2);
    };
    if(pie.showAnnotation){
        if(!self.annotationView){
            self.annotationView = [UILabel new];
            self.annotationView.textAlignment = NSTextAlignmentCenter;
            [self.renderView addSubview:self.annotationView];
        }
        self.annotationView.attributedText = pie.attString;
        
        CGFloat angleCenter = startAngle + (endAngle - startAngle)*0.5 - M_PI_2;
        CGPoint angleCenterPoint = CircleCorCenter(angleCenter);
        
        self.annotationView.backgroundColor = [UIColor redColor];
        self.annotationView.frame = CGRectMake(0, 0, 5, 5);
        self.annotationView.center = angleCenterPoint;
        
    }else{
        [self.annotationView removeFromSuperview];
        self.annotationView = nil;
    }
}


- (void)clean{
    
    [self.pieLayer removeFromSuperlayer];
    
    self.pieLayer = nil;
    
    [self.annotationView removeFromSuperview];
    self.annotationView = nil;
}

@end
