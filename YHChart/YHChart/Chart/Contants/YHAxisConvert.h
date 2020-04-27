//
//  YHAxisConvert.h
//  YHChart
//
//  Created by 林宁宁 on 2020/4/27.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHAxisInfo.h"


NS_ASSUME_NONNULL_BEGIN

@interface YHAxisConvert : NSObject


/// 获取坐标轴位置信息
+ (YHAxisElementInfo *)queryAxis:(YHAxisInfo *)axisInfo
                           dirtX:(YHChartAxisDirection)dirtX
                           dirtY:(YHChartAxisDirection)dirtY
                         isAxisX:(BOOL)isAxisX;


/// 坐标点X 转 数值
+ (CGFloat)convertPointXToValue:(YHAxisElementInfo *)axisElement
                      axisWidth:(CGFloat)axisWidth
                         pointX:(CGFloat)pointX;

/// 坐标点Y 转 数值
+ (CGFloat)convertPointYToValue:(YHAxisElementInfo *)axisElement
                     axisHeight:(CGFloat)axisHeight
                         pointY:(CGFloat)pointY;


/// 数值 转 坐标点X
+ (CGFloat)convertValueXToPoint:(YHAxisElementInfo *)axisElement
                      axisWidth:(CGFloat)axisWidth
                         valueX:(CGFloat)valueX;

/// 数值 转 坐标点Y
+ (CGFloat)convertValueYToPoint:(YHAxisElementInfo *)axisElement
                     axisHeight:(CGFloat)axisHeight
                         valueY:(CGFloat)valueY;



/// 坐标点 转 数值坐标
+ (CGPoint)convertPointToValue:(YHAxisElementInfo *)axisElementX
                  axisElementY:(YHAxisElementInfo *)axisElementY
                    axisHeight:(CGFloat)axisHeight
                     axisWidth:(CGFloat)axisWidth
                         point:(CGPoint)point;

/// 数值坐标 转 坐标点
+ (CGPoint)convertValueToPoint:(YHAxisElementInfo *)axisElementX
                  axisElementY:(YHAxisElementInfo *)axisElementY
                    axisHeight:(CGFloat)axisHeight
                     axisWidth:(CGFloat)axisWidth
                         value:(CGPoint)value;


@end

NS_ASSUME_NONNULL_END
