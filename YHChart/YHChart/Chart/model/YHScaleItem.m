//
//  YHScaleItem.m
//  MoreCoin
//
//  Created by 林宁宁 on 2020/4/11.
//  Copyright © 2020 MoreCoin. All rights reserved.
//

#import "YHScaleItem.h"

@implementation YHScaleItem

+ (instancetype)att:(NSMutableAttributedString *)att value:(CGFloat)value{
    YHScaleItem * item = [YHScaleItem new];
    item.attString = att;
    item.value = value;
    return item;
}


@end
