//
//  YHLineChartItem.h
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/11.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHBaseObject.h"
#import "YHLinePointItem.h"
#import "YHPointPickerConfig.h"
#import "YHLineConstants.h"

NS_ASSUME_NONNULL_BEGIN

/// 线条信息
@interface YHLineChartItem : YHBaseObject


/// 显示类型 默认为折线
@property (assign, nonatomic) YHChartShowType showType;


@property (retain, nonatomic) UIColor * lineColor;

// 1
@property (assign, nonatomic) CGFloat lineWidth;

// no
@property (assign, nonatomic) BOOL dotted;//虚线

/// 折现是平滑的 NO
@property (assign, nonatomic) BOOL smoothness;


@property (assign, nonatomic) BOOL lineShowShadow;

/// 阴影填充色
@property (retain, nonatomic) UIColor * lineShadowColorFill;
/// 阴影渐变 头部和底部颜色
@property (retain, nonatomic) UIColor * lineShadowColorTop;
@property (retain, nonatomic) UIColor * lineShadowColorBottom;

/// 自动平移动画
@property (assign, nonatomic) BOOL isAutoMoveAni;

/// 显示点 全部显示 要单独设置可以设置 dataList 里面的point
@property (assign, nonatomic) BOOL pointShow;

/// 显示坐标点数值信息 全部显示 要单独设置可以设置 dataList 里面的point
@property (assign, nonatomic) BOOL coordInfoViewShow;
/// 点坐标信息的toast  有设置使用该视图 没有使用默认的视图
@property (copy, nonatomic) UIView *(^coordInfoViewShowBlock)(YHLinePointItem * passPoint);


/// 1
@property (assign, nonatomic) CGFloat pointRadius;
@property (retain, nonatomic) UIColor * pointFillColor;
@property (retain, nonatomic) UIColor * pointLineColor;
@property (assign, nonatomic) CGFloat pointLineWidth;

/// 选中点信息 圆点信息 参考线 弹出提示等
/// 自动移动的表 不选中点
@property (retain, nonatomic, readonly) YHPointPickerConfig * pointPicker;

/// 折线上点的坐标信息 新增坐标之后要 根据布局的方式 排序
@property (retain, nonatomic, readonly) NSArray <YHLinePointItem *>* dataList;


/// 确定折线参考坐标轴的位置方向
/// 如果X和Y轴的坐标轴都只有一条 默认跟坐标轴的方向一致 如果坐标轴X或Y有两个 则需手动设置 默认最先设置的
/// 该线条坐标轴 X 方向
@property (assign, nonatomic, readonly) YHChartAxisDirection axisXDirection;
/// 该线条坐标轴 Y 方向
@property (assign, nonatomic, readonly) YHChartAxisDirection axisYDirection;
/// 坐标原点位置
@property (assign, nonatomic, readonly) YHChartOriginCoorPos originCoorPos;
/// 更新参考坐标的方向
- (void)updateLineReferenceAxisXDirection:(YHChartAxisDirection)axisXDirection axisYDirection:(YHChartAxisDirection)axisYDirection;

/// 有双X的时候 该线参考坐标X参考另外一条X轴坐标系
@property (assign, nonatomic) BOOL referXOther;
/// 有双Y的时候 该线参考坐标Y参考另外一条Y轴坐标系
@property (assign, nonatomic) BOOL referYOther;

/// 坐标轴 布局的方向 默认水平 做 在X轴方向上递增判断
@property (assign, nonatomic) YHAxisType axisType;



/// ======= 针对柱状图Bar模式下使用
/// 显示 偏移  多条情况
/// 柱状图 刻度点 跟线条的中心点偏移
/// 如果只有一条的时候 就是刻度点居中显示 多条则要调整布局
@property (assign, nonatomic) CGFloat barCenterToScaleOffset;
/// 改标注点对应的柱状图总宽度
/// 自动计算更新 不用手动设置
@property (assign, nonatomic) CGFloat barScaleTotalWidth;

/// 新增点 里面做排序操作
- (void)addPoint:(YHLinePointItem *)point;
- (void)addPointList:(NSArray <YHLinePointItem *>*)addList;

- (void)resetPointList:(NSArray <YHLinePointItem *>*)addList;

@end

NS_ASSUME_NONNULL_END
