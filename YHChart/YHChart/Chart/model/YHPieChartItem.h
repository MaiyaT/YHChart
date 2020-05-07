//
//  YHPieChartItem.h
//  YHChart
//
//  Created by 林宁宁 on 2020/5/7.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import "YHBaseObject.h"
#import "YHFormatProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHPieChartItem : YHBaseObject

@property (assign, nonatomic) CGFloat value;

@property (retain, nonatomic) UIColor * filleColor;

/// 百分比
@property (assign, nonatomic) CGFloat percent;

/// 开始百分比的位置
@property (assign, nonatomic) CGFloat startPos;

/// 结束百分比位置
@property (assign, nonatomic, readonly) CGFloat endPos;



@property (retain, nonatomic) NSAttributedString * attString;
/// 格式
@property (weak, nonatomic) id <YHFormatProtocol> format;


/// 该块信息显示
@property (assign, nonatomic) BOOL showAnnotation;

@property (assign, nonatomic) BOOL showAnnotationInside;


@end

NS_ASSUME_NONNULL_END
