//
//  YHScaleItem.h
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/11.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHBaseObject.h"


NS_ASSUME_NONNULL_BEGIN

@interface YHScaleItem : YHBaseObject

@property (retain, nonatomic) NSMutableAttributedString * attString;

/// 该标题对应的数值
@property (assign, nonatomic) CGFloat value;

+ (instancetype)att:(NSMutableAttributedString *)att value:(CGFloat)value;


@end






NS_ASSUME_NONNULL_END
