//
//  YHLineConstants.h
//  YHChart
//
//  Created by 林宁宁 on 2020/4/27.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/// 坐标轴位置
typedef NS_ENUM(NSInteger, YHChartAxisPos) {
    YHChartAxisPos_Unknow   = 0,
    YHChartAxisPos_Top      = 1 << 0,
    YHChartAxisPos_Bottom   = 1 << 1,
    YHChartAxisPos_Left     = 1 << 2,
    YHChartAxisPos_Right    = 1 << 3,
};

/// 坐标轴方向 布局的方向
typedef NS_ENUM(NSInteger, YHChartAxisDirection) {
    YHChartAxisDirection_Unknow,
    /// Y轴 从上到下
    YHChartAxisDirection_TopToBottom = 1,
    /// Y轴 从下到上
    YHChartAxisDirection_BottomToTop,
    
    /// Y轴 从左到右
    YHChartAxisDirection_LeftToRight,
    /// Y轴 从右到左
    YHChartAxisDirection_RightToLeft,
};

/// 原点坐标位置
typedef NS_ENUM(NSInteger, YHChartOriginCoorPos) {
    
    YHChartOriginCoorPos_Unknow,
    
    YHChartOriginCoorPos_LeftDown,
    YHChartOriginCoorPos_LeftTop,
    YHChartOriginCoorPos_RightDown,
    YHChartOriginCoorPos_RightTop,
    
};


typedef NS_ENUM(NSUInteger, YHAxisType) {
    YHAxisTypeHorizontal,
    YHAxisTypeVertical
};


/// 表格显示类型
typedef NS_ENUM(NSUInteger, YHChartShowType) {
    YHChartShowType_Line,//折线
    YHChartShowType_Bar,//柱状图
    YHChartShowType_BarCombine,//柱状图合并成一条柱子
};

BOOL YHIsBarChart(YHChartShowType type);

/// 坐标轴刻度类型
typedef NS_ENUM(NSInteger, YHAxisScaleType) {
    /// 默认 坐标轴不平分 根据坐标轴的最大值和最小值来设置坐标点信息
    YHAxisScaleType_Normal,
    /// 坐标轴平分   根据设置的坐标轴的刻度来计算坐标点信息 每个刻度之间
    YHAxisScaleType_DeuceByScale,
    /// 坐标轴平分   坐标轴的刻按一个比例递增
    YHAxisScaleType_DeuceByStep,
};


CGFloat YHPointDist(CGPoint point1, CGPoint point2);




NS_ASSUME_NONNULL_BEGIN

@interface YHLineConstants : NSObject



@end

NS_ASSUME_NONNULL_END
