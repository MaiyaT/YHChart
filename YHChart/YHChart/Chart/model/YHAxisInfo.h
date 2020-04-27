//
//  YHAxisInfo.h
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/13.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHBaseObject.h"
#import "YHScaleItem.h"
#import "YHLineConstants.h"

NS_ASSUME_NONNULL_BEGIN

@class YHAxisElementInfo;

/// 坐标轴信息 
@interface YHAxisInfo : YHBaseObject

/// 刻度距离chart视图的距离 5
@property (assign, nonatomic) CGFloat titleSpaceAxis;

/// 坐标轴信息 四边
@property (retain, nonatomic) NSMutableArray <YHAxisElementInfo *> * axisList;

/// 获取该位置的坐标轴信息
@property (copy, nonatomic) YHAxisElementInfo *(^axisPos)(YHChartAxisPos axisPos);


/// 在只设置一个x轴和一个y轴的时候 设置多个可能有问题

/// 可用的 X轴 方向信息  若没有设置X轴坐标信息 会报错
@property (assign, nonatomic, readonly) YHChartAxisDirection axisDirectionX;
@property (assign, nonatomic, readonly) YHChartAxisDirection axisDirectionXOther;
/// 可用的 Y轴 方向信息 
@property (assign, nonatomic, readonly) YHChartAxisDirection axisDirectionY;
@property (assign, nonatomic, readonly) YHChartAxisDirection axisDirectionYOther;

/// X轴 信息
@property (retain, nonatomic, readonly) YHAxisElementInfo * axisInfoX;
@property (retain, nonatomic, readonly) YHAxisElementInfo * axisInfoXOther;
/// Y轴 信息
@property (retain, nonatomic, readonly) YHAxisElementInfo * axisInfoY;
@property (retain, nonatomic, readonly) YHAxisElementInfo * axisInfoYOther;


- (void)clean;

@end


@interface YHAxisElementInfo : YHBaseObject

/// 坐标轴上的 标题 刻度
/// 数值在这边进行排序
@property (retain, nonatomic, readonly) NSArray <YHScaleItem *>* list;

/// 坐标轴最大值
@property (assign, nonatomic) CGFloat maxValue;
/// 坐标轴最小值
@property (assign, nonatomic) CGFloat minValue;

/// 坐标轴根据刻度平分 不是根据实际值来设置刻度的位置
/// 设置坐标点 根据坐标点的值 换算他所在的位置信息
@property (assign, nonatomic) BOOL isDeuceByScale;


/// 显示标题的宽度
/// 如果宽度是0  则布局在坐标轴的内部
@property (assign, nonatomic) CGFloat titleWidth;

/// 坐标轴上的标题
@property (retain, nonatomic) UIView * titleView;

/// 坐标轴 线条颜色 #E9EBF0
@property (retain, nonatomic) UIColor * lineColor;

/// 坐标轴 线条宽度 0.5
@property (assign, nonatomic) CGFloat lineWidth;

/// 坐标轴的位置 是那一边的坐标
@property (assign, nonatomic) YHChartAxisPos axisPosition;

/// 坐标轴的方向
@property (assign, nonatomic) YHChartAxisDirection axisDirction;

/// 坐标轴 原点 方向  
//@property (assign, nonatomic) YHChartOriginCoorPos originCoorPos;


@property (assign, nonatomic, readonly) BOOL isAxisX;
@property (assign, nonatomic, readonly) BOOL isAxisY;

/// 坐标轴长度
@property (assign, nonatomic, readonly) CGFloat valueLength;

/// 坐标轴 自动新增时候 自动添加新增的刻度标题 步数大小  默认 5
@property (assign, nonatomic) CGFloat axisStep;


/// 与另外一条 成坐标系的 轴信息  双X Y轴的时候引用
@property (weak, nonatomic) YHAxisElementInfo * otherAxis;


/// 新增点 里面做排序操作
- (void)addScale:(YHScaleItem *)point;
- (void)addScaleList:(NSArray <YHScaleItem *>*)addList;

- (void)cleanScale;


@end

NS_ASSUME_NONNULL_END
