//
//  YHLinePointItem.h
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/11.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHLinePointItem : YHBaseObject

@property (copy, nonatomic) NSString * content;

/// 该点对应 坐标轴的 标题显示
@property (retain, nonatomic) NSMutableAttributedString * axisXAttTitle;
@property (retain, nonatomic) NSMutableAttributedString * axisYAttTitle;

/// 数 坐标
@property (assign, nonatomic) CGFloat valueX;
@property (assign, nonatomic) CGFloat valueY;


@property (assign, nonatomic) BOOL showPoint;

/// 显示坐标点信息视图 固定居中上方显示
@property (assign, nonatomic) BOOL coordInfoViewShow;


/// ======= 针对柱状图BarCombine模式下使用
/// 多条柱状图拼接成一条柱状图
/// 当前柱状图的起点和终点坐标点 要加上他前一条柱状图位置信息
/// 添加该柱状图的时候 自动计算更新 不用手动设置
@property (assign, nonatomic) CGFloat barCombineValueOffset;



+ (instancetype)valueX:(CGFloat)valueX valueY:(CGFloat)valueY;
+ (instancetype)valueX:(CGFloat)valueX valueY:(CGFloat)valueY showPoint:(BOOL)show;

@end



@interface YHScaleItemPrice : YHLinePointItem

@end


NS_ASSUME_NONNULL_END
