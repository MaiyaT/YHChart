//
//  UIBezierPath+Smoothed.h
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/11.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 曲线 圆滑
@interface UIBezierPath (Smoothed)

+ (NSMutableArray *)pointsFromBezierPath:(UIBezierPath *)bezierPath;

- (UIBezierPath *)smoothedPathWithGranularity:(NSInteger)granularity maxY:(CGFloat)maxY minY:(CGFloat)minY;

@end

NS_ASSUME_NONNULL_END
