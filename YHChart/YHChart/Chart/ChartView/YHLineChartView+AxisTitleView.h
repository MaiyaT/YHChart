//
//  YHLineChartView+AxisTitleView.h
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/10.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHLineChartView.h"
#import "YHLineConstants.h"


NS_ASSUME_NONNULL_BEGIN

/// 刻度标题
@interface YHLineChartView (AxisTitleView)

/// 更新刻度标题
- (void)updateScaleInfoAtPosition:(YHChartAxisPos)position;

@end

NS_ASSUME_NONNULL_END
