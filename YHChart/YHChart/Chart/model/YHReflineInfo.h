//
//  YHReflineInfo.h
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/13.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

/// 参考线信息
@interface YHReflineInfo : YHBaseObject

/// 显示参考线 水平的 要设置 axisYValue 值
@property (assign, nonatomic) BOOL showHorizontal;
/// 显示参考线 垂直的 要设置 axisXValue 值
@property (assign, nonatomic) BOOL showVertical;

@property (assign, nonatomic) CGFloat axisXValue;
@property (assign, nonatomic) CGFloat axisYValue;

/// 参考线是否虚线 NO
@property (assign, nonatomic) BOOL isDotted;

/// 参考线颜色 #E9EBF0
@property (retain, nonatomic) UIColor * lineColor;
/// 参考线高度 0.5
@property (assign, nonatomic) CGFloat lineHeight;


@end

NS_ASSUME_NONNULL_END
