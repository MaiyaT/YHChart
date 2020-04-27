//
//  YHShapeLayer.h
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/26.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHShapeLayer : CAShapeLayer

#pragma mark - path 路径点信息
/// 圆形路径的中心点
@property (assign, nonatomic) CGPoint arcCenter;


@end

NS_ASSUME_NONNULL_END
