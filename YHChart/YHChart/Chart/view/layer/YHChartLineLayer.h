//
//  YHChartLineLayer.h
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/11.
//  Copyright © 2020 MoreCoin. All rights reserved.
//


#import "YHLineChartItem.h"
#import "YHAxisInfo.h"

NS_ASSUME_NONNULL_BEGIN

/// 折线视图的图层
@interface YHChartLineLayer : NSObject

/// 坐标轴信息
@property (weak, nonatomic) YHAxisInfo * axisInfo;

/// 线条信息
@property (retain, nonatomic) YHLineChartItem * lineItem;


/// 图层渲染到该 视图上
- (void)randerAtView:(UIView *)renderView;

/// 添加多个 超出屏幕自动移动  移出屏幕的点要移除
- (void)addAutoMoveByPointList:(NSArray <YHLinePointItem *>*)pointList;

/// 选中的最接近的点和线  线不是当前线的信息 之前选中的layer清空
- (void)touchPickerNearestLine:(YHLineChartItem *)nearestLine nearestPoint:(YHLinePointItem *)nearestPoint;

/// 添加一个点 显示
//- (void)addPoint:(YHLinePointItem *)point;


/// 更新所有图层 shape 样式
- (void)updateLayersStyle;

/// 重新渲染
- (void)reRenderingLayer;

- (void)clean;
- (void)cleanPickerToast;

@end

NS_ASSUME_NONNULL_END
