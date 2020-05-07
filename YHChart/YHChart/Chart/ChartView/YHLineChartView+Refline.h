//
//  YHLineChartView+Refline.h
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/17.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHLineChartView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHLineChartView()

@property (retain, nonatomic) NSMutableArray <YHReflineInfo *>* reflineList;
@property (retain, nonatomic) NSMutableArray <CAShapeLayer *>* reflineLayerList;

@end

@interface YHLineChartView (Refline)
 
/// 添加参考线
- (void)addReflineConfig:(void(^)(YHReflineInfo * refline))config;

/// X Y 轴上 添加所有 有设置Y轴的标题的参考线 先设置X 和 Y轴的刻度信息
- (void)addReflineAllAxisPos:(YHChartAxisPos)position config:(void(^_Nullable)(YHReflineInfo * refline))config;

/// 添加X和Y四边的轴线
- (void)addReflineAxisPosition:(YHChartAxisPos)position width:(CGFloat)width color:(UIColor *)color dotted:(BOOL)dot;


/// 重新渲染参考线
- (void)reRenderingReline;

@end

NS_ASSUME_NONNULL_END
