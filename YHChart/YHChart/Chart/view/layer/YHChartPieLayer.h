//
//  YHChartPieLayer.h
//  YHChart
//
//  Created by 林宁宁 on 2020/5/7.
//  Copyright © 2020 林宁宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHPieChartItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHChartPieLayer : NSObject

@property (retain, nonatomic) YHPieChartItem * pieItem;

/// 图层渲染到该 视图上
- (void)randerPieAtView:(UIView *)renderView;

/// 重新渲染
- (void)reRenderingLayer;

- (void)clean;

@end

NS_ASSUME_NONNULL_END
