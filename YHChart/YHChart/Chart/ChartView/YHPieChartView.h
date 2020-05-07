//
//  YHPieChartView.h
//  YHChart
//
//  Created by 林宁宁 on 2020/5/7.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHBaseView.h"
#import "YHPieChartItem.h"

NS_ASSUME_NONNULL_BEGIN


/// 饼图
@interface YHPieChartView : YHBaseView

/// 饼图图要绘制的视图
@property (strong, nonatomic, readonly) UIView * chartView;

/// 数据信息
@property (retain, nonatomic, readonly) NSMutableArray <YHPieChartItem *>* pieInfoList;

/// 圆环的背景色
@property (retain, nonatomic) UIColor * circleBgFillColor;
@property (retain, nonatomic) UIColor * circleTopFillColor;
/// 圆环的宽度 要大于0 并且小于圆环半径
@property (assign, nonatomic) CGFloat circleBorderWidth;
/// 中间圆环位置显示的标题内容信息
@property (retain, nonatomic) NSAttributedString * circleTopCenterAttTitle;


/// 新增一个饼图块 含有针对整个饼块的百分比信息
- (void)addPercentPieBlock:(YHPieChartItem *)pieItem;

- (void)deletePieBlock:(YHPieChartItem *)pieItem;

/// 通过给定的这些分块数据 重置饼图分布 每个块百分比信息这里面重新计算
- (void)resetPieAllBlock:(NSArray <YHPieChartItem *>*)pieList;


/// 数值比例信息显示
- (void)showAllAnnotation:(BOOL)show;
/// 标注点在是否内部显示
- (void)showAllAnnotationInside:(BOOL)inside;


- (void)clean;

@end

NS_ASSUME_NONNULL_END
