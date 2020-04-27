//
//  UIBezierPath+Smoothed.m
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/11.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "UIBezierPath+Smoothed.h"
#import "YHLineConstants.h"

@implementation UIBezierPath (Smoothed)


void getPointsFromBezier(void * info, const CGPathElement * element){
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    CGPathElementType type = element->type;
    CGPoint * points = element->points;
    
    if (type != kCGPathElementCloseSubpath) {
        [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
        if ((type != kCGPathElementAddLineToPoint) && (type != kCGPathElementMoveToPoint)) {
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[1]]];
        }
    }
    if (type == kCGPathElementAddCurveToPoint) {
        [bezierPoints addObject:[NSValue valueWithCGPoint:points[2]]];
    }
}

+ (NSMutableArray *)pointsFromBezierPath:(UIBezierPath *)bezierPath{
    NSMutableArray * points = [NSMutableArray array];
    CGPathApply(bezierPath.CGPath, (__bridge void *)points, getPointsFromBezier);
    return points.mutableCopy;
}

- (UIBezierPath *)smoothedPathWithGranularity:(NSInteger)granularity maxY:(CGFloat)maxY minY:(CGFloat)minY{
    NSMutableArray * points = [UIBezierPath pointsFromBezierPath:self];

    if (points.count < 4) {
        return [self copy];
    }
    
    [points insertObject:[points objectAtIndex:0] atIndex:0];
    [points addObject:[points lastObject]];
    
    UIBezierPath * smoothedPath = [self copy];
    [smoothedPath removeAllPoints];
    [smoothedPath moveToPoint:[(NSValue *)[points objectAtIndex:0] CGPointValue]];
    
    for (NSUInteger i = 1; i < points.count - 2; i++) {
        CGPoint p0 = [(NSValue *)[points objectAtIndex:i-1] CGPointValue];
        CGPoint p1 = [(NSValue *)[points objectAtIndex:i] CGPointValue];
        CGPoint p2 = [(NSValue *)[points objectAtIndex:i+1] CGPointValue];
        CGPoint p3 = [(NSValue *)[points objectAtIndex:i+2] CGPointValue];
        
        CGFloat dis1 = YHPointDist(p0, p1);
        CGFloat dis2 = YHPointDist(p2, p1);
        
        NSInteger particleCount = granularity;
        
        if(dis1 < 1 || dis2 < 1 || ABS(p1.x - p0.x) < 1 || ABS(p1.y - p0.y) < 1){
            particleCount = 2;
        }
        

        
        for (int i = 1; i < particleCount; i++)
        {
            float t = (float) i * (1.0f / (float) particleCount);
            float tt = t * t;
            float ttt = tt * t;
            
            CGPoint pi;
            pi.x = 0.5 * (2*p1.x+(p2.x-p0.x)*t + (2*p0.x-5*p1.x+4*p2.x-p3.x)*tt + (3*p1.x-p0.x-3*p2.x+p3.x)*ttt);
            pi.y = 0.5 * (2*p1.y+(p2.y-p0.y)*t + (2*p0.y-5*p1.y+4*p2.y-p3.y)*tt + (3*p1.y-p0.y-3*p2.y+p3.y)*ttt);
            
            pi.y = MAX(minY, pi.y);
            pi.y = MIN(maxY, pi.y);
            
            [smoothedPath addLineToPoint:pi];
        }
        
        [smoothedPath addLineToPoint:p2];
    }
    
    [smoothedPath addLineToPoint:[(NSValue *)[points objectAtIndex:points.count - 1] CGPointValue]];
    return smoothedPath;
}

@end
