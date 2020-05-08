//
//  YHChartPieLayer.m
//  YHChart
//
//  Created by 林宁宁 on 2020/5/7.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHChartPieLayer.h"
#import <Masonry.h>
#import "YHLineConstants.h"
#import "UIColor+YHStyle.h"

@interface YHChartPieLayer()

/// 该layer渲染添加到的图层
@property (weak, nonatomic) UIView * renderView;

@property (retain, nonatomic) CAShapeLayer * pieLayer;

/// 标签视图
@property (retain, nonatomic) UILabel * annotationView;

/// 跟标签的连线
@property (retain, nonatomic) NSMutableArray <CAShapeLayer *>* annotationLinkLineList;

@end

@implementation YHChartPieLayer

-(NSMutableArray<CAShapeLayer *> *)annotationLinkLineList{
    if(!_annotationLinkLineList){
        _annotationLinkLineList = [NSMutableArray new];
    }
    return _annotationLinkLineList;
}

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
    CGPoint(^CircleCorCenter)(CGFloat angle, CGFloat radiusCor) = ^CGPoint(CGFloat angle, CGFloat radiusCor) {
        int index = (angle)/M_PI_2;//用户区分在第几象限内
        float needAngle = angle - index*M_PI_2;//用于计算正弦/余弦的角度
        float x = 0,y = 0;
        switch (index) {
            case 0:
                x = center.x + sinf(needAngle)*radiusCor;
                y = center.y - cosf(needAngle)*radiusCor;
                break;
            case 1:
                x = center.x + cosf(needAngle)*radiusCor;
                y = center.y + sinf(needAngle)*radiusCor;
                break;
            case 2:
                x = center.x - sinf(needAngle)*radiusCor;
                y = center.y + cosf(needAngle)*radiusCor;
                break;
            case 3:
                x = center.x - cosf(needAngle)*radiusCor;
                y = center.y - sinf(needAngle)*radiusCor;
                break;
                
            default:
                break;
        }
        CGPoint centerPoint = CGPointMake(x, y);
        return  centerPoint;
    };
    
    CGFloat(^GetAnnoDis)(CGRect annRect, BOOL isFarest) = ^CGFloat(CGRect annRect, BOOL isFarest) {
        CGPoint p1 = CGPointMake(annRect.origin.x, annRect.origin.y);
        CGPoint p2 = CGPointMake(CGRectGetMaxX(annRect), annRect.origin.y);
        CGPoint p3 = CGPointMake(annRect.origin.x, CGRectGetMaxY(annRect));
        CGPoint p4 = CGPointMake(CGRectGetMaxX(annRect), CGRectGetMaxY(annRect));
        
        CGFloat dis1 = YHPointDist(p1, center);
        CGFloat dis2 = YHPointDist(p2, center);
        CGFloat dis3 = YHPointDist(p3, center);
        CGFloat dis4 = YHPointDist(p4, center);
        NSArray * arr = @[@(dis1),@(dis2),@(dis3),@(dis4)];
        if(isFarest){
            return [[arr valueForKeyPath:@"@max.floatValue"] doubleValue];
        }else{
            return [[arr valueForKeyPath:@"@min.floatValue"] doubleValue];
        }
    };
    
    if(pie.showAnnotation){
        if(!self.annotationView){
            self.annotationView = [UILabel new];
            self.annotationView.textAlignment = NSTextAlignmentCenter;
            [self.renderView.superview addSubview:self.annotationView];
        }
        self.annotationView.attributedText = pie.attString;
        
        CGFloat angleCenter = startAngle + (endAngle - startAngle)*0.5 + M_PI_2;
        //在圆弧上的中心点
        CGPoint angleCenterPoint = CircleCorCenter(angleCenter,radius*1);
        
        //先显示在这个中心点上
        [self.annotationView sizeToFit];
//        self.annotationView.frame = CGRectMake(0, 0, 5, 5);
        self.annotationView.center = angleCenterPoint;
        
        CGFloat offsetMax = GetAnnoDis(self.annotationView.frame, YES);
        
        //显示在内部 判断四顶点距离最远的往内移动
        if(pie.showAnnotationInside){
            CGFloat pRadius = offsetMax - radius;
            pRadius = radius - pRadius*1.5;
            CGPoint coorPoint = CircleCorCenter(angleCenter,pRadius);
            self.annotationView.center = coorPoint;
        }else{
            CGFloat pRadius = offsetMax - radius;
            CGFloat ppRadius = radius + ABS(pRadius*1.5);
            CGPoint coorPoint = CircleCorCenter(angleCenter,ppRadius);
            self.annotationView.center = coorPoint;
            
            ppRadius = GetAnnoDis(self.annotationView.frame, NO);
            CGPoint coorPointB = CircleCorCenter(angleCenter,ppRadius);
            UIBezierPath * path = [UIBezierPath bezierPath];
            [path moveToPoint:angleCenterPoint];
            [path addLineToPoint:coorPointB];
            
            CAShapeLayer * linkLine = [CAShapeLayer new];
            linkLine.lineWidth = 0.5;
            linkLine.strokeColor = [UIColor yh_black].CGColor;
            linkLine.path = path.CGPath;
            [self.renderView.layer addSublayer:linkLine];
            
            [self.annotationLinkLineList addObject:linkLine];
        }
        
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
    
    [self.annotationLinkLineList makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.annotationLinkLineList removeAllObjects];
}

@end
