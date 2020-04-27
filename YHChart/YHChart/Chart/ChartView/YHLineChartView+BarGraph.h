//
//  YHLineChartView+BarGraph.h
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/22.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHLineChartView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHLineChartView (BarGraph)


- (NSArray <YHLineChartItem *>*)getBarList;

- (NSArray <YHLineChartItem *>*)getBarCombineList;

- (NSArray <YHLineChartItem *>*)getLineList;



/// 同一个刻度下 多条柱状图 展开布局  根据刻度中心点 平分布局
/// @param contentMaxWidth 该刻度最大展示柱状图的宽度
/// @param barSpace 间隙
/// @param barWidth 柱状图的最大宽度 太多条的时候 根据内容宽度调整
- (void)barCenterOffsetUpdateByContentWidth:(CGFloat)contentMaxWidth barSpace:(CGFloat)barSpace barWidth:(CGFloat)barWidth;


/// 合并的柱状图 偏移值更新  更新之后再绘制图表
- (void)barCombineValueOffsetUpdate;

/// 该坐标点位置 所有柱状条合起来的宽度
//- (CGFloat)barSelectBgWidthAtScalePoint:(YHLinePointItem *)point;

@end

NS_ASSUME_NONNULL_END
