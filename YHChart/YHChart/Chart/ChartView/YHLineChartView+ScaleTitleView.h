//
//  YHLineChartView+ScaleTitleView.h
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/10.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHLineChartView.h"
#import "YHLineConstants.h"


NS_ASSUME_NONNULL_BEGIN

/// 刻度标题
@interface YHLineChartView (ScaleTitleView)

/// 更新刻度标题
- (void)updateScaleInfoAtPosition:(YHChartAxisPos)position;
/// X轴上 自动附加刻度标题
//- (void)autoAddScaleInfoInAxisXByItem:(YHScaleItem *)scale isBottom:(BOOL)isBottom;


@end

NS_ASSUME_NONNULL_END
