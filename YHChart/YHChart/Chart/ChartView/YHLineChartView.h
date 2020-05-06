//
//  YHLineChartView.h
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/9.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHBaseView.h"

#import "YHScaleItem.h"
#import "YHLineChartItem.h"
#import "YHAxisInfo.h"
#import "YHReflineInfo.h"

#import "YHLineConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHLineChartView : YHBaseView


/// 折现图要绘制的视图
@property (strong, nonatomic, readonly) UIView * chartView;

/// 折线条数
@property (assign, nonatomic, readonly) NSInteger lineLayerCount;

/// 坐标轴信息 x: 0-100  y: 0-100
@property (retain, nonatomic, readonly) YHAxisInfo * axisInfo;

/// 所有折线信息
@property (retain, nonatomic, readonly) NSMutableArray <YHLineChartItem *>* lineInfoList;


/// 坐标轴信息 添加或者更新
/// @param scaleList 刻度信息
/// @param width 坐标轴刻度标题显示宽度大小 可为0 为0 刻度信息显示在坐标轴内部
/// @param position 坐标轴位置
/// @param dirction 坐标轴 值的方向
- (void)updateAxisScaleList:(NSArray <YHScaleItem *>*)scaleList
                      width:(CGFloat)width
                   position:(YHChartAxisPos)position
                   dirction:(YHChartAxisDirection)dirction;

- (void)updateAxisAutoScaleCount:(NSInteger)scaleCount
                       pointList:(NSArray <YHLinePointItem *>*)pointList
                          format:(id<YHAxisFormatProtocol>)format
                           width:(CGFloat)width
                        position:(YHChartAxisPos)position
                        dirction:(YHChartAxisDirection)dirction
                          config:(void(^_Nullable)(YHAxisElementInfo * axisInfo))config;

- (void)updateAxisScaleList:(NSArray <YHScaleItem *>*)scaleList
                      width:(CGFloat)width
                   position:(YHChartAxisPos)position
                   dirction:(YHChartAxisDirection)dirction
                     config:(void(^_Nullable)(YHAxisElementInfo * axisInfo))config;


/// 这个画布上新增一条折线
- (void)addLineChart:(YHLineChartItem *)lineItem;
/// 更新某一条折线数据
- (void)updateLineChart:(YHLineChartItem *)lineItem;
/// 更新某一条折线数据 不重新绘制 改变颜色 粗细 样式之类  坐标点数值没有变化 
- (void)updateLineChartUnRelayout:(YHLineChartItem *)lineItem;

/// 删除某一条折线数据
- (void)removeLineChart:(YHLineChartItem *)lineItem;

/// 或者第几条折线 信息
- (YHLineChartItem *)getLineChartIndex:(NSInteger)index;




/// 某条折线上 动态新增点 如果点在屏幕右侧超出 屏幕的时候 自动向左移动
/// 实时添加变化时候使用
- (void)addAutoMoveByPointList:(NSArray <YHLinePointItem *>*)pointList lineInfoAtLine:(NSInteger)index;


/// 清空所有信息
- (void)clean;

@end

NS_ASSUME_NONNULL_END
