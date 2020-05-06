//
//  YHScaleItem.h
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/11.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHBaseObject.h"
#import "YHAxisFormatProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHScaleItem : YHBaseObject

@property (retain, nonatomic) NSAttributedString * attString;

/// 该标题对应的数值
@property (assign, nonatomic) CGFloat value;

/// 格式
@property (weak, nonatomic) id <YHAxisFormatProtocol> format;

+ (instancetype)att:(NSAttributedString *)att value:(CGFloat)value;
+ (instancetype)value:(CGFloat)value;

@end






NS_ASSUME_NONNULL_END
