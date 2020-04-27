//
//  YHLineConstants.m
//  YHChart
//
//  Created by 林宁宁 on 2020/4/27.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHLineConstants.h"

CGFloat YHPointDist(CGPoint point1, CGPoint point2){
    CGFloat xDist = point2.x - point1.x;
    CGFloat yDist = point2.y - point1.y;
    CGFloat distence = sqrt(xDist*xDist + yDist*yDist);
    return distence;
}


BOOL YHIsBarChart(YHChartShowType type){
    if(type == YHChartShowType_Bar ||
       type == YHChartShowType_BarCombine){
        return YES;
    }
    return NO;
}


@implementation YHLineConstants

@end
